/*Consultas para la tabla ALUM2006*/

/*1. Consultar todos los datos de los alumnos.*/
SELECT * FROM alum2006;

/*2. Consultar los siguientes datos de alumnos: DNI, NOMBRE, APELLIDOS, CURSO, NIVEL y CLASE.*/ 
SELECT DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE FROM alum2006;

/*3. Consultar NOMBRE y APELLIDOS de todos los alumnos cuya POBLACIÓN sea ‘GUADALAJARA’.*/
SELECT NOMBRE, APELLIDOS FROM alum2006 WHERE poblacion = 'GUADALAJARA';

/*4. Consultar el DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE y edad de todos los alumnos ordenado por APELLIDOS y NOMBRE ascendentemente.*/
SELECT DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE FROM alum2006 ORDER BY APELLIDOS, NOMBRE ASC;

/*5. Consultar aquellos DNI cuya fecha de nacimiento sea nula.*/
SELECT DNI FROM alum2006 WHERE fecha_nac IS NULL;

/*6. Consultar todos los datos de los alumnos cuya fecha de nacimiento no sea nula.*/
SELECT DNI FROM alum2006 WHERE fecha_nac IS NOT NULL;

/*7. Consultar el DNI, NOMBRE y APELLIDOS de todos aquellos alumnos que tengan entre sus apellidos el apellido ‘Pérez’.*/
SELECT DNI, NOMBRE, APELLIDOS FROM alum2006 WHERE apellidos LIKE '%Pérez%';

/*8. Consultar el DNI, NOMBRE, APELLIDOS, CURSO, NIVEL y CLASE de todos los alumnos cuya población sea alguna de las siguientes: ‘MARCHAMALO’, ‘CABANILLAS’ o ‘YUNQUERA’.*/
SELECT DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE FROM alum2006 WHERE poblacion IN('MARCHAMALO', 'CABANILLAS', 'YUNQUERA');

/*9. Consultar el DNI, NOMBRE, APELLIDOS, CURSO, NIVEL y CLASE de todos aquellos alumnos cuya edad esté comprendida entre 17 y 20 años. Utiliza el operador -.*/
SELECT DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE FROM alum2006 WHERE 
(
		year(curdate()) - year(fecha_nac) +
		if(
			month(curdate()) - month(fecha_nac) = 0 
			AND
			day(curdate()) - day(fecha_nac) < 0 
			OR
			month(curdate()) - month(fecha_nac) < 0 , -1 , 0
		)
) > 17 OR (
		year(curdate()) - year(fecha_nac) +
		if(
			month(curdate()) - month(fecha_nac) = 0 
			AND
			day(curdate()) - day(fecha_nac) < 0 
			OR
			month(curdate()) - month(fecha_nac) < 0 , -1 , 0
		)
) < 20;


 select year(curdate()) - year(fecha_nac) +
		if(
			month(curdate()) - month(fecha_nac) = 0 
			AND
			day(curdate()) - day(fecha_nac) < 0 
			OR
			month(curdate()) - month(fecha_nac) < 0 , -1 , 0
		) from alum2006;
/*10. Realiza la misma consulta anterior pero utilizando en lugar de el operador - una de las funciones que restan fechas.*/


/*11. Obtener el DNI, NOMBRE, APELLIDOS y el máximo de faltas de los tres trimestres para aquellos alumnos de ‘ESO’.*/
SELECT DNI, NOMBRE, APELLIDOS, max(FALTAS1), max(FALTAS2), max(FALTAS3) FROM alum2006 WHERE nivel = 'ESO';

/*12. Obtener el DNI, NOMBRE, APELLIDOS, NIVEL y la media de faltas de los tres trimestres para aquellos alumnos de ‘ESO’ y ‘ESI’.*/


/*13. Consultar los datos de los alumnos que tengan faltas con valor nulo.*/


/*14. Obtener el DNI, NOMBRE, APELLIDOS y NIVEL de todos los alumnos que nacieron en el año 1985 y en el mes de Febrero (February en inglés).*/


/*15. Obtener en una columna el DNI, y en otra, la concatenación de las columnas NOMBRE y APELLIDOS, de todos los alumnos de la tabla ordenando descendentemente por DNI.*/


/*16. Obtener el NOMBRE  y APELLIDOS  de todos los alumnos de cuarto de ‘ESO’ de la clase ‘B’ ordenados por APELLIDOS y NOMBRE ascendentemente.*/


/*17. Obtener el NOMBRE, APELLIDOS y el total de faltas de los tres trimestres de todos los alumnos de cuarto de ‘ESO’ de la clase ‘B’ ordenados por APELLIDOS y NOMBRE ascendentemente.*/


/*18. Consultar el DNI, NOMBRE, APELLIDOS, CURSO, NIVEL, CLASE y edad de todos los alumnos ordenado por CURSO, NIVEL, CLASE  ascendentemente y APELLIDOS descendentemente cuyo nivel no sea ni ‘ESO’ ni  ‘BAC’.*/


/*19. Obtener la consulta anterior para aquellos alumnos cuya edad esté comprendida entre 20 y 22.*/


/*20. Obtener el total de alumnos que hay en cada nivel.*/ 


/*21. Obtener por el total de alumnos de cada curso, indicando el nivel, el curso y el total de alumnos.*/

	

/*22. Obtener el total de alumnos de 4 de la ESO que hay en cada provincia. Se debe mostrar el nombre de la provincia y el número de alumnos que hay.*/


/*Consultas para la tabla NOTAS_ALUMNOS


/*23. Muestra todos los datos de la tabla nota_alumnos.*/


/*24. Obtén el nombre del alumno, la asignatura que cursa y la nota media obtenida para los alumnos de 4ESO.*/


/*25. Muestra el nombre del alumno, el curso y la asignatura de aquellos alumnos que tenga alguna nota a NULL.*/


/*26. Muestra cuántos alumnos matriculados por cada asignatura.*/


/*27.  Muestra el nombre de los alumnos y el curso en el que estén matriculado cuya nota media sea mayor o igual que 7.*/5


/*28.  Muestra por cada curso la mayor nota media obtenida al final del curso. Utiliza un alias de columna para mostrar la nota obtenida.*/


/*29. Muestra por cada curso y asignatura la nota media de nota1, la mayor nota de nota2 y la menor nota de nota3.  El resultado debe estar ordenado por curso.*/ Utiliza un alias de columna para cada columna.*/


/*30. Muestra aquellas asignaturas y su correspondiente curso cuya nota3 obtenida por cualquier alguno sea menor que 7.*/




