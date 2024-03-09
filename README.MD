# EXAMEN - POSTGRESQL
## <span style="color:red; text-decoration:underline">Creación de la BD</span>
    ```sql
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
    ```

## <span style="color:red; text-decoration:underline">Población de la BD</span>
```sql
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
    ```
## <span style="color:red; text-decoration:underline">Consultas sobre una tabla</span>

1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
    ```sql
    SELECT * FROM pedido ORDER BY fecha DESC;
    ```

    |id |total  |fecha     |id_cliente|id_comercial|
    |:-:|:-----:|:--------:|:--------:|:----------:|
    |2  |270.65 |2016-09-10|    1     |     5      |
    |15 |370.85 |2019-03-11|    1     |     5      |
    |16 |2389.23|2019-03-11|    1     |     5      |


2. Devuelve todos los datos de los dos pedidos de mayor valor.
    ```sql
    SELECT * FROM pedido ORDER BY total DESC LIMIT 2;
    ```

    |id |total |fecha     |id_cliente|id_comercial|
    |:-:|:----:|:--------:|:--------:|:----------:|
    |7  | 5760 |2015-09-10|    2     |     1      |
    |12 |3045.6|2017-04-25|    2     |     1      |


3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
    ```sql
    SELECT DISTINCT id_cliente FROM pedido;
    ```

    |id_cliente|
    |:--------:|
    |    3     |
    |    5     |
    |    4     |
    |    6     |
    |    2     |
    |    7     |
    |    1     |
    |    8     |


4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.
    ```sql
    SELECT * FROM pedido WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31' AND total>500;
    ```

    |id |total  |fecha     |id_cliente|id_comercial|
    |:-:|:-----:|:--------:|:--------:|:----------:|
    |5  | 948.5 |2017-09-10|    5     |     2      |
    |8  |1983.43|2017-10-10|    4     |     6      |
    |12 |3045.6 |2017-04-25|    2     |     1      |


5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
    ```sql
    SELECT nombre || ' ' || apellido1 || ' ' || apellido2 FROM comercial WHERE comisión BETWEEN 0.05 AND 0.11;
    ```

    |comercial             |
    |----------------------|
    |Diego Flores Salas    |
    |Antonio Vega Hernández|
    |Alfredo Ruiz Flores   |


6. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
    ```sql
    SELECT MAX(comisión) FROM comercial;
    ```

    |max |
    |:--:|
    |0.15|


7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
    ```sql
    SELECT id, nombre, apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1, nombre;
    ```

    |id |nombre   |apellido1|
    |:-:|---------|---------|
    |9  |Guillermo|López    |
    |5  |Marcos   |Loyola   |
    |1  |Aarón    |Rivero   |
    |3  |Adolfo   |Rubio    |
    |8  |Pepe     |Ruiz     |
    |2  |Adela    |Salas    |
    |10 |Daniel   |Santana  |
    |6  |María    |Santana  |


8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.
    ```sql
    SELECT nombre FROM cliente WHERE nombre ILIKE 'a%' AND nombre ILIKE '%n' OR nombre ILIKE 'p%' ORDER BY nombre ASC;
    ```

    |nombre|
    |------|
    |Aarón |
    |Adrián|
    |Pepe  |
    |Pilar |


9. Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.
    ```sql
    SELECT nombre FROM cliente WHERE nombre NOT ILIKE 'a%' ORDER BY nombre ASC;
    ```

    |nombre   |
    |---------|
    |Daniel   |
    |Guillermo|
    |Marcos   |
    |María    |
    |Pepe     |
    |Pilar    |


10. Devuelve un listado con los nombres de los comerciales que terminan por 'el' u 'o'. Tenga en cuenta que se deberán eliminar los nombres repetidos.
    ```sql
    SELECT DISTINCT nombre FROM comercial WHERE nombre ILIKE '%el' OR nombre ILIKE '%o' ORDER BY nombre ASC;
    ```

    |nombre   |
    |---------|
    |Daniel   |
    |Guillermo|
    |Marcos   |
    |María    |
    |Pepe     |
    |Pilar    |


## <span style="color:red; text-decoration:underline">Consultas multitabla (Composición interna)<span>

