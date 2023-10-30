CREATE database pinacotecas;
USE pinacotecas;

CREATE TABLE IF NOT EXISTS pintor (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    pais VARCHAR (25),
    fecha_nacimiento DATE,
    fecha_fallecimiento DATE
);

CREATE TABLE IF NOT EXISTS mecenas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(25),
    pais VARCHAR(25),
    ciudad VARCHAR(25),
    fecha_nacimiento DATE,
    fecha_fallecimiento DATE
);

CREATE TABLE IF NOT EXISTS mecenazgo (
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_pintor INT,	
    id_mecena INT,
    fecha_inicio DATE,
    fecha_final DATE,

    CONSTRAINT fk_mecpin 
    FOREIGN KEY (id_pintor) REFERENCES pintor(id),
    
    CONSTRAINT fk_mecmec FOREIGN KEY (id_mecena) 
    REFERENCES mecenas(id)
);


INSERT INTO pintor (nombre, pais, fecha_nacimiento, fecha_fallecimiento) VALUES 
    ('Pablo Picasso', 'Spain', '1881-10-25', '1973-04-08'),
    ('Vincent van Gogh', 'Netherlands', '1853-03-30', '1890-07-29'),
    ('Leonardo da Vinci', 'Italy', '1452-04-15', '1519-05-02'),
    ('Rembrandt van Rijn', 'Netherlands', '1606-07-15', '1669-10-04'),
    ('Frida Kahlo', 'Mexico', '1907-07-06', '1954-07-13');

INSERT INTO mecenas (nombre, pais, ciudad, fecha_nacimiento, fecha_fallecimiento) VALUES 
    ('John D. Rockefeller Jr.', 'USA', 'New York City', '1874-01-29', '1960-05-11'),
    ('Andrew Carnegie', 'Scotland', 'Dunfermline', '1835-11-25', '1919-08-11'),
    ('Henry Clay Frick', 'USA', 'Pittsburgh', '1849-12-19', '1919-12-02'),
    ('Isabella Stewart Gardner', 'USA', 'Boston', '1840-04-14', '1924-07-17'),
    ('J. Paul Getty', 'USA', 'Los Angeles County, California', '1892-12-15','1976–06–06');

INSERT INTO mecenazgo (id_pintor, id_mecena, fecha_inicio, fecha_final) VALUES 
    (1, 1, '1922-01-01', '1923-01-01'),
    (2, 2, '1888-01-01', '1889-01-01'),
    (3, 3, '1480-01-01', '1490-01-01'),
    (4, 4, '1630-01-01', '1640-01-01'),
    (5, 5, '1938-01-01', '1939-01-01');

