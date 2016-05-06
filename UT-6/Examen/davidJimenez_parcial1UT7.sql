-- ************************************************************************************
-- 			UT7 PARCIAL 1: PROCEDIMIENTO ALMACENADOS Y FUNCIONES 	                 --
--																				     --
-- NOMBRE:												FECHA:		     --
--																				     --
-- Renombra el archivo sql como: tunombreyapellido_parcial1UT7.sql   	             --
-- El examen es sobre 5, los otros 5 puntos corresponden al segundo parcial de la    --
-- UT7. Las notas SOLO se sumarán si se obtiene en cada parte 2.5 puntos.		     --
-- ************************************************************************************


-- ********************************************************************************* --
--1.Realiza una función llamada FECHA que devuelva la fecha que se pase por parámetro --
--  en formato dd/mm/aaaa tipo cadena de texto. (0,5 puntos)                         --
--  Prueba el procedimiento con la fecha 2016-05-05. El resultado debe ser 5/5/2016. --
-- ********************************************************************************* --	
	
drop function if exists fecha;
delimiter //

create function fecha (fecha date) returns varchar(255)
begin
	
	return concat(day(fecha), "/", month(fecha), "/", year(fecha));

end //
delimiter ;
	
-- ********************************************************************************* --	
--2.Crea una función llamada IMPORTE que devuelva un determinado importe en dolares. --
-- (1dólar=0,87euros). La salida debe tener solo dos decimales.	(0,5 puntos)        --                					--
--  Prueba el procedimiento con el valor 10.5 y el resultado debe ser 9,14.			 --
-- ********************************************************************************* --


drop function if exists importe;
delimiter //

create function importe (euros double) returns double(10,2)
begin
	
	return euros * 0.87;

end //
delimiter ;

-- ********************************************************************************** -- 
--3. Crea una función llamada DESCUENTO que devuelva el descuento que se 		      --
-- realizará sobre un determnado importe dependiendo del número de días que hayan     --
-- transcurrido entre la fecha de realización del pedido y la fecha de entrega de 	  -- 
-- dicho pedido. Si el número de días transcurrido entre ambas fechas es superior a   --
-- 100, el descuento a aplicar será de un 15%; si el número se encuentra entre 40 y   --
-- 100, el descuento será de un 10% y en cualquier otro caso no habrá descuento. La   --
-- salida solo puede tener dos decimales. 	(1 punto)			    				  --
-- ********************************************************************************** --

drop function if exists descuento;
delimiter //

create function descuento (importe double, fechaReal date, fechaEntre date) returns double (10,2)
begin
	
	declare diasTranscurridos int;
	
	set diasTranscurridos = day(fechaReal) - day(fechaEntre);
	
	case 
		when (diasTranscurridos > 100) then
			return importe - (importe * 0.15);
		when (diasTranscurridos < 100 and diasTranscurridos > 40) then
			return importe - (importe * 0.10);
		else
			return importe;
	end case;

end //
delimiter ;	

select descuento(100.0, "2016-05-05", "2016-05-10");
	
-- ********************************************************************************** --
-- 4. Crea un procedimiento llamado DETALLEPEDIDOS que sea capaz de mostrar: el       --
-- codigo de cada pedido realizado, la fecha en la que se realizó el pedido según el  --
-- formato que devuelve la función FECHA, el total del coste del pedido utilizando la --
-- función IMPORTE, el descuento que se le aplicará y el total final aplicando el 	  --
-- descuento.			 
-- Solo se deben mostrar los datos de los pedidos cuyo estado sea igual al estado 	  --
-- del cliente de nombre 'Campohermoso'. Este será el nombre del cliente que se 	  --
-- pasará como parámetro. (1.5 puntos)								  				  --
-- ********************************************************************************** --

-- Realiza estas operaciones antes de ejecutar el procedimieto.
START TRANSACITION;
INSERT INTO Pedidos VALUES (129,'2010-12-20','2010-12-22','2011-04-22','Entregado',NULL,31);

INSERT INTO DetallePedidos VALUES (129,'FR-67',10,70,3);
INSERT INTO DetallePedidos VALUES (129,'OR-127',40,4,1);
INSERT INTO DetallePedidos VALUES (129,'OR-141',25,4,2);
INSERT INTO DetallePedidos VALUES (129,'OR-241',15,19,4);
INSERT INTO DetallePedidos VALUES (129,'OR-99',23,14,5);
COMMIT WORK;

drop procedure if exists detallePedido;
delimiter //

create procedure detallePedido (in nomCli varchar)
begin
	
	declare importeNum double;
	declare CodPed int;
	declare CodCli int;
	declare FecPed date;
	declare FecEntr date;
	
	set codCli = (select CodigoCliente from clientes where NombreCliente = nomCli);
	set CodPed = (select CodigoPedido from pedidos where CodigoCliente = CodCli);
	set importeNum = (select sum(PrecioVenta) from productos 
		where codigoProducto = (select CodigoProducto from detallePedido where codPedido in codPed));
	set FecPed = (select FechaPedido from pedidos where codigoPedido = codPed);
	set FecEntr = (select FechaEntrega from pedidos where codigoPedido = codPed);
	
	
	select 	CodigoPedido, 
			fecha(FechaPedido) as "Fecha", 
			importe(importeNum) as "Importe", 
			descuento(importe(importeNum), FecPed, FecEntr) as "TotalFinal" 
	from pedidos 
	where CodigoCliente = CodCli;

end //
delimiter ;
	

-- ********************************************************************************** --	
-- 5. Crea un procedimiento llamado NUMERO_ACTUALIZACIONES que devuelva a través de   --
-- una variable el número de actualizaciones que ha tenido el precio de unidad de un  --
-- determinado producto hasta que sea igual que su precio de venta. La variable que   --
-- contiene el número de actualizaciones se debe inicializar fuera del procedimiento. --
-- Cada actualización es de una unidad. Prueba el procedimiento con el producto 0R-222--
-- el resultado debe ser 28. (1.5 puntos)											  --
-- ********************************************************************************** --

drop procedure if exists numeroActualizaciones;
delimiter //

create procedure numeroActualizaciones (in cdProd varchar(16), out retornar int)
begin
	
	declare pUnidad double default 0;
	declare pVenta double default 0;
	
	set pUnidad = (select PrecioUnidad from detallePedidos where CodigoProducto = "0R-222");
	set pVenta = (select PrecioVenta from productos where CodigoProducto = "0R-222");
	set retornar = 0;
	
	/*select pUnidad, pVenta;*/
	
	while (pUnidad < pVenta) do
		set retornar = retornar + 1;
		set pUnidad = pUnidad + 1;
	end while;
	
end //
delimiter ;

call numeroActualizaciones("0R-222", @r);
select @r;