1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
    ```sql
    SELECT DISTINCT C.id, (C.nombre || ' ' || C.apellido1) AS Name FROM cliente C INNER JOIN pedido P ON C.id = P.id_cliente ORDER BY Name ASC;
    ```
    |id |name         |
    |---|-------------|
    |1  |Aarón Rivero |
    |2  |Adela Salas  |
    |3  |Adolfo Rubio |
    |4  |Adrián Suárez|
    |5  |Marcos Loyola|
    |6  |María Santana|
    |8  |Pepe Ruiz    |
    |7  |Pilar Ruiz   |


2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
    ```sql
    SELECT * FROM pedido P INNER JOIN cliente C ON P.id_cliente = C.id ORDER BY C.nombre ASC;
    ```

    |id |total  |fecha     |id_cliente|id_comercial|id-2|nombre|apellido1|apellido2|ciudad |categoria|
    |:-:|-------|----------|:--------:|:----------:|:--:|------|---------|---------|-------|:-------:|
    |16 |2389.23|2019-03-11|    1     |     5      | 1  |Aarón |Rivero   |Gómez    |Almería|   100   |
    |2  |270.65 |2016-09-10|    1     |     5      | 1  |Aarón |Rivero   |Gómez    |Almería|   100   |
    |15 |370.85 |2019-03-11|    1     |     5      | 1  |Aarón |Rivero   |Gómez    |Almería|   100   |
    |12 |3045.6 |2017-04-25|    2     |     1      | 2  |Adela |Salas    |Díaz     |Granada|   200   |
    |3  |65.26  |2017-10-05|    2     |     1      | 2  |Adela |Salas    |Díaz     |Granada|   200   |
    |7  |5760   |2015-09-10|    2     |     1      | 2  |Adela |Salas    |Díaz     |Granada|   200   |
    |11 |75.29  |2016-08-17|    3     |     7      | 3  |Adolfo|Rubio    |Flores   |Sevilla|  NULL   |
    |8  |1983.43|2017-10-10|    4     |     6      | 4  |Adrián|Suárez   |NULL     |Jaén   |   300   |
    |1  |150.5  |2017-10-05|    5     |     2      | 5  |Marcos|Loyola   |Méndez   |Almería|   200   |
    |5  |948.5  |2017-09-10|    5     |     2      | 5  |Marcos|Loyola   |Méndez   |Almería|   200   |
    |13 |545.75 |2019-01-25|    6     |     1      | 6  |María |Santana  |Moreno   |Cádiz  |   100   |
    |14 |145.82 |2017-02-02|    6     |     1      | 6  |María |Santana  |Moreno   |Cádiz  |   100   |
    |10 |250.45 |2015-06-27|    8     |     2      | 8  |Pepe  |Ruiz     |Santana  |Huelva |   200   |
    |9  |2480.4 |2016-10-10|    8     |     3      | 8  |Pepe  |Ruiz     |Santana  |Huelva |   200   |
    |4  |110.5  |2016-08-17|    8     |     3      | 8  |Pepe  |Ruiz     |Santana  |Huelva |   200   |
    |6  |2400.6 |2016-07-27|    7     |     1      | 7  |Pilar |Ruiz     |NULL     |Sevilla|   300   |


3. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
    ```sql
    SELECT * FROM pedido P INNER JOIN comercial C ON P.id_comercial = C.id ORDER BY C.nombre ASC;
    ```

    |id |total  |fecha     |id_cliente|id_comercial|id-2|nombre |apellido1|apellido2|comisión|
    |:-:|------:|----------|:--------:|:----------:|:--:|-------|---------|---------|-------:|
    |16 |2389.23|2019-03-11|    1     |     5      | 5  |Antonio|Carretero|Ortega   |    0.12|
    |15 | 370.85|2019-03-11|    1     |     5      | 5  |Antonio|Carretero|Ortega   |    0.12|
    |2  | 270.65|2016-09-10|    1     |     5      | 5  |Antonio|Carretero|Ortega   |    0.12|
    |11 |  75.29|2016-08-17|    3     |     7      | 7  |Antonio|Vega     |Hernández|    0.11|
    |7  |   5760|2015-09-10|    2     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |14 | 145.82|2017-02-02|    6     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |13 | 545.75|2019-01-25|    6     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |12 | 3045.6|2017-04-25|    2     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |3  |  65.26|2017-10-05|    2     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |6  | 2400.6|2016-07-27|    7     |     1      | 1  |Daniel |Sáez     |Vega     |    0.15|
    |9  | 2480.4|2016-10-10|    8     |     3      | 3  |Diego  |Flores   |Salas    |    0.11|
    |4  |  110.5|2016-08-17|    8     |     3      | 3  |Diego  |Flores   |Salas    |    0.11|
    |10 | 250.45|2015-06-27|    8     |     2      | 2  |Juan   |Gómez    |López    |    0.13|
    |1  |  150.5|2017-10-05|    5     |     2      | 2  |Juan   |Gómez    |López    |    0.13|
    |5  |  948.5|2017-09-10|    5     |     2      | 2  |Juan   |Gómez    |López    |    0.13|
    |8  |1983.43|2017-10-10|    4     |     6      | 6  |Manuel |Domínguez|Hernández|    0.13|


