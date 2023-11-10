USE `northwind`
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
SELECT `c`. `company_name` AS `NombreEmpresa`, YEAR(`o`. `order_date`) AS `Año`, SUM(`od`. `quantity`) AS `NumObjetos`, (`od`. `unit_price` * `od`. `quantity` - (`od`. `discount` * `od`. `unit_price` * `od`. `quantity`)) AS `DineroTotal`
	FROM `orders` AS `o`
    NATURAL JOIN `customers` AS `c`
    NATURAL JOIN `order_details` AS `od`
    WHERE `c`.`country` = "UK"
    GROUP BY `Año`,`NombreEmpresa`;


    
    
    

	