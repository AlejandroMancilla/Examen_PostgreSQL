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

-- POBLACIÓN DE TABLAS
INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- CONSULTAS SOBRE UNA TABLA
-- Consulta 1:
SELECT * FROM pedido ORDER BY fecha DESC;

-- Consulta 2:
SELECT * FROM pedido ORDER BY total DESC LIMIT 2;

-- Consulta 3: 
SELECT DISTINCT id_cliente FROM pedido;

-- Consulta 4:
SELECT * FROM pedido WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31' AND total>500;

-- Consulta 5:
SELECT nombre || ' ' || apellido1 || ' ' || apellido2 FROM comercial WHERE comisión BETWEEN 0.05 AND 0.11;

-- Consulta 6:
SELECT MAX(comisión) FROM comercial;

-- Consulta 7:
SELECT id, nombre, apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1, nombre;

-- Consulta 8:
SELECT nombre FROM cliente WHERE nombre ILIKE 'a%' AND nombre ILIKE '%n' OR nombre ILIKE 'p%' ORDER BY nombre ASC;

-- Consulta 9:
SELECT nombre FROM cliente WHERE nombre NOT ILIKE 'a%' ORDER BY nombre ASC;

-- Consulta 10:
SELECT DISTINCT nombre FROM comercial WHERE nombre ILIKE '%el' OR nombre ILIKE '%o' ORDER BY nombre ASC;

-- CONSULTAS MULTITABLA 
-- Consulta 1:
SELECT DISTINCT C.id, (C.nombre || ' ' || C.apellido1) AS Name FROM cliente C INNER JOIN pedido P ON C.id = P.id_cliente ORDER BY Name ASC;

-- Consulta 2:
SELECT * FROM pedido P INNER JOIN cliente C ON P.id_cliente = C.id ORDER BY C.nombre ASC;

-- Consulta 3:
SELECT * FROM pedido P INNER JOIN comercial C ON P.id_comercial = C.id ORDER BY C.nombre ASC;

-- Consulta 4:
SELECT * FROM cliente C INNER JOIN pedido P ON P.id_cliente = C.id INNER JOIN comercial K ON K.id = P.id_comercial ORDER BY K.nombre ASC;

-- Consulta 5:
SELECT * FROM cliente C INNER JOIN pedido P ON P.id_cliente = C.id WHERE EXTRACT(year FROM P.fecha) = 2017 AND total BETWEEN 300 AND 1000;

-- Consulta 6:
SELECT DISTINCT K.nombre, K.apellido1, K.apellido2 FROM comercial K INNER JOIN pedido P ON K.id = P.id_comercial INNER JOIN cliente C ON C.id = P.id_cliente WHERE (C.nombre || ' ' || C.apellido1 || ' ' || C.apellido2) = 'María Santana Moreno';

-- Consulta 7:
SELECT DISTINCT C.nombre, C.apellido1, C.apellido2 FROM comercial K 
INNER JOIN pedido P ON K.id = P.id_comercial 
INNER JOIN cliente C ON C.id = P.id_cliente 
WHERE (K.nombre || ' ' || K.apellido1 || ' ' || K.apellido2) = 'Daniel Sáez Vega';

-- CONSULTAS MULTITABLA 
-- Consulta 1:
SELECT * FROM cliente C 
LEFT JOIN pedido P ON C.id = P.id_cliente 
ORDER BY C.apellido1, C.apellido2, C.nombre ASC;

-- Consulta 2:
SELECT * FROM comercial C 
LEFT JOIN pedido P ON C.id = P.id_cliente 
ORDER BY C.apellido1, C.apellido2, C.nombre ASC;

-- Consulta 3:
SELECT C.* FROM cliente C 
LEFT JOIN pedido P ON C.id = P.id_cliente 
WHERE P.id IS NULL;

-- Consulta 4:
SELECT C.* FROM comercial C 
LEFT JOIN pedido P ON C.id = P.id_comercial 
WHERE P.id IS NULL;

-- Consulta 5:
SELECT CONCAT(C.apellido1, ' ', C.apellido2, ' ', C.nombre, ' (Cliente)') AS Resultado
FROM cliente C LEFT JOIN pedido P ON C.id = P.id_cliente
WHERE P.id_cliente IS NULL
UNION
SELECT CONCAT(K.apellido1, ' ', K.apellido2, ' ', K.nombre, ' (Comercial)') AS Resultado
FROM pedido P RIGHT JOIN comercial K ON K.id = P.id_comercial
WHERE P.id_comercial IS NULL
ORDER BY Resultado;

-- CONSULTAS RESUMEN
-- Consulta 1:
SELECT SUM(total) FROM pedido;

-- Consulta 2:
SELECT AVG(total) FROM pedido;

-- Consulta 3:
SELECT COUNT(DISTINCT id_comercial) FROM pedido;

-- Consulta 4:
SELECT COUNT(*) FROM cliente;

-- Consulta 5:
SELECT MAX(total) FROM pedido;

-- Consulta 6:
SELECT MIN(total) FROM pedido;

-- Consulta 7:
SELECT ciudad, MAX(categoria)
FROM cliente 
GROUP BY ciudad;