4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
    ```sql
    SELECT * FROM cliente C INNER JOIN pedido P ON P.id_cliente = C.id INNER JOIN comercial K ON K.id = P.id_comercial ORDER BY K.nombre ASC;
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|id-2|total  |fecha     |id_cliente|id_comercial|id-3|nombre-2|apellido1-2|apellido2-2|comisión|
    |:-:|------|---------|---------|-------|--------:|:--:|------:|----------|:--------:|:----------:|:--:|--------|-----------|-----------|-------:|
    |1  |Aarón |Rivero   |Gómez    |Almería|      100| 16 |2389.23|2019-03-11|    1     |     5      | 5  |Antonio |Carretero  |Ortega     |    0.12|
    |1  |Aarón |Rivero   |Gómez    |Almería|      100| 15 | 370.85|2019-03-11|    1     |     5      | 5  |Antonio |Carretero  |Ortega     |    0.12|
    |1  |Aarón |Rivero   |Gómez    |Almería|      100| 2  | 270.65|2016-09-10|    1     |     5      | 5  |Antonio |Carretero  |Ortega     |    0.12|
    |3  |Adolfo|Rubio    |Flores   |Sevilla|     NULL| 11 |  75.29|2016-08-17|    3     |     7      | 7  |Antonio |Vega       |Hernández  |    0.11|
    |2  |Adela |Salas    |Díaz     |Granada|      200| 7  |   5760|2015-09-10|    2     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |6  |María |Santana  |Moreno   |Cádiz  |      100| 14 | 145.82|2017-02-02|    6     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |6  |María |Santana  |Moreno   |Cádiz  |      100| 13 | 545.75|2019-01-25|    6     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |2  |Adela |Salas    |Díaz     |Granada|      200| 12 | 3045.6|2017-04-25|    2     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |2  |Adela |Salas    |Díaz     |Granada|      200| 3  |  65.26|2017-10-05|    2     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |7  |Pilar |Ruiz     |NULL     |Sevilla|      300| 6  | 2400.6|2016-07-27|    7     |     1      | 1  |Daniel  |Sáez       |Vega       |    0.15|
    |8  |Pepe  |Ruiz     |Santana  |Huelva |      200| 9  | 2480.4|2016-10-10|    8     |     3      | 3  |Diego   |Flores     |Salas      |    0.11|
    |8  |Pepe  |Ruiz     |Santana  |Huelva |      200| 4  |  110.5|2016-08-17|    8     |     3      | 3  |Diego   |Flores     |Salas      |    0.11|
    |8  |Pepe  |Ruiz     |Santana  |Huelva |      200| 10 | 250.45|2015-06-27|    8     |     2      | 2  |Juan    |Gómez      |López      |    0.13|
    |5  |Marcos|Loyola   |Méndez   |Almería|      200| 1  |  150.5|2017-10-05|    5     |     2      | 2  |Juan    |Gómez      |López      |    0.13|
    |5  |Marcos|Loyola   |Méndez   |Almería|      200| 5  |  948.5|2017-09-10|    5     |     2      | 2  |Juan    |Gómez      |López      |    0.13|
    |4  |Adrián|Suárez   |NULL     |Jaén   |      300| 8  |1983.43|2017-10-10|    4     |     6      | 6  |Manuel  |Domínguez  |Hernández  |    0.13|


5. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
    ```sql
    SELECT * FROM cliente C INNER JOIN pedido P ON P.id_cliente = C.id WHERE EXTRACT(year FROM P.fecha) = 2017 AND total BETWEEN 300 AND 1000;
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|id-2|total|fecha     |id_cliente|id_comercial|
    |:-:|:----:|:-------:|:-------:|:-----:|:-------:|:--:|:---:|:--------:|:--------:|:----------:|
    |5  |Marcos| Loyola  | Méndez  |Almería|   200   | 5  |948.5|2017-09-10|    5     |     2      |


6. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.
    ```sql
    SELECT DISTINCT K.nombre, K.apellido1, K.apellido2 FROM comercial K INNER JOIN pedido P ON K.id = P.id_comercial INNER JOIN cliente C ON C.id = P.id_cliente WHERE (C.nombre || ' ' || C.apellido1 || ' ' || C.apellido2) = 'María Santana Moreno';
    ```

    |nombre|apellido1|apellido2|
    |:----:|:-------:|:-------:|
    |Daniel|  Sáez   |  Vega   |


7. Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.
    ```sql
    SELECT DISTINCT C.nombre, C.apellido1, C.apellido2 FROM comercial K 
    INNER JOIN pedido P ON K.id = P.id_comercial 
    INNER JOIN cliente C ON C.id = P.id_cliente 
    WHERE (K.nombre || ' ' || K.apellido1 || ' ' || K.apellido2) = 'Daniel Sáez Vega';
    ```

    |nombre|apellido1|apellido2|
    |------|---------|---------|
    |Adela |Salas    |Díaz     |
    |María |Santana  |Moreno   |
    |Pilar |Ruiz     |NULL     |


## <span style="color:red; text-decoration:underline">Consultas multitabla (Composición externa)<span>

1. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
    ```sql
    SELECT * FROM cliente C 
    LEFT JOIN pedido P ON C.id = P.id_cliente 
    ORDER BY C.apellido1, C.apellido2, C.nombre ASC;
    ```

    |id |nombre   |apellido1|apellido2|ciudad |categoria|id-2|total  |fecha     |id_cliente|id_comercial|
    |:-:|---------|---------|---------|-------|--------:|:--:|------:|----------|:--------:|:----------:|
    |9  |Guillermo|López    |Gómez    |Granada|      225|NULL|   NULL|NULL      |   NULL   |    NULL    |
    |5  |Marcos   |Loyola   |Méndez   |Almería|      200| 1  |  150.5|2017-10-05|    5     |     2      |
    |5  |Marcos   |Loyola   |Méndez   |Almería|      200| 5  |  948.5|2017-09-10|    5     |     2      |
    |1  |Aarón    |Rivero   |Gómez    |Almería|      100| 2  | 270.65|2016-09-10|    1     |     5      |
    |1  |Aarón    |Rivero   |Gómez    |Almería|      100| 16 |2389.23|2019-03-11|    1     |     5      |
    |1  |Aarón    |Rivero   |Gómez    |Almería|      100| 15 | 370.85|2019-03-11|    1     |     5      |
    |3  |Adolfo   |Rubio    |Flores   |Sevilla|     NULL| 11 |  75.29|2016-08-17|    3     |     7      |
    |8  |Pepe     |Ruiz     |Santana  |Huelva |      200| 4  |  110.5|2016-08-17|    8     |     3      |
    |8  |Pepe     |Ruiz     |Santana  |Huelva |      200| 9  | 2480.4|2016-10-10|    8     |     3      |
    |8  |Pepe     |Ruiz     |Santana  |Huelva |      200| 10 | 250.45|2015-06-27|    8     |     2      |
    |7  |Pilar    |Ruiz     |NULL     |Sevilla|      300| 6  | 2400.6|2016-07-27|    7     |     1      |
    |2  |Adela    |Salas    |Díaz     |Granada|      200| 12 | 3045.6|2017-04-25|    2     |     1      |
    |2  |Adela    |Salas    |Díaz     |Granada|      200| 3  |  65.26|2017-10-05|    2     |     1      |
    |2  |Adela    |Salas    |Díaz     |Granada|      200| 7  |   5760|2015-09-10|    2     |     1      |
    |10 |Daniel   |Santana  |Loyola   |Sevilla|      125|NULL|   NULL|NULL      |   NULL   |    NULL    |
    |6  |María    |Santana  |Moreno   |Cádiz  |      100| 13 | 545.75|2019-01-25|    6     |     1      |
    |6  |María    |Santana  |Moreno   |Cádiz  |      100| 14 | 145.82|2017-02-02|    6     |     1      |
    |4  |Adrián   |Suárez   |NULL     |Jaén   |      300| 8  |1983.43|2017-10-10|    4     |     6      |


