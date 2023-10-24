## Ejercicio 3

**1. Se pide crear en SQL las todas las tablas con sus claves primarias, las claves ajenas de la tabla alquiler, se harán posteriormente con la instrucción ALTER TABLE**
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
**2. Se necesita añadir, en la tabla de socios, una nueva columna para que contenga el teléfono del socio.**
```sql
ALTER TABLE socios
ADD COLUMN telefono CHAR(8);
```
**3. Modificar la tabla alquiler para introducir sus claves ajenas.**
```sql
ALTER TABLE alquiler
ADD CONSTRAINT fk_alqsoc 
FOREIGN KEY (cod_socio)
REFERENCES socios(cod_socio);

ALTER TABLE alquiler
ADD CONSTRAINT fk_alqpel
FOREIGN KEY (cod_peli)
REFERENCES peliculas(cod_peli);
```
**4. Adjuntar la imagen correspondiente a las tablas junto con las relaciones. Comentar también en dicho documento, cuál sería el orden a seguir a la hora de introducir los datos en las tablas.**

**Introducir de 3 a 5 tuplas en cada tabla.**
```sql
INSERT INTO socios (nombre, ciudad, sexo, observaciones, telefono) VALUES
    ('Juan', 'Madrid', 1, 'Observaciones de Juan', '123456789'),
    ('Maria', 'Barcelona', 0, 'Observaciones de Maria', '987654321'),
    ('Pedro', 'Sevilla', 1, 'Observaciones de Pedro', '111222333'),
    ('Ana', 'Valencia', 0, 'Observaciones de Ana', '444555666'),
    ('Luis', 'Bilbao', 1, 'Observaciones de Luis', '777888999');

INSERT INTO peliculas (titulo, tema, nacionalidad, fecha_produccion, duracion, precio) VALUES
    ('Pelicula 1', 'Tema 1', 'Nacionalidad 1', '2023-10-24', 120, 9.99),
    ('Pelicula 2', 'Tema 2', 'Nacionalidad 2', '2023-10-24', 90, 7.99),
    ('Pelicula 3', 'Tema 3', 'Nacionalidad 3', '2023-10-24', 150, 12.99),
    ('Pelicula 4', 'Tema 4', 'Nacionalidad 4', '2023-10-24', 180, 14.99),
    ('Pelicula 5', 'Tema 5', 'Nacionalidad 5', '2023-10-24', 120, 11.99);

INSERT INTO alquiler (cod_socio, cod_peli, fecha_alquiler, fecha_entrega, dias_limite) VALUES
    (1, 1, '2023-10-24','2023-10-25', 1),
    (2, 2, '2023-10-24','2023-10-26', 2),
    (3, 3, '2023-10-24','2023-10-27', 3),
    (4, 4, '2023-10-24','2023-10-28', 4),
    (5, 5, '2023-10-24','2023-10-29', 5);
```
**5. Obtener las siguientes consultas:**
- 5.1. Todos los datos de la tabla alquiler.
    ```sql
        SELECT *
        FROM alquiler;
    ```
- 5.2. Título y nacionalidad de las películas cuyo título contenga una ‘a’ y la nacionalidad contenga en la segunda letra una ‘R’.
    ```sql
       SELECT titulo, nacionalidad
       FROM peliculas
       WHERE titulo LIKE '%A%' 
       AND nacionalidad LIKE '_r%' 
    ```
- 5.3. Codigo, título y precio de las películas cuyo precio esté entre 10 y 30 euros (ambos inclusive), ordenados por el título de forma descendente.
- 5.4. Nombre y teléfono de los socios que hayan alquilado una película en el día de hoy.
- 5.5. Nombre del socio junto con los títulos de las películas que haya alquilado y que han excedido el número de días límite y aún no han sido devueltas.
- 5.6. Nombre y sexo de los socios que han alquilado la película de la “Pantera Rosa”
- 5.7. Código de los socios (sin duplicados) que no han entregado aún las películas alquiladas.
- 5.8. Título de la película producida con mayor antigüedad.
- 5.9. Los códigos de los socios, junto con el total de días límites de cada alquiler.
- 5.10. Igual a la anterior, pero cuyo total de días límites supere los 100 días.
- 5.11. Eliminar todos los alquileres anteriores al 2000.
- 5.12. Suponiendo que hemos exigido integridad referencial entre las relaciones socios y alquiler, sin establecer borrado en cascada. Elimina al socio con código número 3.
- 5.13. El Video-Club ha sido traspasado a otro, ya no se necesita ninguna información sobre los socios, pues ellos tienen los suyos y con otros datos, por lo tanto, pasamos a eliminar toda la información de los socios.