-- Consulta 8:
SELECT COUNT(P.fecha), C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
FROM pedido P
INNER JOIN cliente C ON P.id_cliente = C.id
GROUP BY C.id, P.fecha;

-- Consulta 9:
SELECT COUNT(P.fecha), C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
FROM pedido P
INNER JOIN cliente C ON P.id_cliente = C.id
GROUP BY C.id, P.fecha
HAVING MAX(P.total) > 2000;

-- Consulta 10
SELECT C.id, C.nombre, C.apellido1, C.apellido2, MAX(P.total)
FROM pedido P
INNER JOIN comercial C ON P.id_comercial = C.id
WHERE fecha = '2016-08-17'
GROUP BY C.id;

-- Consulta 11:
SELECT C.id, C.nombre, C.apellido1, C.apellido2, COUNT(P.id_cliente)
FROM pedido P
RIGHT JOIN cliente C
ON P.id_cliente = C.id
GROUP BY C.id, P.id_cliente;

-- Consulta 12:
SELECT C.id, C.nombre, C.apellido1, C.apellido2, COUNT(P.id_cliente)
FROM pedido P
RIGHT JOIN cliente C
ON P.id_cliente = C.id
WHERE EXTRACT(year FROM P.fecha) = 2017
GROUP BY C.id, P.id_cliente;

-- Consulta 13:
SELECT C.id, C.nombre, C.apellido1, COALESCE(MAX(P.total), 0)
FROM pedido P
RIGHT JOIN cliente C
ON P.id_cliente = C.id
GROUP BY C.id, P.id_cliente;

-- Consulta 14:
SELECT MAX(P.total), EXTRACT(year FROM P.fecha)
FROM pedido P
GROUP BY EXTRACT(year FROM P.fecha)
ORDER BY EXTRACT(year FROM P.fecha) DESC;

-- Consulta 15:
SELECT COUNT(P.total), EXTRACT(year FROM P.fecha)
FROM pedido P
GROUP BY EXTRACT(year FROM P.fecha)
ORDER BY EXTRACT(year FROM P.fecha) DESC;

-- CON OPERADORES BÁSICOS DE COMPARACIÓN
-- Consulta 1:
SELECT * 
FROM pedido P
WHERE P.id_cliente = (SELECT C.id 
                      FROM cliente C
                      WHERE C.nombre = 'Adela' AND C.apellido1 = 'Salas' AND C.apellido2 = 'Díaz');
					  
-- Consulta 2:
SELECT COUNT(*) 
FROM pedido P
WHERE P.id_cliente = (SELECT C.id 
                      FROM comercial C
                      WHERE C.nombre = 'Daniel' AND C.apellido1 = 'Sáez' AND C.apellido2 = 'Vega');
					  
-- Consulta 3:
SELECT C.*
FROM pedido P, cliente C
WHERE P.id_cliente = C.id AND P.total = (SELECT MAX(P.total)
                                         FROM pedido P
                                         WHERE EXTRACT(year FROM P.fecha) = '2019');
										 
-- Consulta 4:
SELECT fecha, total
FROM pedido
WHERE id_cliente = (SELECT id_cliente
    				FROM cliente
    				WHERE nombre = 'Pepe')
	   AND total = (SELECT MIN(total)
    				FROM pedido
    				WHERE id_cliente = (SELECT id_cliente
										FROM cliente
										WHERE nombre = 'Pepe')
);

-- Consulta 5:
SELECT *
FROM cliente C INNER JOIN pedido P ON C.id = P.id_cliente
WHERE EXTRACT(year FROM P.fecha) = '2017' AND P.total >= (SELECT AVG(p.total)
                                             			  FROM pedido p
                                             			  WHERE EXTRACT(year FROM P.fecha) = '2017');
														  
-- SUBCONSULTAS CON ALL Y ANY
-- Consulta 1:
SELECT *
FROM pedido P
WHERE P.total >= ALL(SELECT MAX(P.total)
                     FROM pedido P);

-- Consulta 2:
SELECT C.*
FROM cliente C
WHERE C.id <> ALL(SELECT DISTINCT P.id_cliente
                  FROM pedido P);

-- Consulta 3:
SELECT C.*
FROM comercial C
WHERE C.id <> ALL(SELECT DISTINCT P.id_comercial
                  FROM pedido P);

-- SUBCONSULTAS CON IN Y NOT IN
-- Consulta 1:
SELECT C.*
FROM cliente C
WHERE C.id NOT IN (SELECT DISTINCT P.id_cliente
                   FROM pedido P);

-- Consulta 2:
SELECT C.*
FROM comercial C
WHERE C.id NOT IN (SELECT DISTINCT P.id_comercial
                   FROM pedido P);
				   
-- SUBCONSULTAS CON EXISTS Y NOT EXISTS
-- Consulta 1:
SELECT *
FROM cliente C
WHERE NOT EXISTS (SELECT P.id_cliente 
                  FROM pedido P
                  WHERE C.id = P.id_cliente);
				  
-- Consulta 2:
SELECT *
FROM comercial C
WHERE NOT EXISTS (SELECT P.id_comercial
                  FROM pedido P
                  WHERE C.id = P.id_comercial);