2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.
    ```sql
    SELECT * FROM comercial C 
    LEFT JOIN pedido P ON C.id = P.id_cliente 
    ORDER BY C.apellido1, C.apellido2, C.nombre ASC;
    ```

    |id |nombre |apellido1|apellido2|comisión|id-2|total  |fecha     |id_cliente|id_comercial|
    |:-:|-------|---------|---------|-------:|:--:|------:|----------|:--------:|:----------:|
    |5  |Antonio|Carretero|Ortega   |    0.12| 1  |  150.5|2017-10-05|    5     |     2      |
    |5  |Antonio|Carretero|Ortega   |    0.12| 5  |  948.5|2017-09-10|    5     |     2      |
    |6  |Manuel |Domínguez|Hernández|    0.13| 13 | 545.75|2019-01-25|    6     |     1      |
    |6  |Manuel |Domínguez|Hernández|    0.13| 14 | 145.82|2017-02-02|    6     |     1      |
    |3  |Diego  |Flores   |Salas    |    0.11| 11 |  75.29|2016-08-17|    3     |     7      |
    |2  |Juan   |Gómez    |López    |    0.13| 3  |  65.26|2017-10-05|    2     |     1      |
    |2  |Juan   |Gómez    |López    |    0.13| 12 | 3045.6|2017-04-25|    2     |     1      |
    |2  |Juan   |Gómez    |López    |    0.13| 7  |   5760|2015-09-10|    2     |     1      |
    |4  |Marta  |Herrera  |Gil      |    0.14| 8  |1983.43|2017-10-10|    4     |     6      |
    |8  |Alfredo|Ruiz     |Flores   |    0.05| 9  | 2480.4|2016-10-10|    8     |     3      |
    |8  |Alfredo|Ruiz     |Flores   |    0.05| 4  |  110.5|2016-08-17|    8     |     3      |
    |8  |Alfredo|Ruiz     |Flores   |    0.05| 10 | 250.45|2015-06-27|    8     |     2      |
    |1  |Daniel |Sáez     |Vega     |    0.15| 2  | 270.65|2016-09-10|    1     |     5      |
    |1  |Daniel |Sáez     |Vega     |    0.15| 15 | 370.85|2019-03-11|    1     |     5      |
    |1  |Daniel |Sáez     |Vega     |    0.15| 16 |2389.23|2019-03-11|    1     |     5      |
    |7  |Antonio|Vega     |Hernández|    0.11| 6  | 2400.6|2016-07-27|    7     |     1      |


3. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
    ```sql
    SELECT C.* FROM cliente C 
    LEFT JOIN pedido P ON C.id = P.id_cliente 
    WHERE P.id IS NULL;
    ```

    |id |nombre   |apellido1|apellido2|ciudad |categoria|
    |--:|--------:|--------:|--------:|------:|--------:|
    |10 |   Daniel|  Santana|   Loyola|Sevilla|      125|
    | 9 |Guillermo|    López|    Gómez|Granada|      225|


4. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
    ```sql
    SELECT C.* FROM comercial C 
    LEFT JOIN pedido P ON C.id = P.id_comercial 
    WHERE P.id IS NULL;
    ```
    |id |nombre |apellido1|apellido2|comisión|
    |:-:|------:|--------:|--------:|-------:|
    |8  |Alfredo|     Ruiz|   Flores|    0.05|
    |4  |  Marta|  Herrera|      Gil|    0.14|


5. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.
    ```sql
    SELECT CONCAT(C.apellido1, ' ', C.apellido2, ' ', C.nombre, ' (Cliente)') AS Resultado
    FROM cliente C LEFT JOIN pedido P ON C.id = P.id_cliente
    WHERE P.id_cliente IS NULL
    UNION
    SELECT CONCAT(K.apellido1, ' ', K.apellido2, ' ', K.nombre, ' (Comercial)') AS Resultado
    FROM pedido P RIGHT JOIN comercial K ON K.id = P.id_comercial
    WHERE P.id_comercial IS NULL
    ORDER BY Resultado;
    ```

    |resultado                      |
    |------------------------------:|
    |  Herrera Gil Marta (Comercial)|
    |López Gómez Guillermo (Cliente)|
    |Ruiz Flores Alfredo (Comercial)|
    |Santana Loyola Daniel (Cliente)|


6. ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
    ```sql
    /*
    No se podría utilizar NATURAL LEFT JOIN o NATURAL RIGHT JOIN ya que los nombres de los campos no coinciden en ambas tablas.
    En la tabla Comercial, su Id se llama "Id", mientras que en la tabla Pedido, el campo que es la clave foránea se llama "Id_Comercial".
    Lo mismo sucede con la tabla Clientem donde su PK se llama "Id", mientras que en la tabla Pedido, el campo se llama "Id_Cliente".
    */ 
    ```

