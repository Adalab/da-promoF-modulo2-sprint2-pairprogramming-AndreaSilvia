USE `northwind`;
/* 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.*/

-- primero llamamos a la query que nos llame a id_cliente y nombreCompañia
WITH `nombre_Compañia` AS(
	SELECT `company_name` AS `nombreCompañia`, `customer_id` AS `id_cliente` 
	FROM `customers`)
SELECT * 
	FROM `nombre_Compañia`;    

/* 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".*/

WITH `nombre_Compañia` AS(
	SELECT `company_name` AS `NombreCompañia`, `customer_id` AS `id_cliente` 
	FROM `customers`
    WHERE `country` = "Germany")
SELECT * 
	FROM `nombre_Compañia`;

/* 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/

WITH `factura_fecha` AS (
SELECT `o`.`customer_id`AS `CustomerID`,`o`.`order_id` AS `OrderID`, `o`.`order_date` AS `Fechas_Pedido`, `c`.`company_name` AS `CompanyName`
	FROM `orders` AS `o`
    NATURAL JOIN  `customers` AS `c`)
SELECT *
		FROM `factura_fecha`;
    
    
/* 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/

WITH `NumeroFacturas` AS (
SELECT `o`.`customer_id`AS `CustomerID`, `c`.`company_name` AS `CompanyName`, COUNT(`o`.`customer_id`) AS `NumeroFacturas`
	FROM `orders` AS `o`
    NATURAL JOIN  `customers` AS `c`
    GROUP BY `c`.`company_name`,
    `o`.`customer_id`)
SELECT *
		FROM `NumeroFacturas`;


/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/
-- tabla order_details
-- sumamos la cantidad total de pedidos para el Denominador de la Media
-- SUM(`quantity`)
-- para cada product_id --> `quantity` determinada
-- `product_id` ?¿ `quantity`

SELECT `p`.`product_name` AS `NombreProducto`, CTE AS `Media`
	FROM `productos` AS `p`
    NATURAL JOIN `order_details` as `o`;
    
    
WITH `numerador` AS (SELECT SUM(`quantity`)AS `SUMA_DATOS`
	FROM `order_details`
	GROUP BY `product_id`)
SELECT *
FROM (
	WITH `denominador` AS (SELECT SUM(`quantity`) AS `SUMA_TOTAL`   
	FROM `order_details`)
SELECT *
FROM (/*`denominador`
JOIN `numerador`*/ 
	WITH `media`AS (SELECT `SUMA_DATOS`/`SUMA_TOTAL` AS `MEDIA`
    FROM `denominador`
    JOIN `numerador`) AS `operacion`
    
    SELECT *
    FROM `media`
		


SELECT `SUMA_DATOS`/`SUMA_TOTAL`
FROM `ALIAS`;

SELECT `o3`.`product_id`,(SELECT SUM(`o1`.`quantity`)
	FROM `order_details` AS `o1`
	GROUP BY `o1`.`product_id`)/(SELECT SUM(`o2`.`quantity`) FROM `order_details` AS `o2`)
FROM `order_details` AS `o3`
GROUP BY `o3`.`product_id`




/* BONUS: Estos ejercicios no es obligatorio realizarlos. Los podéis hacer más adelante para poder practicar las CTE´s.*/

/* 6. Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo.*/

/* 7. La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos que ha hecho cada uno de ellos.*/

/* 8. Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente.*/

/* 9. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos clientes que 
hayan hecho más de 6 pedidos en el año 1998.*/

/* 10 .Nos piden que obtengamos el importe total (teniendo en cuenta los descuentos) de cada pedido de la tabla orders y el customer_id asociado a
 cada pedido.*/
