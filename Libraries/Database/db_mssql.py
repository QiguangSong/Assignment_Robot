# -*- coding: utf-8 -*-
"""

@author: qsong
"""
import pyodbc

QUERIES = [

    """
        IF OBJECT_ID (N'dbo.payments', N'U') IS NOT NULL
        BEGIN
            drop table payments
        END
    """,
    """
        IF OBJECT_ID (N'dbo.currency', N'U') IS NOT NULL
        BEGIN
            drop table currency
        END
    """,

    """CREATE TABLE "payments" (
        "id"	INTEGER,
        "purchase"	INTEGER,
        "user"	TEXT,
        "amount"	REAL,
        "currency"	TEXT,
        "completed"	INTEGER,
        PRIMARY KEY("id")
    );""",

    """CREATE TABLE "currency" (
        "id"	INTEGER,
        "name"	TEXT,
        "rate"	REAL,
        PRIMARY KEY("id")
    );""",

    """INSERT INTO payments([id],[purchase],[user],[amount],[currency],[completed]) 
        VALUES (001,12345, 'john', 12.5, 'EUR', 1);""",

    """INSERT INTO currency ([id],[name], [rate]) VALUES (001,'USD', 0.84), (002,'GBP', 0.89), (003,'EUR', 1.0);""",
]

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=XXXXXX;'
                      'Database=testdb;'
                      'Trusted_Connection=yes;')

cursor = conn.cursor()
for query in QUERIES:
    cursor.execute(query)
conn.commit()
cursor.close()
conn.close()