## <span style="color:red; text-decoration:underline">Consultas resúmen<span>

1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
    ```sql
    SELECT SUM(total) FROM pedido;
    ```

    |sum               |
    |------------------|
    |20992.829999999998|


2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
    ```sql
    SELECT AVG(total) FROM pedido;
    ```

    |avg               |
    |------------------|
    |1312.0518749999999|


3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
    ```sql
    SELECT COUNT(DISTINCT id_comercial) FROM pedido;
    ```

    |count             |
    |:----------------:|
    |        6         |

4. Calcula el número total de clientes que aparecen en la tabla cliente.
    ```sql
    SELECT COUNT(*) FROM cliente;
    ```

    |count             |
    |:----------------:|
    |        10        |


5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
    ```sql
    SELECT MAX(total) FROM pedido;
    ```

    |max               |
    |:----------------:|
    |       5760       |


6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.
    ```sql
    SELECT MIN(total) FROM pedido;
    ```

    |min               |
    |:----------------:|
    |      65.26       |

    
7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
    ```sql
    SELECT ciudad, MAX(categoria)
    FROM cliente 
    GROUP BY ciudad;
    ```

    |ciudad            |max|
    |------------------|---|
    |Almería           |200|
    |Huelva            |200|
    |Sevilla           |300|
    |Granada           |225|
    |Jaén              |300|
    |Cádiz             |100|


8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
    FROM pedido P
    INNER JOIN cliente C ON P.id_cliente = C.id
    GROUP BY C.id, P.fecha;
    ```

    |id |nombre|apellido1|apellido2|fecha     |max    |
    |---|------|---------|---------|----------|-------|
    |6  |María |Santana  |Moreno   |2017-02-02|145.82 |
    |8  |Pepe  |Ruiz     |Santana  |2015-06-27|250.45 |
    |1  |Aarón |Rivero   |Gómez    |2019-03-11|2389.23|
    |2  |Adela |Salas    |Díaz     |2015-09-10|5760   |
    |8  |Pepe  |Ruiz     |Santana  |2016-10-10|2480.4 |
    |6  |María |Santana  |Moreno   |2019-01-25|545.75 |
    |3  |Adolfo|Rubio    |Flores   |2016-08-17|75.29  |
    |2  |Adela |Salas    |Díaz     |2017-04-25|3045.6 |
    |8  |Pepe  |Ruiz     |Santana  |2016-08-17|110.5  |
    |5  |Marcos|Loyola   |Méndez   |2017-10-05|150.5  |
    |5  |Marcos|Loyola   |Méndez   |2017-09-10|948.5  |
    |7  |Pilar |Ruiz     |NULL     |2016-07-27|2400.6 |
    |1  |Aarón |Rivero   |Gómez    |2016-09-10|270.65 |
    |4  |Adrián|Suárez   |NULL     |2017-10-10|1983.43|
    |2  |Adela |Salas    |Díaz     |2017-10-05|65.26  |


9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
    FROM pedido P
    INNER JOIN cliente C ON P.id_cliente = C.id
    GROUP BY C.id, P.fecha
    HAVING MAX(P.total) > 2000;
    ```

    |id |nombre|apellido1|apellido2|fecha     |max    |
    |---|------|---------|---------|----------|-------|
    |1  |Aarón |Rivero   |Gómez    |2019-03-11|2389.23|
    |2  |Adela |Salas    |Díaz     |2015-09-10|5760   |
    |8  |Pepe  |Ruiz     |Santana  |2016-10-10|2480.4 |
    |2  |Adela |Salas    |Díaz     |2017-04-25|3045.6 |
    |7  |Pilar |Ruiz     |NULL     |2016-07-27|2400.6 |


