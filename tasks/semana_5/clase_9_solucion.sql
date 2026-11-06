-- Semana 5 Clase 9 
-- PARTE 1 — Departamentos en venta/alquiler
-- ============================================================

DROP TABLE IF EXISTS apartments;

CREATE TABLE apartments (
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(50),
    address        VARCHAR(100),
    city           VARCHAR(50),
    postal_code    VARCHAR(10),
    bedrooms       INT,
    area_m2        NUMERIC(6,2),
    price          NUMERIC(10,2),
    available      BOOLEAN,
    published_date DATE
);

INSERT INTO apartments (name, address, city, postal_code, bedrooms, area_m2, price, available, published_date) VALUES
('Depto A',  'Av. Siempre Viva 123', 'Buenos Aires', 'C1000', 2,  55.50, 120000, TRUE,  '2023-08-01'),
('Depto B',  'Calle Falsa 456',      'Buenos Aires', 'C1001', 1,  38.00,  85000, TRUE,  '2023-08-03'),
('Depto C',  'Av. Corrientes 1500',  'Buenos Aires', 'C1043', 3,  92.75, 210000, FALSE, '2023-07-20'),
('Depto D',  'San Martín 320',       'Córdoba',      'X5000', 2,  58.00,  95000, TRUE,  '2023-08-10'),
('Depto E',  'Obispo Trejo 87',      'Córdoba',      'X5000', 1,  35.50,  70000, TRUE,  '2023-08-12'),
('Depto F',  'Av. Colón 1020',       'Córdoba',      'X5004', 3,  88.00, 150000, FALSE, '2023-07-25'),
('Depto G',  'Pellegrini 755',       'Rosario',      'S2000', 2,  59.90, 105000, TRUE,  '2023-08-15'),
('Depto H',  'Bv. Oroño 1340',       'Rosario',      'S2000', 4, 120.00, 260000, TRUE,  '2023-07-30'),
('Depto I',  'Córdoba 2210',         'Rosario',      'S2002', 1,  40.25,  78000, FALSE, '2023-08-02'),
('Depto J',  'Av. Libertad 98',      'Corrientes',   'W3400', 2,  52.00,  68000, TRUE,  '2023-08-18'),
('Depto K',  'Junín 640',            'Corrientes',   'W3400', 3,  85.50, 110000, TRUE,  '2023-08-20'),
('Depto L',  'Mendoza 455',          'Corrientes',   'W3400', 1,  33.00,  48000, TRUE,  '2023-08-22'),
('Depto M',  'Av. Belgrano 910',     'Resistencia',  'H3500', 2,  57.30,  72000, FALSE, '2023-08-05'),
('Depto N',  'Mitre 233',            'Resistencia',  'H3500', 3,  80.00,  98000, TRUE,  '2023-08-25'),
('Depto O',  'Sarmiento 1180',       'Mendoza',      'M5500', 2,  56.80, 115000, TRUE,  '2023-08-08'),
('Depto P',  'Av. San Martín 2050',  'Mendoza',      'M5500', 4, 130.00, 280000, FALSE, '2023-07-18'),
('Depto Q',  'Las Heras 612',        'Mendoza',      'M5500', 1,  36.40,  82000, TRUE,  '2023-08-28'),
('Depto R',  'Av. Alem 345',         'Salta',        'A4400', 2,  54.00,  88000, TRUE,  '2023-09-01'),
('Depto S',  'Caseros 770',          'Salta',        'A4400', 3,  90.00, 135000, TRUE,  '2023-09-03'),
('Depto T',  'Balcarce 128',         'Salta',        'A4400', 1,  34.50,  60000, FALSE, '2023-08-30'),
('Depto U',  'Av. Rivadavia 4500',   'Buenos Aires', 'C1424', 2,  48.00, 125000, TRUE,  '2023-09-05'),
('Depto V',  'Thames 1890',          'Buenos Aires', 'C1414', 1,  42.00,  98000, TRUE,  '2023-09-07'),
('Depto W',  'Av. Cabildo 2300',     'Buenos Aires', 'C1428', 4, 140.00, 320000, TRUE,  '2023-09-10'),
('Depto X',  'Dean Funes 560',       'Córdoba',      'X5000', 2,  49.50,  82000, FALSE, '2023-09-02'),
('Depto Y',  'Av. Pellegrini 1900',  'Rosario',      'S2000', 3,  95.00, 175000, TRUE,  '2023-09-12'),
('Depto Z',  'Salta 880',            'Rosario',      'S2000', 2,  45.00,  92000, TRUE,  '2023-09-14'),
('Depto AA', 'Av. Costanera 700',    'Corrientes',   'W3400', 3,  78.00, 105000, FALSE, '2023-09-08'),
('Depto AB', 'Güemes 415',           'Salta',        'A4400', 2,  58.50,  92000, TRUE,  '2023-09-15'),
('Depto AC', 'Av. Italia 1250',      'Resistencia',  'H3500', 1,  37.00,  52000, TRUE,  '2023-09-18'),
('Depto AD', 'Godoy Cruz 305',       'Mendoza',      'M5500', 3,  86.20, 155000, TRUE,  '2023-09-20');

-- Ejercicio 1.1: departamentos disponibles, del más barato al más caro
SELECT *
FROM apartments
WHERE available = TRUE
ORDER BY price ASC;

