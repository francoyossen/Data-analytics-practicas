SELECT *

FROM Ventas

---- Consulta 1 — Resumen ejecutivo mensual ----

SELECT 
MONTH(fecha_venta) AS Mes,
SUM(cantidad * precio_unitario) AS Total_facturado,
COUNT(id_venta) AS Total_pedido,
AVG(cantidad * precio_unitario) AS Ticket_promedio
FROM Ventas 
GROUP BY 
MONTH(fecha_venta)

---- Consulta 2 — Ranking de productos ----

SELECT TOP 5
id_producto,
SUM(cantidad) AS Cantidad_vendida,
SUM(cantidad * precio_unitario) AS Total_facturado

FROM Ventas

GROUP BY Id_producto
ORDER BY Total_facturado DESC;


---- Consulta 3 — Clientes recurrentes ----

SELECT
id_cliente,
COUNT(*) AS Cantidad_pedidos,
SUM(cantidad * precio_unitario) AS Total_gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1

---- Consulta 4 — Productos por encima/por debajo del promedio ----

WITH FacturacionProductos AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS Total_facturado
    FROM Ventas
    GROUP BY id_producto
)

SELECT
    id_producto,
    Total_facturado,

    CASE
        WHEN Total_facturado > (
            SELECT AVG(Total_facturado)
            FROM FacturacionProductos
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS Clasificacion

FROM FacturacionProductos

ORDER BY Total_facturado DESC;

---- Bloque de cierre - Hallazgos ----

-- El producto 1 fue el que mas facturó, generando un total de ingresos de $3600.0. Representa el 55.86% de los ingresos.
-- Los 5 clientes registrados realizaron 2 compras cada uno, por lo que todos son considerados clientes recurrentes.
-- Los productos 1 y 3 concentran juntos $4.950, representando aproximadamente el 76,8% de la facturacion total.