10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, C.apellido2, MAX(P.total)
    FROM pedido P
    INNER JOIN comercial C ON P.id_comercial = C.id
    WHERE fecha = '2016-08-17'
    GROUP BY C.id;
    ```

    |id |nombre |apellido1|apellido2|max  |
    |---|-------|---------|---------|-----|
    |3  |Diego  |Flores   |Salas    |110.5|
    |7  |Antonio|Vega     |Hernández|75.29|


11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, C.apellido2, COUNT(P.id_cliente)
    FROM pedido P
    RIGHT JOIN cliente C
    ON P.id_cliente = C.id
    GROUP BY C.id, P.id_cliente;
    ```

    |id |nombre |apellido1|apellido2|count|
    |---|-------|---------|---------|-----|
    |1  |Aarón  |Rivero   |Gómez    |3    |
    |7  |Pilar  |Ruiz     |NULL     |1    |
    |10 |Daniel |Santana  |Loyola   |0    |
    |6  |María  |Santana  |Moreno   |2    |
    |9  |Guillermo|López    |Gómez    |0    |
    |2  |Adela  |Salas    |Díaz     |3    |
    |8  |Pepe   |Ruiz     |Santana  |3    |
    |5  |Marcos |Loyola   |Méndez   |2    |
    |3  |Adolfo |Rubio    |Flores   |1    |
    |4  |Adrián |Suárez   |NULL     |1    |


12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, C.apellido2, COUNT(P.id_cliente)
    FROM pedido P
    RIGHT JOIN cliente C
    ON P.id_cliente = C.id
    WHERE EXTRACT(year FROM P.fecha) = 2017
    GROUP BY C.id, P.id_cliente;
    ```

    |id |nombre |apellido1|apellido2|count|
    |---|-------|---------|---------|-----|
    |2  |Adela  |Salas    |Díaz     |2    |
    |4  |Adrián |Suárez   |NULL     |1    |
    |5  |Marcos |Loyola   |Méndez   |2    |
    |6  |María  |Santana  |Moreno   |1    |


13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.
    ```sql
    SELECT C.id, C.nombre, C.apellido1, COALESCE(MAX(P.total), 0)
    FROM pedido P
    RIGHT JOIN cliente C
    ON P.id_cliente = C.id
    GROUP BY C.id, P.id_cliente;
    ```

    |id |nombre |apellido1|coalesce |
    |---|-------|---------|--------:|
    |1  |Aarón  |Rivero   |  2389.23|
    |7  |Pilar  |Ruiz     |   2400.6|
    |10 |Daniel |Santana  |        0|
    |6  |María  |Santana  |   545.75|
    |9  |Guillermo|López    |        0|
    |2  |Adela  |Salas    |     5760|
    |8  |Pepe   |Ruiz     |   2480.4|
    |5  |Marcos |Loyola   |    948.5|
    |3  |Adolfo |Rubio    |    75.29|
    |4  |Adrián |Suárez   |  1983.43|


14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
    ```sql
    SELECT MAX(P.total), EXTRACT(year FROM P.fecha)
    FROM pedido P
    GROUP BY EXTRACT(year FROM P.fecha)
    ORDER BY EXTRACT(year FROM P.fecha) DESC;
    ```

    |max|extract|
    |:-:|------:|
    |238|   2019|
    |304|   2017|
    |248|   2016|
    |576|   2015|


15. Devuelve el número total de pedidos que se han realizado cada año.
    ```sql
    SELECT COUNT(P.total), EXTRACT(year FROM P.fecha)
    FROM pedido P
    GROUP BY EXTRACT(year FROM P.fecha)
    ORDER BY EXTRACT(year FROM P.fecha) DESC;
    ```

    |max|extract|
    |:-:|------:|
    |238|   2019|
    |304|   2017|
    |248|   2016|
    |576|   2015|


## <span style="color:red; text-decoration:underline">Subconsultas<span>

### <span style="color:blue; text-decoration:underline">Con operadores básicos de comparación</span>

1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
    ```sql
    SELECT * 
    FROM pedido P
    WHERE P.id_cliente = (SELECT C.id 
                        FROM cliente C
                        WHERE C.nombre = 'Adela' AND C.apellido1 = 'Salas' AND C.apellido2 = 'Díaz');
    ```

    |id |total  |fecha     |id_cliente|id_comercial|
    |:-:|------:|----------|:--------:|:----------:|
    |3  |  65.26|2017-10-05|    2     |     1      |
    |7  |   5760|2015-09-10|    2     |     1      |
    |12 | 3045.6|2017-04-25|    2     |     1      |


2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)
    ```sql
    SELECT * 
    FROM pedido P
    WHERE P.id_cliente = (SELECT C.id 
                        FROM comercial C
                        WHERE C.nombre = 'Daniel' AND C.apellido1 = 'Sáez' AND C.apellido2 = 'Vega');
    ```

    |count|
    |:---:|
    |  3  |


3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)
    ```sql
    SELECT C.*
    FROM pedido P, cliente C
    WHERE P.id_cliente = C.id AND P.total = (SELECT MAX(P.total)
                                            FROM pedido P
                                            WHERE EXTRACT(year FROM P.fecha) = '2019');
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|
    |:-:|:----:|:-------:|:-------:|:-----:|:-------:|
    |1  |Aarón | Rivero  |  Gómez  |Almería|   100   |


