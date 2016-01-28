-- ******************************************************
--              EJERCICIO 2.2. 
-- CONSULTAS SENCILLAS SOBRE LA BASE DE DATOS EDITORIALES
-- PARA LA TABLA EDITORIALES. SOLO SE UTILIZA UNA TABLA
-- Y SE HAN DE USAR ALGUNAS DE LAS FUNCIONES PARA CADENAS.
-- *******************************************************
--
-- Conectate a la base de datos editoriales
--
	USE Editoriales;

--
-- muestra el esquema (tablas) de la base de datos
--
	SHOW TABLES;

--
-- muestra la estructura de la tabla editorales
--
	DESCRIBE editoriales;

--
-- muestra los datos que hay en la tabla editoriales
--
	SELECT * FROM editoriales;



--
-- muesta el nombre y la localidad de las editoriales ordenadas por nombre
--
	SELECT nombre, localidad FROM editoriales ORDER BY nombre;



--
-- muesta el nombre y la localidad de las editoriales ordenadas por localidad
-- de manera ascendente y por nombre de manera descendente
--
	SELECT nombre, localidad FROM editoriales ORDER BY localidad, nombre DESC;


--
-- muesta el nombre y la localidad de las editoriales. 
-- Crea un alias para la columna de nombre que se llame EDITORIAL
--
	SELECT nombre AS 'EDITORIAL', localidad FROM editoriales;


--
-- Muesta la localidad de las editoriales. 
--
	SELECT localidad FROM editoriales;

--
-- Muestra la localidad de las editoriales (sin resultados repetidos)
-- 
	SELECT distinct localidad FROM Editoriales;


--
-- Muestra el nombre de las editoriales que hay en Madrid. 
-- 
	SELECT nombre FROM editoriales WHERE localidad = "Madrid";


--
-- Muestra cuántas editoriales hay almacenadas. Salida: "Total de editoriales = X"".
-- 
	SELECT concat("Total de editoriales = ", count(nombre)) as 'Nombre' FROM Editoriales;

--
-- Muestra cuántas editoriales hay en MADRID. Utiliza CONCAT_WS.Salida: Madrid --> X
-- 
	SELECT CONCAT_WS(" --> ", localidad, count(nombre)) 
	FROM editoriales 
	WHERE localidad = 'madrid';
	/* Select distinct CONCAT_WS("-->", localidad, count(nombre) ) FROM editoriales Group by localidad; */

--
-- Muestra el nombre de las editoriales en minúscula y la longitud que tiene cada nombre.
-- 
	SELECT concat(lower(nombre), " (", LENGTH(nombre), ")")
	FROM editoriales;

--
-- Muestra el nombre de cada editorial pero en este caso la primera letra debe ir en mayúscula y el resto en minúscula.
-- Ordena el resultado por nombre de manera descendente.
-- 
	SELECT concat(
				concat(
					SUBSTRING(UPPER(nombre), 1, 1),
					SUBSTRING(lower(nombre), 2)
			), " (", LENGTH(nombre), ")")
	FROM editoriales
	ORDER BY nombre desc;

--
-- Muestra, utilizando LIMIT, los datos de la editorial que tiene el 
-- mayor número de caracteres en en campo localidad.
-- 
	SELECT * FROM editoriales ORDER by length(localidad) limit 1,1;