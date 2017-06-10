DROP TABLE transactions;
DROP TABLE users;

CREATE TABLE users (
id SERIAL8 PRIMARY KEY,
first_name VARCHAR(255), 
last_name VARCHAR(255), 
budget INT8
);

CREATE TABLE transactions (
id SERIAL8 PRIMARY KEY,
merchant VARCHAR(255),
tag VARCHAR (255),
cost INT8
);