4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
    ```sql
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
    ```

    |fecha|total|
    |:---:|:---:|
    |2017-|65.26|


5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.
    ```sql
    SELECT *
    FROM cliente C INNER JOIN pedido P ON C.id = P.id_cliente
    WHERE EXTRACT(year FROM P.fecha) = '2017' AND P.total >= (SELECT AVG(p.total)
                                                            FROM pedido p
                                                            WHERE EXTRACT(year FROM P.fecha) = '2017');
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|id-2|total  |fecha     |id_cliente|id_comercial|
    |:-:|------|---------|---------|-------|--------:|:--:|------:|:--------:|:--------:|:----------:|
    |2  |Adela |Salas    |Díaz     |Granada|      200| 12 | 3045.6|2017-04-25|    2     |     1      |
    |4  |Adrián|Suárez   |NULL     |Jaén   |      300| 8  |1983.43|2017-10-10|    4     |     6      |


### <span style="color:blue; text-decoration:underline">Subconsultas con ALL y ANY</span>

1. Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
    ```sql
    SELECT *
    FROM pedido P
    WHERE P.total >= ALL(SELECT MAX(P.total)
                        FROM pedido P);
    ```

    |id |total|fecha |id_cliente|id_comercial|
    |:-:|:---:|:----:|:--------:|:----------:|
    |7  |5760 |2015-0|    2     |     1      |


2. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
    ```sql
    SELECT C.*
    FROM cliente C
    WHERE C.id <> ALL(SELECT DISTINCT P.id_cliente
                    FROM pedido P);
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|
    |:-:|------|---------|---------|-------|--------:|
    |9  |Guillermo|López    |Gómez    |Granada|      225|
    |10 |Daniel|Santana  |Loyola   |Sevilla|      125|


3. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
    ```sql
    SELECT C.*
    FROM comercial C
    WHERE C.id <> ALL(SELECT DISTINCT P.id_comercial
                    FROM pedido P);
    ```

    |id |nombre|apellido1|apellido2|comisión|
    |:-:|------|---------|---------|-------:|
    |4  |Marta |Herrera  |Gil      |    0.14|
    |8  |Alfredo|Ruiz     |Flores   |    0.05|


### <span style="color:blue; text-decoration:underline">Subconsultas con IN y NOT IN</span>

1. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
    ```sql
    SELECT C.*
    FROM cliente C
    WHERE C.id NOT IN (SELECT DISTINCT P.id_cliente
                    FROM pedido P);
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|
    |:-:|------|---------|---------|-------|--------:|
    |9  |Guillermo|López    |Gómez    |Granada|      225|
    |10 |Daniel|Santana  |Loyola   |Sevilla|      125|

2. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).
    ```sql
    SELECT C.*
    FROM comercial C
    WHERE C.id NOT IN (SELECT DISTINCT P.id_comercial
                    FROM pedido P);
    ```

    |id |nombre|apellido1|apellido2|comisión|
    |:-:|------|---------|---------|-------:|
    |4  |Marta |Herrera  |Gil      |    0.14|
    |8  |Alfredo|Ruiz     |Flores   |    0.05|

### <span style="color:blue; text-decoration:underline">Subconsultas con EXISTS y NOT EXISTS</span>

1. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
    ```sql
    SELECT *
    FROM cliente C
    WHERE NOT EXISTS (SELECT P.id_cliente 
                    FROM pedido P
                    WHERE C.id = P.id_cliente);
    ```

    |id |nombre|apellido1|apellido2|ciudad |categoria|
    |:-:|------|---------|---------|-------|--------:|
    |9  |Guillermo|López    |Gómez    |Granada|      225|
    |10 |Daniel|Santana  |Loyola   |Sevilla|      125|
    
2. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
    ```sql
    SELECT *
    FROM comercial C
    WHERE NOT EXISTS (SELECT P.id_comercial
                    FROM pedido P
                    WHERE C.id = P.id_comercial);
    ```

    |id |nombre|apellido1|apellido2|comisión|
    |:-:|------|---------|---------|-------:|
    |4  |Marta |Herrera  |Gil      |    0.14|
    |8  |Alfredo|Ruiz     |Flores   |    0.05|