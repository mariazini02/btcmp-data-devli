-- ============================================================
-- Semana 6 · Clase 12 · Tarea — JOINs sobre el minimercado
-- Base de datos: minimercado
-- ============================================================


-- ===== INNER JOIN =====

-- Ejercicio 1: proveedores y sus productos (solo proveedores que tienen productos)
SELECT pr.nombre AS proveedor, p.nombre AS producto
FROM proveedores pr
INNER JOIN productos p ON p.proveedor_id = pr.id
ORDER BY pr.nombre, p.nombre;


-- ===== LEFT JOIN =====

-- Ejercicio 2: todos los proveedores y cuántos productos tiene cada uno (incluye los de 0)
-- COUNT(p.id) cuenta solo filas reales; con COUNT(*) un proveedor sin productos contaría 1.
SELECT pr.nombre AS proveedor, COUNT(p.id) AS cantidad_productos
FROM proveedores pr
LEFT JOIN productos p ON p.proveedor_id = pr.id
GROUP BY pr.id, pr.nombre
ORDER BY cantidad_productos DESC, pr.nombre;

-- Ejercicio 3: ventas que no tienen ningún producto cargado en venta_productos
SELECT v.id AS venta_id, v.fecha, v.total
FROM ventas v
LEFT JOIN venta_productos vp ON vp.venta_id = v.id
WHERE vp.venta_id IS NULL
ORDER BY v.id;


-- ===== RIGHT JOIN =====

-- Ejercicio 4: todos los métodos de pago y cuántas ventas tiene cada uno
SELECT mp.nombre AS metodo_pago, COUNT(v.id) AS cantidad_ventas
FROM ventas v
RIGHT JOIN metodos_pago mp ON v.metodo_pago_id = mp.id
GROUP BY mp.id, mp.nombre
ORDER BY cantidad_ventas DESC, mp.nombre;


-- ===== FULL OUTER JOIN =====

-- Ejercicio 5: productos que nunca se vendieron
-- Del lado de venta_productos queda NULL cuando el producto no tiene ninguna venta.
SELECT p.id, p.nombre AS producto
FROM productos p
FULL OUTER JOIN venta_productos vp ON vp.producto_id = p.id
WHERE vp.venta_id IS NULL
  AND p.id IS NOT NULL
ORDER BY p.nombre;


-- ===== CROSS JOIN =====

-- Ejercicio 6: todas las combinaciones de producto y método de pago
-- Devuelve (filas de productos) x (filas de metodos_pago) = 42 x 8 = 336 filas,
-- porque CROSS JOIN une cada fila de una tabla con todas las filas de la otra.
SELECT p.nombre AS producto, p.precio, mp.nombre AS metodo_pago
FROM productos p
CROSS JOIN metodos_pago mp
ORDER BY p.nombre, mp.nombre;


-- ===== JOIN múltiple =====

-- Ejercicio 7: cliente, fecha de venta y cantidad total de unidades de cada venta
SELECT v.id AS venta_id, c.nombre AS cliente, v.fecha, SUM(vp.cantidad) AS unidades_totales
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN venta_productos vp ON vp.venta_id = v.id
GROUP BY v.id, c.nombre, v.fecha
ORDER BY v.fecha, v.id;

-- Ejercicio 8: total facturado (cantidad * precio_unitario) por proveedor, de mayor a menor
SELECT pr.nombre AS proveedor, SUM(vp.cantidad * vp.precio_unitario) AS total_facturado
FROM venta_productos vp
JOIN productos p ON vp.producto_id = p.id
JOIN proveedores pr ON p.proveedor_id = pr.id
GROUP BY pr.id, pr.nombre
ORDER BY total_facturado DESC;


-- ===== JOIN múltiple combinando INNER y LEFT =====

-- Ejercicio 9: todos los productos con su proveedor y unidades vendidas
-- El LEFT JOIN con venta_productos hace que los nunca vendidos aparezcan (COALESCE los pasa de NULL a 0).
SELECT p.nombre AS producto, pr.nombre AS proveedor,
       COALESCE(SUM(vp.cantidad), 0) AS unidades_vendidas
FROM productos p
JOIN proveedores pr ON p.proveedor_id = pr.id
LEFT JOIN venta_productos vp ON vp.producto_id = p.id
GROUP BY p.id, p.nombre, pr.nombre
ORDER BY unidades_vendidas DESC, p.nombre;

-- Ejercicio 10: todas las ventas con cliente, método de pago y cantidad de productos distintos
-- Las ventas sin productos cargados aparecen con 0 gracias al LEFT JOIN.
SELECT v.id AS venta_id, c.nombre AS cliente, mp.nombre AS metodo_pago,
       COUNT(DISTINCT vp.producto_id) AS productos_distintos
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN metodos_pago mp ON v.metodo_pago_id = mp.id
LEFT JOIN venta_productos vp ON vp.venta_id = v.id
GROUP BY v.id, c.nombre, mp.nombre
ORDER BY v.id;

-- Ejercicio 11: todos los proveedores y en cuántas ventas distintas se vendió algún producto suyo
SELECT pr.nombre AS proveedor, COUNT(DISTINCT vp.venta_id) AS ventas_distintas
FROM proveedores pr
LEFT JOIN productos p ON p.proveedor_id = pr.id
LEFT JOIN venta_productos vp ON vp.producto_id = p.id
GROUP BY pr.id, pr.nombre
ORDER BY ventas_distintas DESC, pr.nombre;

-- Ejercicio 11 (variante): el segundo LEFT JOIN cambiado por INNER JOIN
-- Desaparecen los proveedores que no tienen productos, o cuyos productos nunca se vendieron:
-- el INNER JOIN exige coincidencia en venta_productos y descarta las filas con NULL.
SELECT pr.nombre AS proveedor, COUNT(DISTINCT vp.venta_id) AS ventas_distintas
FROM proveedores pr
LEFT JOIN productos p ON p.proveedor_id = pr.id
INNER JOIN venta_productos vp ON vp.producto_id = p.id
GROUP BY pr.id, pr.nombre
ORDER BY ventas_distintas DESC, pr.nombre;