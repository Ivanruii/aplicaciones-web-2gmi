# Ejercicios de SQL
Practica de tablas y consultas básicas

**1. Crear las tablas:**

```sql
CREATE TABLE clientes (
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

CREATE TABLE alquiler (
    cod_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    dni_cliente INT,
    matricula_coche INT,
    fecha_inicio DATE,
    fecha_entrega DATE,
    dias_limite INT,
    precio_alquiler DECIMAL(10, 2),
);
```

**2. Agregar columna `fecha_carnet` a la tabla clientes:**

```sql
    ALTER TABLE Clientes ADD COLUMN fecha_carnet DATE;
```

**3. Modificar la tabla alquiler para introducir claves ajenas.**

```sql
ALTER TABLE alquiler
ADD CONSTRAINT fk_dni_cliente
FOREIGN KEY (dni_cliente)
REFERENCES clientes(dni);

ALTER TABLE alquiler
ADD CONSTRAINT fk_matricula_coche
FOREIGN KEY (matricula_coche)
REFERENCES coches(matricula);
```

**5.1. Todos los datos de la tabla Alquiler:**

```sql
SELECT * FROM Alquiler;
```

**2. Nombre y ciudad de los clientes cuyo nombre contenga una 'f' y la ciudad contenga en la segunda letra una 'm':**

```sql
SELECT nombre, ciudad FROM Clientes
WHERE nombre LIKE '%f%' AND SUBSTRING(ciudad, 2, 1) = 'm';
```

**3. Marca y color de los coches cuyo precio de alquiler esté entre 200 y 500 euros (ambos inclusive), ordenados por el color de forma descendente:**

```sql
SELECT marca, color FROM Coches
WHERE precio_alquiler BETWEEN 200.00 AND 500.00
ORDER BY color DESC;
```

**4. Nombre y ciudad de los clientes que hayan alquilado un coche en el día de hoy. Hacerlo con reunión natural.**

```sql
SELECT nombre, ciudad 
FROM clientes, alquiler
WHERE fecha_inicio = CURRENT_DATE()
AND clientes.dni = alquiler.cod_alquiler;
```
**5. Nombre del cliente junto con las marcas de los coches que haya alquilado y que han excedido el número de días límite y aún no han sido devueltos.**

```sql
SELECT nombre, marca
FROM clientes, alquiler, coches
WHERE dni = dni_cliente AND matricula = matricula_coche
AND fecha_entrega IS NULL 
AND CURRENT_DATE() > fecha_inicio + dias_limite;
```

**6. Nombre y fecha del carnet  de conducir de los clientes que han alquilado algún ”Audi”**

```sql
SELECT nombre, fecha_carnet
FROM clientes, alquiler, coches
WHERE dni = dni_cliente 
AND matricula = matricula_coche
AND marca = 'Audi';
```

**7. Nombre de los clientes (sin duplicados) que no han entregado aún los coches alquilados.**

```sql
SELECT DISTINCT nombre
FROM clientes, alquiler
WHERE dni = dni_cliente
AND fecha_entrega IS NULL;
```

**8. El nombre del cliente con mayor antigüedad en el carnet de conducir.**

```sql
SELECT nombre
FROM clientes
WHERE fecha_carnet = (
	SELECT MIN(fecha_carnet)
	FROM clientes
);
```

**9. Total de coches alquilados.**


```sql
SELECT COUNT(*)
FROM alquiler;
```

**10. La media de los precios de alquiler de los coches “BMW”.**

```sql
SELECT AVG(precio_alquiler)
FROM alquiler, coches
WHERE matricula = matricula_coche
AND marca = 'BMW';
```

**11. Los dni de los clientes , junto con el total de días límites de cada alquiler.**

```sql
SELECT dni_cliente, SUM(dias_limite)
FROM alquiler
GROUP BY dni_cliente;
```

**12. Igual a la anterior, pero cuyo total de días límites supere los 30 días.**

```sql
SELECT dni_cliente, SUM(dias_limite)
FROM alquiler
GROUP BY dni_cliente
HAVING SUM(dias_limite) > 30;
```

**13. Eliminar todos los alquileres anteriores al 2000.**

```sql
DELETE
FROM alquiler
WHERE fecha_inicio < '2000-01-01';
```

**14. Suponiendo que hemos exigido integridad referencial entre la relaciones clientes y alquiler, sin establecer borrado en cascada. Elimina al cliente con dni = 23.**

```sql
DELETE
FROM alquiler
WHERE dni_cliente = 23;

DELETE
FROM clientes
WHERE dni_cliente = 23;
```

**15. El  rent-a-car ha sido traspasado a otro, ya no se necesita ninguna información sobre los clientes, pues ellos tienen los suyos y con otros datos, por lo tanto pasamos a eliminar toda la información de los clientes.**

```sql
ALTER TABLE alquiler
DROP CONSTRAINT fk_alqcli;

DROP TABLE clientes;
```