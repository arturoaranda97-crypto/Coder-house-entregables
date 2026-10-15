--Entregable 4 - Script 
--Autor: Arturo Aranda
--Fecha: 11/10/2026

-- 1.Resumen ejecutivo mensual
Select
		MONTH(fecha_venta) AS mes,
		SUM(cantidad*precio_unitario) AS total_facturado,
		COUNT(*) AS Cantidad_de_pedidos,
		AVG(cantidad*precio_unitario) AS Ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- 2.Ranking productos
SELECT TOP 5
		id_producto,
		SUM(cantidad*precio_unitario) AS total_facturado,
		SUM(cantidad) AS cantidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- 3.Clientes recurrentes
SELECT
		id_cliente,
		COUNT (*) AS cantidad_de_pedidos,
		SUM(cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1;

--4.Meses por encima/por debajo del promedio
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
            (
                SELECT SUM(cantidad * precio_unitario) /
                       COUNT(DISTINCT MONTH(fecha_venta))
                FROM ventas
            )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS estado
FROM ventas
GROUP BY MONTH(fecha_venta);

-- 1.El producto 1 representó el 55,8% de lo facturado en marzo con 3 productos vendidos (representa el 11,5%)
-- 2.El producto 2 es que mas rotacion tiene , se vendieron 13 (50% de productos) 
-- 3.Los clientes 1 y 5 generaron un ingreso de 4740.00 (73,5% de lo facturado en el mes)
