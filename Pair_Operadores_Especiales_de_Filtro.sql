USE `northwind`;
/* 1. Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en 
ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/
SELECT `city` AS 'City', `company_name` AS 'CompanyName', `contact_name` AS 'ContactName'
	FROM `customers`
    WHERE `city` LIKE 'A%' OR `city` LIKE 'B%';

/* 2. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior y el número de total de pedidos que han hecho todas 
las ciudades que empiezan por "L".*/
SELECT `o`.`ship_city` AS 'Ciudad',`c`.`company_name` AS 'Empresa', `c`.`contact_name` AS 'PersonaContacto',  COUNT(DISTINCT `o`.`order_id`) AS 'NumeroPedidos'
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `c`.`city` LIKE 'L%'
	GROUP BY `Empresa`, `PersonaContacto`,`Ciudad`;

/* 3. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". Extraer el nombre de contacto, su posisión 
(contact_title) y el nombre de la compañia*/
SELECT `contact_name` AS 'ContactName', `contact_title` AS 'ContactTitle', `company_name` AS 'CompanyName'
FROM `customers` AS `c`
WHERE `contact_title` NOT LIKE '%Sales%';

/* 4. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/
SELECT `contact_name` AS 'contactname'
FROM `customers` AS `c`
WHERE `contact_name` NOT LIKE '_A%';

/* 5. Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. Mostrad la ciudad 
a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber
 duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. Para ello añade el valor que le 
 quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT*/
SELECT  `city` AS 'City', `company_name` AS 'CompanyName', `contact_name` AS 'ContactName',
CASE
	WHEN `company_name` IS NOT NULL THEN 'Customer'
	END as `Relationship`
 FROM `customers`
 UNION
 SELECT `city` AS 'City', `company_name` AS 'CompanyName', `contact_name` AS 'ContactName',
 CASE
	WHEN `company_name`IS NOT NULL THEN 'Supplier'
	END as `Relationship`
 FROM `suppliers`;
 
 /* 6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/
 SELECT `description` 
FROM `categories` AS `c`
WHERE `description` LIKE '%sweet%';

/* 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:
💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos 
columnas.*/
SELECT CONCAT(`first_name`,' ',`last_name`) AS `NombreCliente`
	FROM `employees` AS `e`
UNION 
SELECT `contact_name` AS `contactoCliente`
FROM `customers` AS `clientes`
