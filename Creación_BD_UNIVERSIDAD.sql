-- CREACIÓN - BD_UNIVERSIDAD
DROP DATABASE IF EXISTS bd_universidad;
CREATE DATABASE bd_universidad;
CREATE TABLE cliente (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido1 VARCHAR(100) NOT NULL,
  	apellido2 VARCHAR(100),
  	ciudad VARCHAR(100),
	categoria INTEGER CHECK (categoria > 0)
);

CREATE TABLE comercial (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
  	apellido1 VARCHAR(100) NOT NULL,
  	apellido2 VARCHAR(100),
  	comisión FLOAT
);

CREATE TABLE pedido (
	id SERIAL PRIMARY KEY,
	total FLOAT NOT NULL,
	fecha DATE,
	id_cliente INTEGER REFERENCES cliente(id),
	id_comercial INTEGER REFERENCES comercial(id)
);
