use rent_a_car;

CREATE TABLE IF NOT EXISTS clientes (
    dni INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    ciudad VARCHAR(15),
    observaciones VARCHAR(50),
    fecha_carnet DATE
);

CREATE TABLE coches (
    matricula INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(25),
    modelo VARCHAR(25),
    color VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS alquiler (
    cod_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    dni_cliente INT,	
    matricula_coche INT,
    fecha_inicio DATE,
    fecha_entrega DATE,
    dias_limite INT,
    precio_alquiler FLOAT
);

/*ALTER TABLE clientes 
ADD COLUMN fecha_carnet DATE;*/

/* INSERTAR DATOS */

INSERT INTO clientes (nombre, ciudad, observaciones, fecha_carnet) VALUES
    ('Juan', 'Madrid', 'Cliente habitual', '2022-01-01'),
    ('María', 'Barcelona', 'Ninguna', '2021-05-12'),
    ('Pedro', 'Sevilla', 'Ninguna', '2023-10-19'),
    ('Lucía', 'Valencia', 'Cliente nuevo', '2023-09-30'),
    ('Javier', 'Bilbao', 'Ninguna', '2022-12-25');

INSERT INTO coches (marca, modelo, color) VALUES
    ('Ford', 'Fiesta', 'Rojo'),
    ('Renault', 'Clio', 'Azul'),
    ('Seat', 'Ibiza', 'Blanco'),
    ('Volkswagen', 'Golf', 'Negro'),
    ('Peugeot', '308', 'Gris'),
    ('Audi', 'R8', 'Rojo');

INSERT INTO alquiler (dni_cliente, matricula_coche, fecha_inicio, fecha_entrega, dias_limite, precio_alquiler) VALUES
    (1, 1, '2023-10-20', NULL, 7, 150.00),
    (2, 2, '2023-10-21', NULL, 5, 100.00),
    (3, 3, '2023-10-22', NULL, 3, 75.00),
    (4, 4, '2023-10-23', NULL, 2, 50.00),
    (5, 5, '2023-10-19', '2023-10-19', 1, 25.00),
    (4, 6, '2023-10-23', NULL, 2, 50.00);

/* RELACIONES */
ALTER TABLE alquiler
ADD CONSTRAINT fk_dni_cliente
FOREIGN KEY (dni_cliente)
REFERENCES clientes(dni);

ALTER TABLE alquiler
ADD CONSTRAINT fk_matricula_coche
FOREIGN KEY (matricula_coche)
REFERENCES coches(matricula);

/* CONSULTAS */

/* 3 Marca y color de los coches cuyo precio de alquiler esté entre 200 y 500 euros (ambos inclusive), ordenados por el color de forma descendente:*/

SELECT marca, color 
FROM coches
WHERE precio_alquiler BETWEEN 200.00 AND 500.00
ORDER BY color DESC;

/* 4. Nombre y ciudad de los clientes que hayan alquilado un coche en el día de hoy. Hacerlo con reunión natural. */

SELECT nombre, ciudad 
FROM clientes, alquiler
WHERE alquiler.fecha_inicio = current_date()
AND clientes.dni = alquiler.dni_cliente;

/* 5. Nombre del cliente junto con las marcas de los coches que haya alquilado y que han excedido el número de días límite y aún no han sido devueltos. */

SELECT nombre, marca
FROM clientes, alquiler, coches
WHERE dni = dni_cliente AND matricula = matricula_coche
AND fecha_entrega IS NULL 
AND CURRENT_DATE() > fecha_inicio + dias_limite;

/* 6. Nombre y fecha del carnet  de conducir de los clientes que han alquilado algún ”Audi” */

SELECT nombre, fecha_carnet
FROM clientes, alquiler, coches
WHERE dni = dni_cliente 
AND matricula = matricula_coche
AND marca = 'Audi';

/* 7. Nombre de los clientes (sin duplicados) que no han entregado aún los coches alquilados. */

SELECT DISTINCT nombre
FROM clientes, alquiler
WHERE dni = dni_cliente
AND fecha_entrega IS NULL;

/* 8. El nombre del cliente con mayor antigüedad en el carnet de conducir. */

SELECT nombre
FROM clientes
WHERE fecha_carnet = (
	SELECT MIN(fecha_carnet)
	FROM clientes
);

/* 9. Total de coches alquilados. */

SELECT COUNT(*)
FROM alquiler;

/* 10. La media de los precios de alquiler de los coches “BMW”. */

SELECT AVG(precio_alquiler)
FROM alquiler, coches
WHERE matricula = matricula_coche
AND marca = 'BMW';

/* 11. Los dni de los clientes , junto con el total de días límites de cada alquiler. */

SELECT dni_cliente, SUM(dias_limite)
FROM alquiler
GROUP BY dni_cliente;

/* 12. Igual a la anterior, pero cuyo total de días límites supere los 30 días. */

SELECT dni_cliente, SUM(dias_limite)
FROM alquiler
GROUP BY dni_cliente
HAVING SUM(dias_limite) > 30;

/* 13. Eliminar todos los alquileres anteriores al 2000. */

DELETE
FROM alquiler
WHERE fecha_inicio < '2000-01-01';

/* 14. Suponiendo que hemos exigido integridad referencial entre la relaciones clientes y alquiler, sin establecer borrado en cascada. Elimina al cliente con dni = 23. */

DELETE
FROM alquiler
WHERE dni_cliente = 23;

DELETE
FROM clientes
WHERE dni_cliente = 23;

/*15. El  rent-a-car ha sido traspasado a otro, ya no se necesita ninguna información sobre los clientes, pues ellos tienen los suyos y con otros datos, por lo tanto pasamos a eliminar toda la información de los clientes. */

ALTER TABLE alquiler
DROP CONSTRAINT fk_alqcli;

DROP TABLE clientes;







