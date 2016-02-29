## Consultas simples
# 1.	Sacar la ciudad y el teléfono de las oficinas de Estados Unidos.
Select ciudad, telefono from Oficinas where pais = "EEUU";

# 2.	Sacar el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.
Select nombre, apellido1, apellido2, email 
	from empleados 
	where codigoJefe = (
		select codigoJefe 
		from empleados 
		where nombre = "Alberto" and apellido1 = "Soria"
	);

# 3.	Sacar el cargo, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email 
	from empleados 
	where puesto = "Director General";

# 4.	Sacar el nombre, apellidos y cargo de aquellos que no sean representantes de ventas.
select nombre, apellido1, apellido2, puesto 
	from empleados
	where puesto != "Representante Ventas";

# 5.	Sacar el número de clientes que tiene la empresa.
select count(*) from clientes;

# 6.	Sacar el nombre de los clientes españoles.
select NombreCliente from clientes where pais = "España";

# 7.	Sacar cuántos clientes tiene cada país.
select pais, count(*) as 'cantidad'
	from clientes 
	group by pais;

# 8.	Sacar cuántos clientes tiene la ciudad de Madrid.
select ciudad, count(*) as "Cantidad"
	from clientes
	where ciudad = "Madrid";

# 9.	Sacar cuántos clientes tienen las ciudades que empiezan por M.
Select ciudad, count(*)
	from clientes
	where ciudad like "m%";

# 10.	Sacar el código de empleado y el número de clientes al 
# que atiende cada representante de ventas.
Select codigoEmpleado, count(
	select CodigoCliente 
	from clientes 
	where CodigoEmpleadoRepVentas = empleados.codigoEmpleado)
from empleados;

# 11.	Sacar el número de clientes que no tiene asignado representante de ventas.
# 12.	Sacar el código de cliente de aquellos clientes que hicieron pagos en 2008.
# 13.	Sacar los distintos estados por los que puede pasar un pedido.
# 14.	Sacar un listado de los 20 códigos de productos más pedidos ordenado por cantidad pedida.
# 15.	Sacar el número de pedido, nombre de cliente, fecha requerida y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha requerida.
# 16.	Sacar la facturación que ha tenido la empresa en toda la historia, 
	# indicando la base imponible, el IVA y el total facturado.  
	# Nota: la base imponible se calcula sumando el coste del producto por el número 
	# de unidades vendidas. El IVA, es el 18% de la base imponible, y el total, 
	# la suma de los dos campos anteriores.
Select sum(preciounidad*cantidad) as 'Base imponible', 
	   round(sum(preciounidad*cantidad)*18/100, 2) as 'IVA',
	   round(
	   		sum(preciounidad*cantidad) + 
	   		sum(preciounidad*cantidad)*18/100, 2) as 'Total'
	from DetallePedidos;


# 17.	Sacar la misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por FR.

## Subconsultas 
# 1.	Sacar el número de pedido, nombre de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregado a tiempo.
# 2.	Obtener el nombre del producto más caro. Realiza una consulta utilizando LIMIT y otra utilizando una función de grupo.
# 3.	Obtener el nombre del producto del que más unidades se hayan vendido en un mismo pedido.
# 4.	Obtener los clientes cuya línea de crédito sea mayor que los pagos que haya realizado.
# 5.	Sacar el producto que más unidades tiene en stock y el que menos unidades tiene en stock.

## Consultas multitabla
# 1.	Sacar el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
# 2.	Sacar la misma información que en la pregunta anterior pero solo los clientes que no hayan hecho pagos.
# 3.	Obtener un listado con el nombre de los empleados junto con el nombre de sus jefes.
# 4.	Obtener el nombre de los clientes a los que no se les ha entregado a tiempo un pedido (FechaEntrega>FechaEsperada)
# 5.	Mostrar el número de clientes de las oficina de Madrid.

## Consultas con tablas derivadas
# 1.	Sacar el importe  medio de los pedidos.
# 2.	¿Cuál es el pedido más caro del empleados que más clientes tiene?
# 3.	Obtener el nombre  de los tres clientes que más pedidos han hecho.

