# Ejercios de SQL
Practica de tablas y consultas básicas

## Ejercio 1

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

**4. Adjuntar la imagen correspondiente a las tablas junto con las relaciones en el documento de texto.**

**5. Obtener las siguientes consultas:**

**5.1. Todos los datos de la tabla Alquiler:**

```sql
SELECT * FROM Alquiler;
```

**5.2. Nombre y ciudad de los clientes cuyo nombre contenga una 'f' y la ciudad contenga en la segunda letra una 'm':**

```sql
SELECT nombre, ciudad FROM Clientes
WHERE nombre LIKE '%f%' AND SUBSTRING(ciudad, 2, 1) = 'm';
```

**5.3. Marca y color de los coches cuyo precio de alquiler esté entre 200 y 500 euros (ambos inclusive), ordenados por el color de forma descendente:**

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
