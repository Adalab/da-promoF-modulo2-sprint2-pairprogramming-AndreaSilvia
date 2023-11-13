USE `northwind`;
/* 1. Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en 
ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/
SELECT `city` AS 'c', `company_name` AS 'name', `contact_name` AS 'contact'
	FROM `customers`
    WHERE `city` LIKE 'A%' OR `city` LIKE 'B%';

/* 2. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior y el número de total de pedidos que han hecho todas 
las ciudades que empiezan por "L".*/
SELECT `c`.`company_name` AS 'name', `c`.`contact_name` AS 'contact', `o`.`ship_city` AS 'sc', COUNT(DISTINCT `o`.`order_id`) AS 'order'
	FROM `customers` AS `c`
    NATURAL JOIN `orders` AS `o`
    WHERE `o`.`ship_city` LIKE 'L%'
	GROUP BY `name`, `contact`,`sc`;

/* 3. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". Extraer el nombre de contacto, su posisión 
(contact_title) y el nombre de la compañia*/
SELECT `contact_name` AS 'Contact', `contact_title` AS 'title', `company_name` AS 'name'
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
SELECT  
CASE
	WHEN `company_name` IS NOT NULL THEN 'Customer'
	END as `Relationship`,
`city` AS 'City', `company_name` AS 'CompanyName', `contact_name` AS 'ContactName'
 FROM `customers`
 UNION
 SELECT 
 CASE
	WHEN `company_name`IS NOT NULL THEN 'Supplier'
	END as `Relationship`,
 `city` AS 'City', `company_name` AS 'CompanyName', `contact_name` AS 'ContactName'
 FROM `suppliers`;
 
 /* 6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/
 SELECT `description` 
FROM `categories` AS `c`
WHERE `description` LIKE '%sweet%';

/* 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:
💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos 
columnas.*/