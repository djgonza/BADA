-- *****************************************************************************************
--   			EJERCICIOS BASE DE DATOS PARA REPASO
-- *****************************************************************************************


-- Crea una función para calcular un importe a pagar (precio*cantidad) --

drop function IF EXISTS importePagar;

DELIMITER //

CREATE function importePagar (id int) returns double
BEGIN
	
    declare p double;
    declare c int;    
    
	select precio from articulos where refart = 
		(select refart from linped where numped = id)
	group by precio
	into p;
    
    select sum(cantped) from linped where numped = id 
    into c;
    
    return p * c;
	
    
END//
DELIMITER ;

select importePagar (100);

-- Crea una función que calcule el descuento de un importe --

drop function IF EXISTS calcDescuento;

DELIMITER //

CREATE function calcDescuento (importe double, descuento int) returns double
BEGIN

    return (importe * descuento) / 100;
	    
END//
DELIMITER ;

select calcDescuento (100, 5);

-- Calcula la cantidad de iva a pagar de un determinado importe (codiva=18 o 8) --

drop function IF EXISTS calcIva;

DELIMITER //

CREATE function calcIva (importe double, iva int) returns double
BEGIN

    return (importe * iva) / 100;
	
END//
DELIMITER ;

select calcIva (100, 5);

-- Calcula la cantidad a pagar con el iva correspondiente --

drop function if exists cantidadConIva;

delimiter //

create function cantidadConIva (cantidad int, iva int) returns double
begin

	return cantidad + (cantidad * iva / 100);

end //
delimiter ;

select cantidadConIva (25, 5);

-- Crea un procedimiento que muestre los datos de la tabla pedidos.

drop procedure if exists selectPedidos;

delimiter //

create procedure selectPedidos ()
begin

	select * from pedidos;

end //
delimiter ;

call selectPedidos ();

-- Crea un procedimiento que dado un codigo de pedido actualice la cantidad en stock
-- de un producto y el estado del pedido pase a ser 'SE' 

drop procedure if exists actualizarStock;

delimiter //

create procedure actualizarStock (nPedido int)
begin

	declare cantidadPedida, stock int;
    declare codRefart char;
    
    set codRefart = (select refart from linped where numped = nPedido);
    set cantidadPedida = (select cantped from linped where numped = nPedido);
    set stock = (select cantstok from articulos where refart = codRefart);

	update articulos set cantstok = (stock - cantidadPedida) where refart = codRefart;
    update pedidos set estadoped = 'SE' where numped = nPedido; 

end //
delimiter ;

call actualizarStock ();

-- Crea un procedimiento que muestre los detalles por cliente

drop procedure if exists datosCliente;

delimiter //

create procedure datosCliente (idCliente int)
begin

	select * from clientes as c 
		inner join pedidos as p on c.numcli = p.numcli 
        inner join linped as l on p.numped = l.numped 
        inner join articulos as a on a.refart = l.refart
    where numped = idCliente;

end //
delimiter ;

call datosCliente (5);

-- Crea un procedimiento que muestre los detalles por pedido

drop procedure if exists datosPedido;

delimiter //

create procedure datosPedido (idPedido int)
begin

	select * 
    from pedidos p inner join linped on c.numcli = p.numcli 
        inner join linped as l on p.numped = l.numped 
        inner join articulos as a on a.refart = l.refart
	where numped = idPedido;

end //
delimiter ;

call datosPedido (5);

-- Muestra los detalles del pedido



-- Crea un procedimiento que muestre los totales de un cliente



-- Crea un procedimiento que muestre los totales de un pedido


-- Crea un procedimiento que muestre todos los totales



-- Crea un procedimiento que elimine de linped los pedidos que no se pueden servir



-- Copia a una nueva tabla llamada desechados los pedidos eliminados por depuracion (trigger)



-- Crea un disparador que inserte cada vez que se crea un pedido el correspondiente albarán:
-- codalb = AL+numped, fechaenv = fechaped + 1 mes, codigopedido=numped, estadoalb= estadoped


-- crea un disparador que controle que la fecha de un pedido realizado sea anterior o igual 
-- a la fecha actual a la  que se graba la información del pedido.


-- Crea un procedimiento que `por cada cliente muestre los pedidos que haya hecho (numped y fechaped) 
-- y cuántos pedidos ha hecho en total.



-- Crea un cursor que por cada pedido (linped) muestre los articulos que se han pedido (articulos)




