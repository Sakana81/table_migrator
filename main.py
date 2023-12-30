import argparse

import datetime
import decimal

import numpy as np
import psycopg2
import pandas as pd


def cmdParser():
    parser = argparse.ArgumentParser(description='Example of usage: \npython main.py --mtp=all-MigrationDB1.xlsx '
                                                 '--src=postgresql://postgres:postgres@localhost:5434/backup1 '
                                                 '--dst=postgresql://postgres:postgres@localhost:5434/new')
    parser.add_argument(
        '--mtp',
        type=str,
        help='absolute migration table path'
    )
    parser.add_argument(
        '--src',
        type=str,
        help='old db location in format postgresql://<login>:<password>@<host>:<port>/<dbname>'
             '\nexample: postgresql://postgres:postgres@localhost:5434/old_db'
    )
    parser.add_argument(
        '--dst',
        type=str,
        help='new db location in format postgresql://<login>:<password>@<host>:<port>/<dbname>'
             '\nexample: postgresql://postgres:postgres@localhost:5434/new_db'
    )
    my_namespace = parser.parse_args()
    return my_namespace.mtp, my_namespace.src, my_namespace.dst


def transformColumns(columns: str) -> str:
    """
    Returns escaped sequence of columns to fetch from
    """
    columns_list = str(columns).split(",")
    return ''.join(['"{}",'.format(c.strip()) for c in columns_list])[:-1]


def transformEntry(entry: tuple) -> str:
    """
    Returns escaped and filtered table entry as string
    """
    entry = list(entry)
    for i, cell in enumerate(entry):
        if type(cell) is decimal.Decimal or type(cell) is datetime.date:
            entry[i] = str(cell)
    return ', '.join("'{}'".format(str(a)) for a in entry).replace("'None'", 'NULL')


def main():
    table_path, old_db, new_db = cmdParser()
    migration_table = np.array(pd.read_excel(table_path, sheet_name=0, header=0))

    connection_old_db = psycopg2.connect(old_db)
    connection_new_db = psycopg2.connect(new_db)

    insert_query_template = 'INSERT INTO {0}.{1} ({2}) VALUES ({3})'

    for swap in migration_table:
        with connection_old_db, connection_new_db:
            cursor_old = connection_old_db.cursor()
            cursor_new = connection_new_db.cursor()

            source_schema = swap[0]
            source_table = swap[1]
            source_select = swap[2]
            source_columns = transformColumns(swap[3])
            target_schema = swap[4]
            target_table = swap[5]
            target_columns = transformColumns(swap[6])

            if type(source_select) is str:
                query = source_select
            else:
                query = f'SELECT {source_columns} FROM {source_schema}.{source_table}'

            cursor_old.execute(query)
            data = cursor_old.fetchall()
            for entry in data:
                insert_query = insert_query_template.format(target_schema,
                                                            target_table,
                                                            target_columns,
                                                            transformEntry(entry))
                try:
                    cursor_new.execute(insert_query)
                    connection_new_db.commit()
                except psycopg2.errors.UniqueViolation:
                    connection_new_db.rollback()
                except psycopg2.errors.ForeignKeyViolation:
                    # print(insert_query)
                    connection_new_db.rollback()
            print(f'{target_schema}.{target_table} migrated successfully')
    print('Migration done!')


if __name__ == '__main__':
    main()
