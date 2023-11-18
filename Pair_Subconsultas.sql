USE `northwind`;
/* 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query 
correlacionada.
    
SELECT MAX(`order_date`)
    FROM `orders` AS `o`
    WHERE `employee_id`=2;*/
SELECT *
FROM `orders` AS `o`
WHERE `order_date`= (SELECT MAX(`order_date`)
    FROM `orders` AS `o2`
    WHERE `o`.`employee_id`=`o2`.`employee_id`);

/* 2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries
 correlacionadas.*/
 SELECT `product_id` AS 'IdProduct', MAX(`unit_price`) AS 'PrecioMáximo'
 FROM `products` AS `p`
 GROUP BY `P`.`product_id`
 HAVING MAX(`unit_price`)= (SELECT MAX(`unit_price`)
 FROM `order_details` AS `o`
 WHERE `p`.`product_id`=`o`.`product_id`);
 /* 3. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. En concreto, tienen especial
 interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/
 SELECT `product_id` AS 'IdProducto', `product_name` AS 'NombreProducto', `category_id` AS 'IdCategoría'
FROM `products` AS `p`
WHERE `category_id` = (
	SELECT `category_id`
    FROM `categories` AS `c`
    WHERE `category_name`='Beverages');

 /* 4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores 
adicionales.*/
SELECT `country`
FROM `customers`
GROUP BY `country`
HAVING `country` NOT IN (
	SELECT `country`
    FROM `suppliers`);
/* 5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo
 pedido.*/
SELECT `order_id` AS 'OrderID' , `customer_id`
FROM `orders`
WHERE `order_id` IN (
	SELECT `order_id`
	FROM `order_details`
	WHERE `quantity`>=20
	AND `product_id`=(
		SELECT `product_id`
		FROM `products`
		WHERE `product_name`="Grandma's Boysenberry Spread"));

 
 /* 6. Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT `product_name`AS `10 Most expensive products`, `unit_price` AS `UnitPrice`
FROM `products`
ORDER BY `unit_price` DESC
LIMIT 10;

-- Como estaba todo en la misma tabla, no hemos visto necesario hacer una subconsulta en este caso. 
-- Contemplamos que podríamos haberlo sacado también de la tabla `order_details`.

/* BONUS:
7. Qué producto es más popular
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.*/

SELECT `product_name`AS `ProductName`, `maximo`.`suma`
FROM `products`,
(SELECT `product_id`, SUM(`quantity`) AS `CantidadTotal`
FROM `order_details`
GROUP BY `product_id`) AS `maximo`
WHERE `maximo`.`product_id`=`products`.`product_id`
ORDER BY `maximo`.`suma` DESC
LIMIT 1