-- Ejercicio 1.2: precio promedio por ciudad
SELECT city, AVG(price) AS avg_price
FROM apartments
GROUP BY city;

-- Ejercicio 1.3: 2 o más habitaciones y menos de 60 m²
SELECT *
FROM apartments
WHERE bedrooms >= 2
  AND area_m2 < 60;


-- ============================================================
-- PARTE 2 — Ventas
-- ============================================================

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(30),
    price NUMERIC,
    quantity INT,
    sale_date DATE
);

INSERT INTO sales (product, category, price, quantity, sale_date) VALUES
('Mouse', 'Electronics', 15, 4, '2023-07-10'),
('Keyboard', 'Electronics', 30, 2, '2023-07-11'),
('Notebook', 'Stationery', 8, 10, '2023-07-12'),
('Pen', 'Stationery', 2, 25, '2023-07-13'),
('Headphones', 'Electronics', 40, 3, '2023-07-14'),
('Monitor', 'Electronics', 120, 1, '2023-07-15'),
('Desk Chair', 'Furniture', 85, 2, '2023-07-16'),
('Notebook Case', 'Accessories', 25, 3, '2023-07-17'),
('Printer Paper', 'Stationery', 6, 15, '2023-07-18'),
('USB Drive', 'Electronics', 12, 5, '2023-07-19'),
('Desk Lamp', 'Furniture', 35, 4, '2023-07-20'),
('Stapler', 'Stationery', 7, 6, '2023-07-21'),
('Calculator', 'Electronics', 20, 3, '2023-07-22'),
('Water Bottle', 'Accessories', 10, 8, '2023-07-23'),
('Laptop Stand', 'Accessories', 45, 2, '2023-07-24'),
('Office Desk', 'Furniture', 150, 1, '2023-07-25'),
('Whiteboard', 'Furniture', 60, 1, '2023-07-26'),
('Marker Set', 'Stationery', 5, 12, '2023-07-27'),
('Mouse Pad', 'Accessories', 8, 7, '2023-07-28'),
('Webcam', 'Electronics', 50, 2, '2023-07-29'),
('Smartphone', 'Electronics', 300, 1, '2023-07-30'),
('Notebook Pro', 'Electronics', 900, 1, '2023-07-31'),
('File Cabinet', 'Furniture', 120, 1, '2023-08-01'),
('Backpack', 'Accessories', 40, 3, '2023-08-02'),
('Binder', 'Stationery', 4, 20, '2023-08-03'),
('Headset Stand', 'Accessories', 15, 5, '2023-08-04'),
('Desk Organizer', 'Accessories', 12, 6, '2023-08-05'),
('Laptop Sleeve', 'Accessories', 30, 2, '2023-08-06'),
('Paper Clips', 'Stationery', 1, 50, '2023-08-07'),
('Surge Protector', 'Electronics', 25, 3, '2023-08-08'),
('Pen Holder', 'Accessories', 5, 10, '2023-08-09');

-- Ejercicio 2.1: todas las ventas de la categoría 'Electronics'
SELECT *
FROM sales
WHERE category = 'Electronics';

-- Ejercicio 2.2: total de ingresos por categoría (price * quantity)
SELECT category, SUM(price * quantity) AS total_revenue
FROM sales
GROUP BY category;

-- Ejercicio 2.3: categoría con mayor ingreso total
SELECT category, SUM(price * quantity) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 1;

-- Ejercicio 2.4: ventas donde el precio del producto sea mayor a 20
SELECT *
FROM sales
WHERE price > 20;

-- Ejercicio 2.5: total de unidades vendidas por producto
SELECT product, SUM(quantity) AS total_units
FROM sales
GROUP BY product;

-- Ejercicio 2.6: ingreso promedio por venta para cada producto
SELECT product, AVG(price * quantity) AS avg_revenue
FROM sales
GROUP BY product;

-- Ejercicio 2.7: los 3 productos con mayor cantidad total vendida
SELECT product, SUM(quantity) AS total_units
FROM sales
GROUP BY product
ORDER BY total_units DESC
LIMIT 3;

-- Ejercicio 2.8: ventas realizadas después del 12 de julio de 2023
SELECT *
FROM sales
WHERE sale_date > '2023-07-12';

-- Ejercicio 2.9: categorías cuyo ingreso total sea mayor a 50
SELECT category, SUM(price * quantity) AS total_revenue
FROM sales
GROUP BY category
HAVING SUM(price * quantity) > 50;

-- Ejercicio 2.10: ventas donde el producto comience con la letra H
SELECT *
FROM sales
WHERE product LIKE 'H%';

-- Ejercicio 2.11: cantidad promedio de productos vendidos por categoría
SELECT category, AVG(quantity) AS avg_quantity
FROM sales
GROUP BY category;

-- Ejercicio 2.12: ventas con el ingreso por fila, de mayor a menor ingreso
SELECT *, price * quantity AS revenue
FROM sales
ORDER BY revenue DESC;

-- Ejercicio 2.13: 'Electronics' con cantidad mayor a 2 y precio menor a 40
SELECT *
FROM sales
WHERE category = 'Electronics'
  AND quantity > 2
  AND price < 40;
