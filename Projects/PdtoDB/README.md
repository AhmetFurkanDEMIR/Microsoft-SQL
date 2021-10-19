![](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) ![](https://img.shields.io/badge/Pandas-2C2D72?style=for-the-badge&logo=pandas&logoColor=white) ![](https://img.shields.io/badge/Numpy-777BB4?style=for-the-badge&logo=numpy&logoColor=white) ![](https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)

# Moving the .csv file to Microsoft SQL Server

This code script (framework) creates a new table in the database according to the columns in your .csv file, then writes the data in the .csv file to this table.

You can use the code framework as under, provided it is in the same location as [pdmssql.py](/Projects/PdtoDB/pdmssql.py) ⬇

```python
# frameworks
import pandas as pd
import pyodbc

# framework writer @AhmetFurkanDEMIR
import pdmssql

# databse connect
conn = pyodbc.connect(driver='{ODBC Driver 17 for SQL Server}',
                      server='localhost',
                      database='CSVtoDB',
                      uid='SA', pwd='demiraiAI1881')
cur = conn.cursor()

# read csv data
dataCSV = pd.read_csv("amazon_prime_titles.csv")

# pdmssql.PdMSSQL(pymssql.connect(), conn.cursor(), fast_executemany, pd.read_csv("name.csv"), "TableName")
pdmssql.PdMSSQL(conn, cur, False, dataCSV, "AmazonPrime")
```

For example, according to the [amazon_prime_titles.csv](/Projects/PdtoDB/amazon_prime_titles.csv) file, the code will run the following sql codes ⬇

```sql
CREATE TABLE AmazonPrime(
	show_id Text,
	type Text,
	title Text,
	director Text,
	cast Text,
	country Text,
	date_added Text,
	release_year INT,
	rating Text,
	duration Text,
	listed_in Text,
	description Text);

INSERT INTO AmazonPrime VALUES(?,?,?,?,?,?,?,?,?,?,?,?);
```

The code reads all lines and writes to Microsoft SQL server, you can see an example in the photo below ⬇

![Screenshot_2021-10-19_13-11-00](https://user-images.githubusercontent.com/54184905/137894669-237174dd-07a2-49fb-bd26-647b30e3bac4.png)

After this example I made, you can take a look at the [CsvToDbQuerys.sql](/Projects/PdtoDB/CsvToDbQuerys.sql) codes that I worked as a training.
