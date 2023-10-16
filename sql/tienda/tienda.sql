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