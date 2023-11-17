USE `northwind`;
--  Pair programming Union Tablas (Joins)

/* 1. Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha 
realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/
SELECT `c`. `company_name` AS `NombreEmpresa`,`c`.`customer_id` AS `Identificador`, COUNT(DISTINCT `o`.`order_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK"
    GROUP BY `Identificador`;
	
/* 2. Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas 
adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante 
cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 
joins.*/
SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, SUM(`od`. `quantity`) AS `NumObjetos`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`
    NATURAL JOIN `order_details` AS `od`
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;
    
/* 3. Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de 
objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.*/
SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, 
SUM(`od`. `quantity`) AS `NumObjetos`,
SUM(`od`. `unit_price` * `od`. `quantity` - ((`od`. `discount` * `od`. `unit_price`) * `od`. `quantity`)) AS `DineroTotal`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`
    NATURAL JOIN `order_details` AS `od`
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;
    
/* 4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una consulta 
que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.*/
SELECT `o`.`order_id` AS 'OrderId', `c`. `company_name` AS `NombreEmpresa`, `o`. `order_date` AS `Año`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`;

/* 5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, y el 
total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos)*/
SELECT `c`.`category_id`, `c`.`category_name`,`p`.`product_name`, SUM(`od`. `unit_price` * `od`. `quantity` - ((`od`. `discount` * `od`. `unit_price`) * `od`. `quantity`)) AS `DineroTotal`
FROM `products` AS `p`
INNER JOIN `categories` AS `c`
ON `c`.`category_id`=`p`.`category_id`
INNER JOIN `order_details` AS `od`
ON `p`.`product_id`=`od`.`product_id`
GROUP BY `od`.`product_id`;

/* 6. Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las
 fechas.*/
SELECT `o`.`order_id` AS `OrderID`, `c`.`company_name`AS `CompanyName`, `o`.`order_date` AS `OrderDate`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`;
    
/* 7. Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio Reino Unido
 de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente junto con el número 
 de pedidos.*/
SELECT `c`. `company_name` AS `NombreCliente`, COUNT(DISTINCT `o`.`order_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK"
    GROUP BY `NombreCliente`;
    
/* 8.Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de todos los 
pedidos que han realizado y la fecha del pedido.*/
SELECT `o`.`order_id` AS `OrderID`, `c`. `company_name` AS `NombreCliente`, `o`.`order_date` AS `FechaPedido`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK";
    
/* 9. Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus 
supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes
 decir quién es el director?*/
 SELECT `e`.`city`, `e`.`first_name` AS `NombreEmpleado`,`e`.`last_name` AS `ApellidoEmpleado`, `b`.`city`, `b`.`first_name` AS `NombreJefe`, `b`.`last_name` AS `ApellidoJefe`
	FROM `employees` AS `e`,
    `employees` AS `b`
	WHERE `e`.`reports_to` = `b`.`employee_id`
    ORDER BY `b`.`employee_id`;

-- Fuller es el director porque es el único que no aparece en la columna NombreEmpleado, por lo que no responde a ningún employee_id

/*10. BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. Muestra el ID del pedido, 
el nombre de la empresa y la fecha del pedido (si existe).*/
SELECT `o`.`order_id` AS 'OrderId', `c`.`company_name` AS  'NombreCliente', `o`.`order_date` AS 'OrderDate'
FROM `orders` AS `o`
LEFT JOIN `customers` AS `c`
ON `o`.`customer_id`=`c`.`customer_id`
UNION
SELECT `o`.`order_id` AS 'OrderId', `c`.`company_name` AS  'NombreCliente', `o`.`order_date` AS 'OrderDate'
FROM `orders` AS `o`
RIGHT JOIN `customers` AS `c`
ON `o`.`customer_id`=`c`.`customer_id`;

    


    
    

	