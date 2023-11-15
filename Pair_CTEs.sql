USE `northwind`
/* 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.*/

/* 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".*/

/* 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/

/* 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/

/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/

/* BONUS: Estos ejercicios no es obligatorio realizarlos. Los podéis hacer más adelante para poder practicar las CTE´s.*/

/* 6. Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo.*/

/* 7. La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos que ha hecho cada uno de ellos.*/

/* 8. Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente.*/

/* 9. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos clientes que 
hayan hecho más de 6 pedidos en el año 1998.*/

/* 10 .Nos piden que obtengamos el importe total (teniendo en cuenta los descuentos) de cada pedido de la tabla orders y el customer_id asociado a
 cada pedido.*/
