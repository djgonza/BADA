-- ******************************************************
--              EJERCICIO 2.3. 
-- CONSULTAS SOBRE LA BASE DE DATOS EDITORIALES:
-- SUBCONSULTAS Y CONSULTAS SOBRE VARIAS TABLAS
-- *******************************************************

--
-- Muestra el nombre de las editoriales que tienen algún libro 
-- publicado.
-- Ordena el resultado por el número de libros publicados en orden
-- descendente. Realiza dos consultas una con INNER JOIN y otra con 
-- producto cartesiano. 
--
	SELECT nombre
	FROM editoriales 
	INNER JOIN libros ON editoriales.editorial = libros.editorial
	GROUP BY nombre desc;

	SELECT distinct(nombre) 
	FROM editoriales, libros
	WHERE editoriales.editorial = libros.editorial
	ORDER BY nombre;

--
-- Muestra el nombre de las editoriales junto con el total de libros 
-- que ha vendido. Ordena el resultado de mayor a menor unidades vendidas.
-- Haz dos consultas una con INNER JOIN y otra con producto cartesiano.
--
	SELECT nombre, sum(unidades_vendidas)
	FROM editoriales
	INNER JOIN libros ON editoriales.editorial = libros.editorial
	GROUP BY nombre
	ORDER BY unidades_vendidas desc;

	SELECT nombre, sum(unidades_vendidas)
	FROM editoriales, libros
	WHERE editoriales.editorial = libros.editorial
	GROUP BY nombre
	ORDER BY unidades_vendidas desc;

--
-- Muestra el nombre de cada editorial junto con el número de libros
-- publicados. Si la editorial no ha publicado libros (editorial 40) 
-- debe aparecer 0 en el total de libros publicados. Utiliza alguna
-- forma de JOIN.
--
	SELECT nombre, count(titulo)
	FROM editoriales
	LEFT JOIN libros ON editoriales.editorial = libros.editorial
	GROUP BY nombre
	ORDER BY unidades_vendidas desc;

-- Muestra la localidad de las editoriales que hayan publicado algún
-- libro entre cuyos autores se encuentre la palabra 'otros'. Utiliza 
-- INNER JOIN.
--
	SELECT distinct(localidad)
	FROM editoriales
	INNER JOIN libros ON editoriales.editorial = libros.editorial
	WHERE autor LIKE "%otros%";


--
-- Muestra los datos de las editoriales que hayan publicado algún libro
-- en febrero (february)
--
	SELECT nombre, localidad
	FROM editoriales
	INNER JOIN libros ON editoriales.editorial = libros.editorial
	WHERE MONTHNAME(fecha_publicacion) = 'february';


--
-- Muestra los datos de las editoriales que no hayan publicado ningún libro. 
-- Obtén el resultado con una subconsulta. Haz una consulta con IN y otra con
-- EXISTS.
--
	SELECT editorial, nombre, localidad
	FROM editoriales
	WHERE editorial NOT IN (
		SELECT editorial FROM libros
	);

	SELECT editorial, nombre, localidad
	FROM editoriales
	WHERE NOT EXISTS (
		SELECT editorial 
		FROM libros
		WHERE editoriales.editorial = libros.editorial
	);



