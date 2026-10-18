--Entregable 5 - Script 
--Autor: Arturo Aranda
--Fecha: 18/10/2026

-- Consulta 1: Vista base del proyecto
SELECT v.fecha_venta as fecha,
	c.id_cliente,
	c.nombre as nombre_cliente,
	c.ciudad,
	p.id_producto,
	p.nombre_producto,
	cat.nombre_categoria,
	v.cantidad,
	v.precio_unitario,
	v.cantidad * v.precio_unitario as total_venta

	FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria;

-- Consulta 2: Clientes que no compraron
SELECT c.id_cliente,
	c.nombre,
	c.fecha_registro	
FROM clientes as c
	LEFT JOIN ventas as v
	on v.id_cliente = c.id_cliente
WHERE v.id_venta IS NULL;

--Hallazgo 1 : Los 5 diferentes clientes tienen al menos una compra realizada

-- Consulta 3: Productos que no se compraron
SELECT p.id_producto,
	p.nombre_producto,
	cat.nombre_categoria,
	p.precio
FROM productos as p
	INNER JOIN categorias as cat
	ON p.id_categoria = cat.id_categoria
	LEFT JOIN ventas as v
	ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL

--Hallazgo 2 : Los 6 diferentes productos se compraron , todos los productos tienen rotacion.

-- Consulta 4: Consolidado por origen
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Periodo 1' AS canal
    FROM ventas
    WHERE fecha_venta < '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Periodo 2' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-10'
) AS consolidado
GROUP BY canal
ORDER BY canal;