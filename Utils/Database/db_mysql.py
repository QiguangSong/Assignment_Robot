import pymysql

QUERIES = [
"""DROP TABLE IF EXISTS payments;""",

"""DROP TABLE IF EXISTS currency;""",

"""CREATE TABLE payments (
	id	INTEGER,
	purchase	INTEGER,
	user	TEXT,
	amount	REAL,
	currency	TEXT,
	completed	INTEGER,
	PRIMARY KEY(id)
);""",

"""CREATE TABLE currency (
	id	INTEGER,
	name	TEXT,
	rate	REAL,
	PRIMARY KEY(id)
);""",

"""INSERT INTO payments (purchase, user, amount, currency, completed) VALUES (12345, "john", 12.5, "EUR", 1);""",

"""INSERT INTO currency (name, rate) VALUES ("USD", 0.84), ("GBP", 0.89), ("EUR", 1.0);""",
]

