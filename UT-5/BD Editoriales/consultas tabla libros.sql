-- ******************************************************
--              EJERCICIO 2. 
-- CONSULTAS SOBRE LA BASE DE DATOS EDITORIALES
-- PARA LA TABLA LIBROS
-- *******************************************************

--
-- Conéctate a la base de datos editoriales
--
USE Editoriales;

--
-- Muestra el esquema (tablas) de la base de datos
--
SHOW TABLES;

--
-- Muestra la estructura de la tabla libros
--
DESCRIBE libros;

--
-- Muestra los datos que hay en la tabla libros
--
SELECT * FROM libros;

--
-- Muesta el código, el título, el autor y la fecha de publicación de los libros
--
SELECT codigo, titulo, autor, fecha_publicacion FROM libros;

--
-- Muesta los autores ordenados alfabéticamente
--
SELECT autor FROM libros ORDER BY autor ASC;

--
-- Muestra cuántos libros hay en total.
--
SELECT COUNT(*) FROM libros;

--
-- Muestra las editoriales que tienen algún libro publicado.
--
SELECT COUNT(*) FROM libros;

--
-- Muestra cúantos libros tiene publicado cada editorial.
-- 
SELECT EDITORIAL, COUNT(titulo) FROM libros GROUP BY (editorial);

SELECT EDITORIALES.nombre, COUNT(LIBROS.codigo) 
FROM Editoriales, libros 
WHERE libros.editorial = Editoriales.editorial 
GROUP BY (editoriales.nombre);

--
-- Muestra el titulo y el autor(es) de los libros que tengan
-- entre los autores la palabra "otros"
-- 
SELECT titulo, autor FROM libros WHERE autor like '%otros%';

--
-- Muestra el título y la fecha de publicación de los libros
-- que versen sobre SQL
-- 
SELECT titulo, fecha_publicacion FROM libros WHERE titulo LIKE '%SQL%';

--
-- Muestra el título, el autor y la fecha de publicación de los libros
-- publicados en 01-02-2006
-- 
SELECT titulo, autor, fecha_publicacion FROM libros WHERE fecha_publicacion = '2006-02-01';

--
-- Repite la consulta anterior pero muestra el resultado ordenador por titulo
--
SELECT titulo, autor, fecha_publicacion FROM libros WHERE fecha_publicacion = '2006-02-01' ORDER BY titulo ASC;

--
-- Muestra el titulo, el autor y la fecha de publicación de 
-- los libros que han sido publicado entre 01-01-2000 y 31-12-2005
--
SELECT titulo, autor, fecha_publicacion FROM libros WHERE fecha_publicacion BETWEEN '2000-01-01' AND '2005-12-31';

--
-- Muestra el titulo, el autor y la fecha de publicación de 
-- los libros que han sido publicado en 2002. Utiliza la función YEAR()
--
SELECT titulo, autor, fecha_publicacion FROM libros WHERE YEAR(fecha_publicacion) = 2002;

--
-- Muestra el titulo, el autor y la editorial de los libros publicados
-- por la editorial 30.
--
SELECT titulo, autor, fecha_publicacion FROM libros WHERE editorial = '30';


--
-- Muestra el número total de libros vendidos por la editorial 30.
--
SELECT COUNT(*) FROM libros WHERE editorial = '30';


--
-- Muestra el número total de libros vendidos por cada editorial.
-- El resultado debe ser el nombre de la editorial y la columna que
-- muestre el resultado debe llamarse UNIDADES VENDIDAS.
--
SELECT editorial, sum(unidades_vendidas) FROM libros GROUP BY editorial;