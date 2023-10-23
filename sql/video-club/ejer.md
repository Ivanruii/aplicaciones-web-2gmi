## Ejercicio 3

**3.1. Crear en SQL todas las tablas.**

```sql
CREATE DATABASE video_club;

USE video_club;

CREATE TABLE socios (
    cod_socio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    ciudad VARCHAR(15),
    sexo BIT,
    observaciones VARCHAR(50),
    telefono CHAR(9)
);

CREATE TABLE peliculas (
    cod_peli INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(25),
    tema VARCHAR(15),
    nacionalidad VARCHAR(15),
    fecha_produccion DATE,
    duracion INT,
    precio FLOAT
);

CREATE TABLE alquiler (
    cod_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    cod_socio INT,
    cod_peli INT,
    fecha_alquiler DATE,
    fecha_entrega DATE,
    dias_limite INT
);
```
