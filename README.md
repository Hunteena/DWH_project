# Проектная работа по модулю "DWH"
Состав:
1.  [project.sql](https://github.com/Hunteena/DWH_project/blob/main/project.sql) - создание таблиц фактов и измерений,
1.  [dimensions.ktr](https://github.com/Hunteena/DWH_project/blob/main/dimensions.ktr) - заполнение таблиц измерений,
1.  [fact_flights.ktr](https://github.com/Hunteena/DWH_project/blob/main/fact_flights.ktr) - заполнение таблицы фактов,
1.  [documentation.pdf](https://github.com/Hunteena/DWH_project/blob/main/documentation.pdf) - описание ETL- процессов.


Для подключения к базе данных в Pentaho Data Integration используются переменные окружения:
* DB_NAME_AVIA    - название базы данных,
* DB_HOST        - хост,
* DB_PORT        - порт,
* DB_USER        - имя пользователя,
* DB_PASSWORD    - пароль.
