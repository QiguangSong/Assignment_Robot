import sqlite3


DB_FILE = 'payments.db'

QUERIES = [
"""DROP TABLE IF EXISTS payments;""",

"""DROP TABLE IF EXISTS currency;""",

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

"""INSERT INTO payments (purchase, user, amount, currency, completed) VALUES (12345, "john", 12.5, "EUR", 1);""",

"""INSERT INTO currency (name, rate) VALUES ("USD", 0.84), ("GBP", 0.89), ("EUR", 1.0);""",
]


def reset(db_file=DB_FILE):
    conn = sqlite3.connect(db_file)
    cur = conn.cursor()
    for query in QUERIES:
        cur.execute(query)
    conn.commit()
    cur.close()
    conn.close()


def query(query, db_file=DB_FILE):
    conn = sqlite3.connect(db_file)
    cur = conn.cursor()
    result = cur.execute(query).fetchall()
    cur.close()
    conn.close()
    return result


def execute(query, db_file=DB_FILE):
    conn = sqlite3.connect(db_file)
    cur = conn.cursor()
    result = cur.execute(query).rowcount
    conn.commit()
    cur.close()
    conn.close()
    return result
