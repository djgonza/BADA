
/* *************************************************************************
* 			CONSULTAS BASE DE DATOS BD_EMPRESA							   *
************************************************************************** */

-- 1. Mostrar el apellido, oficio y número de departamento de cada empleado.
-- Ordena el resultado primero por oficio y apellido de manera ascendente 
-- y por último por salario descendentemente.

select apellido, oficio, dept_no from empleados order by oficio, apellido asc, salario desc;

-- 2 Mostrar el número, nombre y localización de cada departamento. Utiliza alias para 
-- todas las salidas.

select dept_no as 'Numero de departamento', dnombre as 'Nombre', loc as 'Localización' from departamentos;

-- 3 Mostrar los datos de los empleados ordenados por número de departamento y por oficio

select * from empleados order by dept_no, oficio;

-- 4 Del departamento 30 mostrar solo los tres empleados que tienen el mayor salario. 
-- No se puede utilizar LIMIT

select * from empleados where dept_no = 30 order by salario desc limit 3;

-- 5 Mostrar los datos de los empleados cuyo salario sea mayor o igual que 2000. Ordena el resultado
-- por oficio.

select * from empleados where salario >= 2000 order by oficio;

-- 6 Mostrar los datos de los empleados cuyo oficio sea ʻANALISTAʼ o ' DIRECTOR'. Utiliza el operador OR.

select * from empleados where oficio = 'ANALISTA' OR oficio = 'DIRECTOR';

-- 7 Mostrar los datos de los empleados cuyo oficio sea distinto a 'ANALISTA' o 'DIRECTOR'. No 
-- se puede utilizar el operador OR ni LIKE.

select * from empleados where oficio not in ('analista', 'director');

-- 8 Mostrar los dato de los empleados cuyo departamento sea 10 y cuyo oficio sea
-- 'VENDEDOR' o ʻANALISTAʼ. Si es analista la comisión tiene que ser nula.
-- Ordenar el resultado por departamento.

select * from empleados where dept_no = 10 and oficio in ('VENDEDOR', 'analista') order by departamento;

-- 9 Si estuvieramos trabajando en Linux que distingue entre mayúsculas y minúsculas
-- y el oficio de los empleados estuviera almacenado en minúsculas. Realiza una consulta
-- que muestre todos los datos de los empleados cuyo oficio es 'VENDENDOR' (en mayúsculas)

select * from empleados where oficio = lower('VENDENDOR');

-- 10 Mostrar los empleados que tengan un salario mayor que 2000 o que
-- pertenezcan al departamento número 20.

select *  from empleados where salario > 2000  and dept_no = 20;

-- 11 Selecciona aquellos empleados cuyo APELLIDO empiece por ʻAʼ y el su OFICIO tenga una ʻEʼ.

select * from empleados where apellido like 'A%' and oficio like '%e%';

-- 12 Muestra el apellido, salario, comisión y el suelo total de los empleados cuyo salario más 
-- la comisión esté entre 1000 y 1500. Utilizar el operador BETWEEN. Además hay que tener en cuenta 
-- que hay comisiones a NULL.

select apellido, salario, comision, ifnull((salario + comision), salario) 
from empleados 
where ifnull((salario + comision), salario)
BETWEEN 1000 and 1500;

-- 13.En una consulta muestra el apellido del empleado en una columna y en otra columna
-- muestra el número de departamento al que pertenece junto con su oficio.

select apellido, (dept_no + ' --> '+ oficio) as 'Departamento --> Oficio' from empleados;

-- 14.Mostrar el apellido y la longitud del apellido de todos los empleados, ordenados por
-- la longitud de los apellidos de los empleados descendentemente.

select apellido, length(apellido) from empleados order by length(apellido) desc;

--15.Obtener el apellido y el  año de contratación de todos los empleados. Ordenados del 
-- empleado más antiguo al más nuevo.

select apellido, year(fecha_alta) from empleados order by fecha_alta;

-- 16.Mostrar cuántos empleados llevan menos de 25 años contratados.

select count(*) from empleados where timestampdiff(year, fecha_alta, now()) < 25; 

-- 17. Muestra una consulta que tenga dos columnas: una mostrará el número total de empleados que hay 
-- en la empresa, y la otra columna mostrará el número de empleados que lleva menos de 25 años contratado.
-- Utiliza alias para las columnas.

