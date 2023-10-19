/**
*
* CREACIÓN DE TABLAS
*   
*/

CREATE TABLE IF NOT EXISTS piezas (
    cod_pieza int AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    fecha_fabri DATE
)

CREATE TABLE IF NOT EXISTS proveedores (
    cod_prove int AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    ciudad VARCHAR(20)  
)

CREATE TABLE IF NOT EXISTS precios (
    cod_precio int AUTO_INCREMENT PRIMARY KEY,
    cod_pieza int,
    cod_prove int,
    precio FLOAT
)

/**
*
* CREACIÓN DE RELACIONES
*
*/

ALTER TABLE precios
ADD CONSTRAINT fk_prepie FOREIGN KEY (cod_pieza)
REFERENCES piezas (cod_pieza) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE precios
ADD CONSTRAINT fk_prepro FOREIGN KEY (cod_prove)
REFERENCES proveedores (cod_prove) ON DELETE CASCADE ON UPDATE CASCADE;

-- Incluir 5 tuplas
-- Tuplas para la tabla piezas

INSERT INTO piezas (nombre, fecha_fabri) VALUES
    ('Tornillo', '2023-10-19'),
    ('Tuerca', '2023-10-18'),
    ('Arandela', '2023-10-17'),
    ('Resorte', '2023-10-16'),
    ('Clavo', '2023-10-15');

-- Tuplas para la tabla proveedores
INSERT INTO proveedores (nombre, ciudad) VALUES
    ('Proveedor A', 'Madrid'),
    ('Proveedor B', 'Barcelona'),
    ('Proveedor C', 'Valencia'),
    ('Proveedor D', 'Sevilla'),
    ('Proveedor E', 'Bilbao');

-- Tuplas para la tabla precios
INSERT INTO precios (cod_pieza, cod_prove, precio) VALUES
    (1, 1, 0.50),
    (2, 2, 0.75),
    (3, 3, 1.00),
    (4, 4, 1.25),
    (5, 5, 1.50);


-- 5. Obtener las siguientes consultas:
-- • Nombres de todos los Proveedores.

SELECT nombre
FROM proveedores;

-- • Todos los datos de las Piezas que hayan sido fabricadas hoy.

SELECT *
FROM piezas
WHERE fechaFabri = #16/10/2023#;

SELECT *
FROM piezas
WHERE fechaFabri = DATE(); /* Da la fecha del sistema */

-- • Código de los proveedores que suministran piezas entre 5 y 30 euros (ambos inclusive).

SELECT cod_prove
FROM precios
WHERE precio BETWEEN 5 AND 30;

-- • Teléfono del proveedor, cuyo nombre contenga una ‘E’ y la ciudad del proveedor contenga en la segunda letra una ‘L’.

SELECT telefono
FROM proveedores
WHERE nombre LIKE "*E*" AND ciudad LIKE "?L*";

-- • Nombre de los proveedores, sin duplicados, que hayan suministrado piezas fabricadas antes del año 2010.

SELECT DISTINCT proveedores.nombre
FROM proveedores, precios, piezas
WHERE fechaFabri < #01/01/2010#
AND proveedores.cod_prove = precios.cod_prove
AND piezas.cod_pieza = precios.cod_pieza;

-- • Código del proveedor cuyas piezas suministradas sean posteriores al año 2010.

SELECT cod_prove
FROM piezas, precios
WHERE fechaFabri > #01/01/2010#
AND piezas.cod_pieza = precios.cod_pieza;

-- • El precio medio al que se nos suministran las piezas.

SELECT AVG(precio)
FROM precios;

-- • El código del proveedor, junto con el precio total de las piezas que ha suministrado.

SELECT cod_prove, SUM(precio)
FROM precios
GROUP BY cod_prove;

-- • Lo mismo que la anterior pero que además el precio total haya superado los 300 €.

SELECT cod_prove, SUM(precio)
FROM precios
GROUP BY cod_prove
HAVING SUM(precio) > 300;

-- • El código del proveedor que suministra la pieza más cara. Hacerlo con subconsulta.

SELECT cod_prove
FROM precios
WHERE precio = (
SELECT MAX(precio)
FROM precios
);

-- • Todos los datos de la tabla suministran, ordenados por el precio de forma descendente.

SELECT *
FROM precios
ORDER BY precio DESC;

-- • Elimina al proveedor 3, pues ha si dado de baja, como no está fijada la integridad referencial en cascada, 
-- escribe los pasos correspondientes para que la B.D. siga coherente. Necesita de dos consultas la 12.1 y 12.2

DELETE *
FROM precios
WHERE cod_prove = 3;

DELETE *
FROM proveedores
WHERE cod_prove = 3;

-- • La tienda ha sido traspasada a otra, ya no necesita ninguna información sobre
-- los proveedores, pues ella tiene los suyos y con otros datos, por lo tanto,
-- pasamos a eliminar toda la información de los proveedores. Necesita de dos
-- consultas la 13.1 y 13.2

ALTER TABLE precios
DROP CONSTRAINT fk_prepro;
DROP TABLE proveedores;

/* 6. Nombre del cliente junto con las marcas de los coches que haya alquilado y que han excedido el número de días límite y aún no han sido devueltos. */
 
SELECT DISTINCT nombre, marca
FROM clientes, alquiler, coches
WHERE alquiler.fecha_entrega IS NULL
AND clientes.dni = alquiler.dni_cliente
AND coches.matricula = alquiler.matricula_coche;
