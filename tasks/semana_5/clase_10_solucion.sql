-- ============================================================
-- Semana 5 · Clase 10 · Tarea — Relaciones con foreign keys
-- Base de datos: relaciones_db
-- (crearla antes, conectada a "postgres": CREATE DATABASE relaciones_db;)
-- ============================================================

-- Limpieza para poder ejecutar el archivo más de una vez
-- (se borran primero las tablas que dependen de otras)
DROP TABLE IF EXISTS pacientes_enfermedades;
DROP TABLE IF EXISTS enfermedades;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS clases;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS conductores;


-- ============================================================
-- CREATE TABLE
-- ============================================================

-- Relación 1:1: cada conductor tiene un solo vehículo y cada vehículo un solo conductor.
-- La FK conductor_id es UNIQUE: así un conductor no puede repetirse en vehiculos.
CREATE TABLE conductores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    licencia VARCHAR(20) UNIQUE,
    fecha_ingreso DATE
);

CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    patente VARCHAR(10) UNIQUE,
    modelo VARCHAR(50),
    conductor_id INT UNIQUE REFERENCES conductores(id)
);

-- Relación 1:N: un profesor dicta muchas clases, pero cada clase tiene un solo profesor.
-- La FK profesor_id está en la tabla "muchos" (clases) y es NOT NULL: toda clase necesita profesor.
CREATE TABLE profesores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    fecha_contratacion DATE
);

CREATE TABLE clases (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    horario VARCHAR(50),
    profesor_id INT NOT NULL REFERENCES profesores(id)
);

-- Relación N:N: un paciente tiene varias enfermedades y una enfermedad afecta a muchos pacientes.
-- Se resuelve con una tabla intermedia cuya clave primaria compuesta evita duplicados.
CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20)
);

CREATE TABLE enfermedades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel_gravedad VARCHAR(10) CHECK (nivel_gravedad IN ('leve', 'moderada', 'grave'))
);

CREATE TABLE pacientes_enfermedades (
    paciente_id INT REFERENCES pacientes(id),
    enfermedad_id INT REFERENCES enfermedades(id),
    fecha_diagnostico DATE,
    PRIMARY KEY (paciente_id, enfermedad_id)
);


-- ============================================================
-- INSERT
-- (primero las tablas "padre", después las que las referencian)
-- ============================================================

-- Datos 1:1
INSERT INTO conductores (nombre, licencia, fecha_ingreso) VALUES
('Juan Pérez',   'LIC-001', '2022-03-15'),
('María Gómez',  'LIC-002', '2021-07-01'),
('Carlos López', 'LIC-003', '2023-01-10');

INSERT INTO vehiculos (patente, modelo, conductor_id) VALUES
('ABC123', 'Toyota Hilux', 1),
('DEF456', 'Ford Ranger',  2),
('GHI789', 'Fiat Cronos',  3);

-- Datos 1:N
INSERT INTO profesores (nombre, especialidad, fecha_contratacion) VALUES
('Laura Fernández', 'Matemática', '2019-03-01'),
('Diego Ramírez',   'Historia',   '2020-08-15'),
('Sofía Torres',    'Química',    '2021-02-20');

INSERT INTO clases (nombre, horario, profesor_id) VALUES
('Álgebra I',          'Lunes 08:00',     1),
('Cálculo',            'Miércoles 10:00', 1),
('Historia Argentina', 'Martes 09:00',    2),
('Química General',    'Jueves 14:00',    3);

-- Datos N:N
INSERT INTO pacientes (nombre, fecha_nacimiento, telefono) VALUES
('Ana Martínez', '1985-04-12', '3794-111111'),
('Pedro Sosa',   '1990-09-30', '3794-222222'),
('Lucía Díaz',   '1978-12-05', '3794-333333');

INSERT INTO enfermedades (nombre, descripcion, nivel_gravedad) VALUES
('Diabetes',     'Alteración del nivel de azúcar en sangre', 'grave'),
('Hipertensión', 'Presión arterial elevada',                 'moderada'),
('Gripe',        'Infección viral respiratoria',             'leve');

INSERT INTO pacientes_enfermedades (paciente_id, enfermedad_id, fecha_diagnostico) VALUES
(1, 1, '2023-05-10'),
(1, 2, '2023-06-15'),
(2, 2, '2024-01-20'),
(2, 3, '2024-03-06'),
(3, 3, '2024-03-05');


-- ============================================================
-- PRUEBA DE CONSTRAINT (comentada a propósito: este INSERT falla)
-- ============================================================

-- Intento de asignar un segundo vehículo al conductor 1,
-- que ya tiene la Toyota Hilux. conductor_id es UNIQUE, por eso Postgres lo rechaza.
--
-- INSERT INTO vehiculos (patente, modelo, conductor_id) VALUES
-- ('JKL012', 'Renault Kangoo', 1);
--
-- Error devuelto por PostgreSQL:
-- ERROR:  duplicate key value violates unique constraint "vehiculos_conductor_id_key"
-- Key (conductor_id)=(1) already exists.
-- SQL state: 23505