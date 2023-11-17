USE `northwind`;
/* 1. Productos más baratos y caros de nuestra BBDD:
Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. 
Dales el alias lowestPrice y highestPrice.*/
SELECT MAX(`unit_price`) AS 'highestPrice', MIN(`unit_price`) AS 'lowestPrice'
FROM `products`;

/* 2. Conociendo el numero de productos y su precio medio:
Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos (en general, no por cada 
producto)*/
SELECT COUNT(`product_id`) AS 'number_products', AVG(`unit_price`) AS 'averagePrice'
FROM `products`;

/* 3. Sacad la máxima y mínima carga de los pedidos de UK:
Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de carga para un pedido (freight) enviado a
 Reino Unido (United Kingdom).*/
SELECT MAX(`freight`) AS 'max_freight', MIN(`freight`) AS 'min_freight'
FROM `orders`
WHERE `ship_country`='UK';

/* 4. Qué productos se venden por encima del precio medio:
Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer qué productos 
en concreto se venden por encima del precio medio para todos los productos de la empresa, ya que sospechan que dicho número es demasiado elevado. 
También quieren que ordenemos los resultados por su precio de mayor a menor.*/
SELECT AVG(`unit_price`)
FROM `products`;
SELECT `product_name`
FROM `products`
WHERE `unit_price`>=28.866363636363637
ORDER BY `unit_price` DESC;

/* 5. Qué productos se han descontinuado:
De cara a estudiar el histórico de la empresa nos piden una consulta para conocer el número de productos que se han descontinuado. El atributo
 Discontinued es un booleano: si es igual a 1 el producto ha sido descontinuado*/
 SELECT SUM(`discontinued`)
 FROM `products`;
 
 /* 6. Detalles de los productos de la query anterior:
Adicionalmente nos piden detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName. Como puede que salgan demasiados 
resultados, nos piden que los limitemos a los 10 con ID más elevado, que serán los más recientes. No nos pueden decir del departamento si habrá 
pocos o muchos resultados, pero lo limitamos por si acaso*/
SELECT `product_id`,`product_name`
FROM `products`
ORDER BY `product_id` DESC
LIMIT 10;

/* 7. Relación entre número de pedidos y máxima carga:
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) que han sido enviados por cada empleado 
(mostrando el ID de empleado en cada caso).*/
SELECT COUNT(`order_id`) AS 'cantidad_pedidos' ,MAX(`freight`) AS 'carga_maxima',`employee_id`
FROM `orders`
GROUP BY `employee_id`;

/* 8. Descartar pedidos sin fecha y ordénalos:
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". En el resultado anterior se han incluido 
muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. También nos piden que ordenemos los 
resultados según el ID de empleado para que la visualización sea más sencilla.*/
SELECT COUNT(`order_id`) AS 'cantidad_pedidos' ,MAX(`freight`) AS 'carga_maxima',`employee_id`
FROM `orders`
WHERE `shipped_date` IS NOT NULL
GROUP BY `employee_id`
ORDER BY `employee_id` DESC;

/* 9. Números de pedidos por día:
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. Por lo tanto,
 tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) 
 y el año (YEAR())*/
SELECT COUNT(`order_id`) AS 'cantidad_pedidos', DAY(`order_date`) AS 'día', MONTH(`order_date`) AS 'mes', YEAR(`order_date`) AS 'año'
FROM `orders`
GROUP BY `order_date`;

/* 10. Número de pedidos por mes y año:
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. Genera una modificación de la consulta
 anterior para que agrupe los pedidos por cada mes concreto de cada año.*/
SELECT COUNT(`order_id`) AS 'cantidad_pedidos', MONTH(`order_date`) AS 'mes', YEAR(`order_date`) AS 'año'
FROM `orders`
GROUP BY MONTH(`order_date`), YEAR(`order_date`);

/*11. Seleccionad las ciudades con 4 o más empleadas:
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura de nuevas oficinas.*/
SELECT `city`, COUNT(`employee_id`)
FROM `employees`
GROUP BY `city`
HAVING COUNT(`city`)>=4;

/* 12. Cread una nueva columna basándonos en la cantidad monetaria:
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total que han supuesto: 
por encima o por debajo de 2000 euros.*/
SELECT 
CASE
	WHEN `unit_price`*`quantity`>2000 THEN 'Alto'
	ELSE 'Bajo'
	END as CantidadMonetaria,
`order_id`, `unit_price`*`quantity` AS 'PrecioTotal'
FROM `order_details`

 