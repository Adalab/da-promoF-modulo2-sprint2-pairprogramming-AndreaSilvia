USE `northwind`;
--  Pair programming Union Tablas (Joins)

-- 1 
SELECT `c`. `company_name` AS `NombreEmpresa`,`c`.`customer_id` AS `Identificador`, COUNT(DISTINCT `o`.`order_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK"
    GROUP BY `Identificador`;
	
-- 2 
SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, SUM(`od`. `quantity`) AS `NumObjetos`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`
    NATURAL JOIN `order_details` AS `od`
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;
    
-- 3
SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, 
SUM(`od`. `quantity`) AS `NumObjetos`,
SUM(`od`. `unit_price` * `od`. `quantity` - ((`od`. `discount` * `od`. `unit_price`) * `od`. `quantity`)) AS `DineroTotal`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`
    NATURAL JOIN `order_details` AS `od`
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;
-- 6
SELECT `o`.`order_id` AS `OrderID`, `c`.`company_name`AS `CompanyName`, `o`.`order_date` AS `OrderDate`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`;
    
-- 7 
SELECT `c`. `company_name` AS `NombreCliente`, COUNT(DISTINCT `o`.`order_id`) AS `NumeroPedidos`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK"
    GROUP BY `NombreCliente`;
    
-- 8
SELECT `o`.`order_id` AS `OrderID`, `c`. `company_name` AS `NombreCliente`, `o`.`order_date` AS `FechaPedido`
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`country` = "UK";
    
-- 9
 SELECT `e`.`city`, `e`.`first_name` AS `NombreEmpleado`,`e`.`last_name` AS `ApellidoEmpleado`, `b`.`city`, `b`.`first_name` AS `NombreJefe`, `b`.`last_name` AS `ApellidoJefe`
	FROM `employees` AS `e`,
    `employees` AS `b`
	WHERE `e`.`reports_to` = `b`.`employee_id`
    ORDER BY `b`.`employee_id`;

-- Fuller es el director porque es el único que no aparece en la columna NombreEmpleado, por lo que no responde a ningún employee_id



    


    
    

	