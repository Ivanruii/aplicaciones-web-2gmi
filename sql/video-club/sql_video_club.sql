USE video_club;

CREATE TABLE socios (
    cod_socio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    ciudad VARCHAR(15),
    sexo BOOLEAN,
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
    precio int
);

CREATE TABLE alquiler (
    cod_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    cod_socio INT,
    cod_peli INT,
    fecha_alquiler DATE,
    fecha_entrega DATE,
    dias_limite INT
);

-- Ejemplo de inserción de 5 tuplas en la tabla socios
INSERT INTO socios (nombre, ciudad, sexo, observaciones, telefono) VALUES
('Juan Pérez', 'Madrid', 1, 'Socio desde 2019', '123456789'),
('María García', 'Barcelona', 0, 'Socio desde 2020', '987654321'),
('Pedro López', 'Sevilla', 1, 'Socio desde 2018', '111222333'),
('Ana Martínez', 'Valencia', 0, 'Socio desde 2021', '444555666'),
('Luisa Fernández', 'Málaga', 0, 'Socio desde 2017', '777888999');

-- Ejemplo de inserción de 5 tuplas en la tabla peliculas
INSERT INTO peliculas (titulo, tema, nacionalidad, fecha_produccion, duracion, precio) VALUES
('El Padrino', 'Drama', 'Estados Unidos', '1972-03-24', 175, 9),
('La La Land', 'Musical', 'Estados Unidos', '2016-12-09', 128, 7),
('El Señor de los Anillos: La Comunidad del Anillo', 'Fantasía épica', 'Estados Unidos/Nueva Zelanda', '2001-12-19', 178, 11),
('El Gran Hotel Budapest', 'Comedia dramática', 'Estados Unidos/Alemania/Reino Unido', '2014-02-06', 100, 6),
('La Vida es Bella', 'Comedia dramática', 'Italia/Francia/España', '1997-12-20', 116, 8);

-- Ejemplo de inserción de 5 tuplas en la tabla alquiler
INSERT INTO alquiler (cod_socio, cod_peli, fecha_alquiler, fecha_entrega, dias_limite) VALUES
(1, 2, '2023-10-23','2023-10-30', 7),
(2, 4, '2023-10-23','2023-10-30', 7),
(3, 1, '2023-10-23','2023-10-30', 7),
(4, 5, '2023-10-23','2023-10-30', 7),
(5, 3, '2023-10-23','2023-10-30', 7);

-- 5. Obtener las siguientes consultas:
-- 5.1. Todos los datos de la tabla alquiler.
SELECT *
FROM alquiler;

-- 5.2. Título y nacionalidad de las películas cuyo título contenga una ‘a’ y la nacionalidad contenga en la segunda letra una ‘R’.

SELECT titulo, nacionalidad
FROM peliculas
WHERE titulo LIKE '%A%' 
AND nacionalidad LIKE '_r%';

-- 5.3. Codigo, título y precio de las películas cuyo precio esté entre 10 y 30 euros (ambos inclusive), ordenados por el título de forma descendente.

SELECT cod_peli, titulo, precio 
from peliculas 
WHERE precio BETWEEN 10 AND 30
ORDER BY precio DESC;