## Consultas variadas
# 1.	Sacar un listado de clientes indicando el nombre del clientes y cuántos pedidos ha realizado. Tener en cuenta que puede que haya clientes que no hayan realizados pedidos.
# 2.	Sacar un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
# 3.	Sacar el nombre de los clientes que hayan hecho pedidos en 2008.
# 4.	Listar el nombre del cliente y el nombre y apellido de sus representantes de aquellos clientes que no hayan realizado pagos.
# 5.	Sacar un listado de clientes donde aparezca el nombre de su comercial y a la ciudad donde está su oficina.
# 6.	Sacar el nombre, apellidos, oficina y cargo de aquellos que no sean representantes de ventas.
# 7.	Sacar cuántos empleados tiene cada oficina, mostrando el nombre de la ciudad donde está la oficina.
# 8.	Sacar un listado con el nombre de los empleados, y el nombre de sus respectivos jefes.
# 9.	Sacar el nombre, apellido, oficina (ciudad) y cargo del empleado que no represente a ningún cliente.
# 10.	Sacar la media de unidades en stock de los productos agrupados por gama.
# 11.	Sacar los clientes que residan en la misma ciudad donde hay una oficina, indicando dónde está la oficina.
# 12.	Sacar los clientes que residan en ciudades donde no hay oficinas ordenado por la ciudad donde residen.
# 13.	Sacar el número de clientes que tiene asignado cada representante de ventas.
# 14.	Sacar cuál fue el cliente que hizo el pago con mayor cuantía y el que hizo el pago con menor cuantía.
# 15.	Sacar un listado con el precio total de cada pedido.
# 16.	Sacar los clientes que hayan hecho pedidos en el 2009 por cuan cuantía suprior a 2000 euros.
# 17.	Sacar cuántos pedidos tiene cada clientes en cada estado.
# 18.	Sacar los clientes que han pedido más de 200 unidades de cualquier producto.
# 19.	Consultar el código de pedido de aquellos pedidos que contengan algún producto cuya gama sea aromáticas.

# Inserciones, actualizaciones y borrados
# 1.	Inserta una oficina con sede en Fuenlabrada. Código 'FUE-ES'
# 2.	Inserta un empleado para la oficina Fuenlabrada que sea representante de ventas.
# 3.	Elimina los empleados 'Representante Ventas' que no tengan clientes.
# 4.	Elimina los clientes que no tengan pedidos.
# 5.	Incrementa en un 20% el precio de los productos que no tengan pedidos.
# 6.	Borra los pagos del límite con menor límite de crédito.
# 7.	Establece a 0 el límite de crédito del cliente que menos unidades pedidas tenga el producto 'OR-179'.
# 8.	Modifica la tabla DetallePedido para insertar un campo numérico llamado IVA. Mediante una transacción (START TRANSACCTION---COMMIT WORK), establece el valor de ese campo a 18 para aquellos regsitros cuyo pedido tenga fecha a partir de Julio de 2010. A continuación actualiza el resto de Pedidos estableciendo el IVA a 16.
# 9.	Modifica la tabla DetallePedido para incorporar un capo numérico llamado TotalLinea, y actualiza todos sus registros para calcular su valor con la fórmula TotalLinea = PrecioUnidad * Cantidad * IVA /100.
# 10.	Borra el cliente que menor límite de crédito tenga. ¿Es posible borrarlo solo con una consulta? ¿Por qué?
# 11.	Crea una transacción que actualice el stock (stock -2) del produto AR-001.  Inserte el pedido con los datos; código de pedido:25, fecha de pedido:fecha de hoy (utiliza 
# una función de fecha), fechaesperada: 17-03-2015, fechaEntrega: 15-03-2015,  Estado:'Pendiente', sin comentarios y del cliente número 1.
# 12.	Cambia el jefe de los empleados de España que hay en la tabla empleadosEspaña. Su nuevo jefe será el director general de toda la jardineria.

