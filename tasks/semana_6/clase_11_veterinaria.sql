-- ============================================================
-- Semana 6 · Clase 11 · Tarea — Diseñar una base de datos transaccional
-- Caso elegido: Veterinaria
-- Base de datos: veterinaria_db
-- ============================================================

-- Limpieza para poder ejecutar el archivo más de una vez
DROP TABLE IF EXISTS cita_tratamiento;
DROP TABLE IF EXISTS tratamientos;
DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS historias_clinicas;
DROP TABLE IF EXISTS mascotas;
DROP TABLE IF EXISTS duenos;


-- ============================================================
-- CREATE TABLE
-- ============================================================

-- Relación 1:N: un dueño puede tener varias mascotas; cada mascota tiene un solo dueño.
-- La FK dueno_id está en "mascotas" (el lado "muchos") y es NOT NULL.
CREATE TABLE duenos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE mascotas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(20) NOT NULL CHECK (especie IN ('perro', 'gato', 'ave', 'otro')),
    fecha_nacimiento DATE,
    dueno_id INT NOT NULL REFERENCES duenos(id)
);

-- Relación 1:1: cada mascota tiene una sola historia clínica y viceversa.
-- La FK mascota_id es UNIQUE: así una mascota no puede tener dos historias.
CREATE TABLE historias_clinicas (
    id SERIAL PRIMARY KEY,
    mascota_id INT NOT NULL UNIQUE REFERENCES mascotas(id),
    fecha_apertura DATE DEFAULT CURRENT_DATE,
    observaciones TEXT
);

-- Relación 1:N: una mascota puede tener muchas citas; cada cita es de una sola mascota.
CREATE TABLE citas (
    id SERIAL PRIMARY KEY,
    mascota_id INT NOT NULL REFERENCES mascotas(id),
    fecha_hora TIMESTAMP NOT NULL,
    motivo VARCHAR(200),
    estado VARCHAR(20) DEFAULT 'programada' CHECK (estado IN ('programada', 'realizada', 'cancelada'))
);

CREATE TABLE tratamientos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    costo NUMERIC(10,2) CHECK (costo >= 0)
);

-- Relación N:N: una cita puede incluir varios tratamientos y un tratamiento puede estar en varias citas.
-- La tabla intermedia usa una clave primaria compuesta para evitar duplicados.
CREATE TABLE cita_tratamiento (
    cita_id INT REFERENCES citas(id),
    tratamiento_id INT REFERENCES tratamientos(id),
    PRIMARY KEY (cita_id, tratamiento_id)
);


-- ============================================================
-- INSERT
-- ============================================================

INSERT INTO duenos (nombre, telefono, email) VALUES
('Laura Benítez',  '3794-111111', 'laura@mail.com'),
('Martín Acosta',  '3794-222222', 'martin@mail.com'),
('Carolina Ruiz',  '3794-333333', 'carolina@mail.com');

INSERT INTO mascotas (nombre, especie, fecha_nacimiento, dueno_id) VALUES
('Firulais', 'perro', '2019-03-12', 1),
('Michi',    'gato',  '2020-07-25', 1),
('Rocky',    'perro', '2021-11-05', 2),
('Luna',     'gato',  '2022-02-18', 3);

INSERT INTO historias_clinicas (mascota_id, fecha_apertura, observaciones) VALUES
(1, '2019-05-01', 'Vacunas al día'),
(2, '2020-09-10', 'Sin antecedentes'),
(3, '2022-01-15', 'Alergia a ciertos alimentos'),
(4, '2022-04-02', 'Esterilizada');

INSERT INTO citas (mascota_id, fecha_hora, motivo, estado) VALUES
(1, '2024-05-10 10:00', 'Control anual',   'realizada'),
(1, '2024-06-02 11:30', 'Vacunación',      'realizada'),
(2, '2024-06-15 09:00', 'Revisión dental', 'programada'),
(3, '2024-06-20 16:00', 'Control de peso', 'cancelada'),
(4, '2024-07-01 12:00', 'Vacunación',      'programada');

INSERT INTO tratamientos (nombre, descripcion, costo) VALUES
('Vacuna antirrábica', 'Dosis anual contra la rabia', 4500.00),
('Desparasitación',    'Tratamiento antiparasitario', 2500.00),
('Limpieza dental',    'Limpieza y control de sarro', 8000.00);

INSERT INTO cita_tratamiento (cita_id, tratamiento_id) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(5, 1);