select count(*) as 'Nº Empleados', count()

-- 18 Mostrar los datos de los empleados que hayan sido contratados en el mes de febrero de 
-- cualquier año. El nombre del mes se pasa como cadena de texto.

select * from empleados where monthname(fecha_alta) = 'February';

-- 19.Para cada departamento mostrar el número de empleados que tiene y el salario máximo de todos ellos.

select count(*) as 'Nº Empleados', MAX(salario) 
from empleados 
group by dept_no;

-- 20. Mostrar el codigo del departamento de aquellos departamentos cuyo salario minimo sea menos
-- que todos los salarios del departamento 30.

select dept_no
from empleados
group by dept_no
having min(salario) < all (
	select salario 
	from empleados
	where dept_no = 30
);

-- 21. Mostrar los datos de los empleados que tengan el mismo oficio que ʻCEREZOʼ  y fueron 
-- contratados antes que el . El resultado debe ir ordenado por apellido.

select * from empleados 
group by oficio
having oficio = (
	select oficio 
	from empleados
	where apellido = 'CEREZO'
) and fecha_alta < (
	select fecha_alta
	from empleados
	where apellido = 'CEREZO'
)
order by apellido;

-- 22. Para cada empleado del departamento 30, mostar el oficio, apellido, su salario y 
-- la diferencia que hay 
-- entre su salario y la media de todos los salarios 
-- sin contar el salario del director de dicho departamento.
-- Ordena el resultado por oficio.

select oficio, apellido, salario, (
		salario - (
			select avg(salario) 
			from empleados
			where oficio != 'Director'
		)
	) as 'Media'
from empleados
where dept_no = 30; 


-- 23. Mostrar el número y nombre de los departamentos cuyo salario minimo sea menor o
-- igual todos los salarios 
-- del departamento 20. En el resultado no debe aparecer el departamento 20.

select dept_no, dnombre
from departamento
having (
		select min(salario)
		from empleados
		group by dept_no
	) <= (
		select 
	)


-- 24. Mostrar el nombre y la localidad de aquellos departamentos de los que no se 
-- tenga ningún dato de empleado
-- almacenado. UTILIZAR EXISTS.

select distinct dnombre, loc
from departamentos, empleados e
where not exists(
	select *
	from empleados
	where empleados.dept_no = departamentos.dept_no
);

-- 25. Mostrar el nombre de los departamentos de los que se tenga algún empleado almacenado. 
-- No deben salir
-- valores repetidos. No utilizar EXISTS ni IN.

select distinct dnombre
from departamentos, empleados e
where (
	select count(*)
	from empleados
	where empleados.dept_no = departamentos.dept_no
) > 0;


-- 26. Mostrar para cada departamento (por su nombre) el número de empleados 
-- que hay almacenado. Se
-- debe agrupar por el nombre del departamento.

select dnombre, count(emp_no)
from departamentos
inner join empleados
on empleados.dept_no = departamentos.dept_no;

-- 27. Realiza la consulta anterior pero ahora se debe mostrar un 0 si 
-- no hay empleados en algún departamento.

select dnombre, ifnull(count(emp_no), 0)
from departamentos
inner join empleados
on empleados.dept_no = departamentos.dept_no;

-- 28. Muestra para cada nombre de departamento, el apellido de su empleado que sea Director.

select dnombre, apellido
from departamentos
inner join empleados
on empleados.dept_no = departamentos.dept_no
where oficio = 'Director';

-- 29.Mostrar los datos del empleado que tiene el salario más alto en el
-- departamento de 'VENTAS'.

select max(derivada.salario), derivada.apellido
from (
	select empleados.*, departamentos.dnombre
	from empleados 
	inner join departamentos 
	on empleados.dept_no = departamentos.dept_no
	where dnombre = 'Ventas'
) as derivada;

-- 30. Obtener el máximo salario de todos los departamentos.

select derivada.apellido, max(derivada.salario) as 'Salario', derivada.dnombre as 'Dpt. Nombre'
from (
	select empleados.salario, departamentos.dnombre, empleados.apellido
	from empleados 
	inner join departamentos 
	on empleados.dept_no = departamentos.dept_no
) as derivada;