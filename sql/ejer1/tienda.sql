CREATE TABLE IF NOT EXISTS piezas (
    cod_pieza int AUTO_INCREMENTAL,
    nombre VARCHAR(30),
    fecha_fabri DATE
)

CREATE TABLE IF NOT EXISTS proveedores (
    cod_prove int AUTO_INCREMENTAL,
    nombre VARCHAR(30),
    ciudad VARCHAR(20) 
)

CREATE TABLE IF NOT EXISTS precios (
    cod_precio int AUTO_INCREMENTAL,
    cod_pieza INTEGER,
    cod_prove INTEGER,
    precio FLOAT
)

ALTER TABLE  precios
ADD CONSTRAINT fk_prepie FOREIGN KEY (cod_pieza)
REFERENCES piezas;