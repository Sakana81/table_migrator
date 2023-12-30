# ParmaMigrator
## Установка зависимостей
Необходимо установить python 3.10, далее переходим в папку с файлами с этого репозитория и прописываем в CMD/PowerShell:

```powershell
pip install -r requirements.txt
```

## Пример использования скрипта

```powershell
python main.py --mtp=all-MigrationDB1.xlsx --src=postgresql://postgres:postgres@localhost:5434/backup1 --dst=postgresql://postgres:postgres@localhost:5434/new
```

### Помощь (сделал на английском по привычке)

```powershell
python main.py --help
```

### Параметры

- mtp - (migration file path) путь до файла с таблицей миграции в формате:

  | SourceSchema | SourceTable | SourceSelect | SourceColumns | TargetSchema | TargetTable | TargetColumns |
  | - | - | - | - | - | - | - |
  
  - **SourceSelect** может содержать запрос к связанным таблицам для заполнения таблицы в конечной БД прим.:
  
  ```SQL
  select t_wood_floor.primarykey, t_wood_floor.trunk_count, t_wood_floor.age, t_wood_floor.hight, t_wood_floor.evaluation, t_wood_floor.stand from public.t_wood_floor
  inner join public.t_breed_wood_floor on t_wood_floor.primarykey = t_breed_wood_floor.wood_floor
  where t_wood_floor.type_floor = '52aebf9b-0d14-4979-89f9-97c3cba7e817'
  ```

- src - (source) адрес исходной базы данных (из которой переносим) в формате:
```postgresql://<Логин>:<Пароль>@<Хост>:<Порт>/<Название БД>```

- dst - (destionation) адрес конечной базы данных (куда переносим) в формате:
```postgresql://<Логин>:<Пароль>@<Хост>:<Порт>/<Название БД>```

## Вывод
В консоль выводится список перенесенных таблиц, в формате:

```<Название таблицы> migrated successfully``` 

По окончанию переноса выводится сообщение:

```Migration done!```
