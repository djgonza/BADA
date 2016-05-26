-- =================================================================================
--   Ejercicio
--   Crea una función llamada DOLARES, que devuelva el equivalente en dólares a
--   un importe en euros(1 euro = 1.1124 dolares). 
--   El resultado debe tener 2 decimales.
-- =================================================================================
DROP FUNCTION IF EXISTS DOLARES;
DELIMITER //
CREATE FUNCTION DOLARES (precio DECIMAL(15,2)) RETURNS DECIMAL (15,2)
BEGIN
	RETURN precio * 1.1124;
END;
//

DELIMITER ;
select dolares(10);

-- =================================================================================
--   Ejercicio
--   Crea una función IMPORTE, que devuelva el importe ha pagar de un producto. El 
--   resultado dependerá del precioUnitario y de la cantidad de cada producto.
-- =================================================================================

DROP FUNCTION IF EXISTS IMPORTE;
DELIMITER //
CREATE FUNCTION IMPORTE (PrecioUnidad DECIMAL(10,2), cantidad INTEGER) 
RETURNS DECIMAL (10,2)
BEGIN
	RETURN precioUnidad * cantidad;
END;
//

DELIMITER ;
select importe(10.5,4);

-- =================================================================================
--   Ejercicio
--   Crea una función MESFECHA, que devuelva el día,el nombre del mes y el año de 
--   una determinada fecha que se pasará como parámetro. El mes debe aparecer en
--   letra y en español. AYUDA: DAY(),MONTHNAME(), YEAR().
--   (Ejemplo: la fecha 26/05/2015  deberá dar como resultado  "26 de Mayo de 2015")
-- =================================================================================
DROP FUNCTION IF EXISTS MESFECHA;
DELIMITER //
CREATE FUNCTION MESFECHA(FECHA DATE) RETURNS VARCHAR (50)
BEGIN
	DECLARE mes VARCHAR(15);
    CASE MONTHNAME(fecha)
		WHEN 'January' THEN set mes='enero';
        WHEN 'february' THEN SET mes='febrero';
        WHEN 'march' THEN SET mes='marzo';
        WHEN 'april' THEN SET mes='abril';
        WHEN 'may' THEN SET mes='mayo';
        WHEN 'june' THEN SET mes='junio';
        WHEN 'july' THEN SET mes='julio';
        WHEN 'august' THEN SET mes='agosto';
        WHEN 'september' THEN SET mes='septiembre';
        WHEN 'october' THEN SET mes='octubre';
        WHEN 'november' THEN SET mes='noviembre';
       ELSE SET mes='diciembre';
	END CASE;
        
	RETURN CONCAT(DAY(FECHA),' de ',mes,' de ',YEAR(FECHA));
END;
//

DELIMITER ;
SELECT MESFECHA('2015-12-12');

-- =================================================================================
--   Ejercicio 
--   Crea el procedimiento LISTA_PEDIDOS que muestre todos los pedidos
--   de un determinado cliente. Los datos a mostrar son:
--   Código de Cliente,Código de Pedido, Estado, Importe total en euros e 
--   Importe total en dólares. Para el importe y los dólares utiliza las funciones 
--   previamente definidas.
--   El procedimiento debe recibir como parámetro: NombreCliente
--   Se valorará usar tanto la función IMPORTE como DOLARES. Utiliza cursores.
-- =================================================================================



call lista_pedidos('DGPRODUCTIONS GARDEN');

-- =================================================================================
--   Ejercicio 
--
--   Crea un diparador INSERTA_PEDIDOS que cada vez que se inserte un pedido para un 
--   cliente se compruebe que la fecha de entrega sea superior a la fecha de pedido. 
-- 
--   Si se cumple esta condición se insertarán de manera automática en la tabla 
--   ControlClientes los valores: codigo de cliente, nombre del cliente, 
--   fecha en la que se ha realizado e importe total del pedido en euros.

--   En caso contrario se debe lanzar un mensaje de error ("Error, la fecha de entrega
--   debe ser posterior a la fecha realización del pedido") y no permitir que se 
--   inserte el pedido.
-- =================================================================================

CREATE TABLE IF NOT EXISTS controlClientes(
	codigoCliente INTEGER,
    FechaPedido   DATE,
    importe		  DECIMAL(15,2)
  
);

delimiter //

drop TRIGGER if EXISTS INSERTA_PEDIDOS //

CREATE TRIGGER INSERTA_PEDIDOS
BEFORE
INSERT on pedidos for EACH ROW

BEGIN

		DECLARE msg VARCHAR(255);
		DECLARE fe DATE DEFAULT new.fechaEntrega;
		DECLARE fp DATE DEFAULT new.fechapedido;
		DECLARE diasdif int DEFAULT (select TIMESTAMPdiff(day, fe, fp));
		declare importetotal DOUBLE DEFAULT 0;
		declare fincursor int default 0;
		declare ccantidad int;
		declare cprecioUnidad DOUBLE;
		DECLARE cimporte CURSOR FOR SELECT cantidad, precioUnidad FROM detallePedidos where codigoPedido= new.codigoPedido;
		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET fincursor = 1;
		

		if (diasdif >0)
		then
			open cimporte;
			loopuno : loop
				fetch cimporte into ccantidad, cprecioUnidad;
				if fincursor = 1 
				then leave loopuno;
				end if;
				
				set importetotal = importetotal + importe(ccantidad, cprecioUnidad);
			end loop loopuno;
			
			insert into controlClientes values (new.codigoCliente, fp, importetotal);
		else 

			set msg = "Error, la fecha de entrega debe ser posterior a la fecha realización del pedido";
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		end if;

end ; //
delimiter ;

insert into pedidos values()

-- DATOS PARA PROBAR EL DISPARADOR.---

START TRANSACTION;
INSERT INTO PEDIDOS 
	(CodigoPedido,FechaPedido,FechaEsperada,FechaEntrega,Estado,Comentarios,CodigoCliente)
VALUES
	(129,'2015-05-21','2015-05-22','2015-05-23','Entregado',' ',5);

INSERT INTO DetallePedidos VALUES (129,'OR-227',67,64,1);
INSERT INTO DetallePedidos VALUES (129,'OR-247',5,462,4);
INSERT INTO DetallePedidos VALUES (129,'FR-48',120,9,6);
INSERT INTO DetallePedidos VALUES (129,'OR-122',32,5,4);
INSERT INTO DetallePedidos VALUES (129,'OR-123',11,5,5);
COMMIT;

SELECT * FROM controlClientes;

INSERT INTO PEDIDOS 
	(CodigoPedido,FechaPedido,FechaEsperada,FechaEntrega,Estado,Comentarios,CodigoCliente)
VALUES
	(130,'2015-05-22','2015-05-22','2015-05-20','Pendiente',' ',5);

SELECT * FROM controlClientes;
-- =================================================================================
--   Ejercicio
--
--   Crea un diparador AUMENTA_SUELDO que después de insertar un nuevo cliente  
--   y se le asigne un representante de ventas, se compruebe de manera automática  
--   cuántos clientes tiene dicho representante. Si tiene 2 o más clientes, se le 
--   aumentará el sueldo en 100 euros. 
-- =================================================================================


delimiter //
drop trigger if EXISTS AUMENTA_SUELDO//
create TRIGGER AUMENTA_SUELDO 
after 
insert on clientes for each ROW
BEGIN

declare rv int DEFAULT new.codigoempleadoRepventas;
declare totalClientes int DEFAULT (select count(*) from clientes where codigoempleadoRepventas= rv);
declare sueldorv DOUBLE DEFAULT (select sueldo from empleados where codigoEmpleado = rv);

if (totalClientes >= 2 )
then 
	UPDATE from empleados set sueldo = sueldorv + 100
	where codigoempleado = rv;
end if;


end ; //
delimiter ;


SELECT sueldo FROM empleados WHERE codigoEmpleado=31;

INSERT INTO Clientes 
VALUES (39,'NavarraGarden S.L','Gorka','Garde',
'948-999999','948-999999','Ctra. Guipuzcua s/n',NULL,'Berriozar',
'Navarra','España','31014',31,8000);

SELECT sueldo FROM empleados WHERE codigoEmpleado=31;


-- =================================================================================
--   Ejercicio
--
--   Crea un diparador INSERTA_CLIENTES que cada vez que se vaya a añadir algún
--   cliente se controle que su límite de crédito sea superior o igual a 2000.

--   Si se cumple esta condición se insertarán de manera automática en la tabla 
--   ControlClientes los valores: codigo de cliente, nombre del cliente, 
--   fecha en la que se ha realizado (utiliza la función MESFECHA), el código 
--   del empleado que lo representa y el límite de crédito del que dispone.

--   En caso contrario se debe lanzar un mensaje de error ("Error, el límite de 
--   crédito debe ser superior o igual a 2000 euros") y no permitir que se inserte
--   el pedido.
-- =================================================================================

CREATE TABLE IF NOT EXISTS controlClientes(
	codigoCliente INTEGER,
    nombreCliente VARCHAR(59),
    FechaAlta   VARCHAR(100),
    representate  INTEGER,
    limiteCredito DECIMAL(15,2)
);
drop trigger if exists inserta_clientes;
delimiter //
create TRIGGER INSERTA_CLIENTES 
BEFORE
INSERT on clientes FOR each ROW
BEGIN
declare cc int DEFAULT new.codigoCliente;
declare lc DECIMAL(15,2) DEFAULT new.limiteCredito;
declare msg VARCHAR(250);
if (lc >= 2000 )
THEN
	insert into controlClientes values (cc, new.nombrecliente, mesfecha(now()), new.codigoEmpleadorepventas, lc);
else  
	set msg = "Error, el límite de 
--   crédito debe ser superior o igual a 2000 euros";
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
end if ;
end ; //
delimiter ;

truncate controlClientes;
insert into clientes values codigoCliente,salario (39,8000000);


delete from clientes where codigocliente=39 or codigocliente = 40;


-- =================================================================================
-- OPERACIONES NECESARIAS PARA COMPROBAR EL TRIGGER
-- =================================================================================

SELECT * FROM controlClientes;

-- El nuevo cliente insertado no tiene un límite de crédito superior a 2000 euros
INSERT INTO Clientes VALUES (39,'NAVARRA GARDEN S.L','Julian','Sánchez',
'948-333555','948-333555','176 Avd. Baja Navarra',NULL,'Mutilva','Navarra','España',
'31003',31,1000);



-- El nuevo cliente insertado tiene un límite de crédito superior a 2000 euros
INSERT INTO Clientes VALUES (40,'NAVARRA GARDEN S.L','Julian','Sánchez',
'948-333555','948-333555','176 Avd. Baja Navarra',NULL,'Mutilva','Navarra','España',
'31003',31,8000);

SELECT * FROM controlClientes;

-- =================================================================================
--   Ejercicio 6    [2 puntos]
--
--   Crea un diparador INSERTA_ARTICULO que cada vez que se añada algún
--   artículo a un pedido, es decir, en la tabla detallePedidos, se compruebe que 
--   hay suficientes productos en stock para poder servilo.

CREATE TABLE CAMBIOS(
USER CHAR(30) NOT NULL,
CHA_TIME TIMESTAMP NOT NULL,
CHA_CODIGO INTEGER NOT NULL,
CHA_TYPE CHAR(1) NOT NULL,
CHA_CODIGO_NEW INTEGER DEFAULT NULL,
PRIMARY KEY (USER, CHA_TIME,
CHA_CODIGO, CHA_TYPE)
);
drop TRIGGER if EXISTS INSERTA_ARTICULO;

delimiter //
create TRIGGER INSERTA_ARTICULO

BEFORE
INSERT ON detallePedidos FOR EACH ROW
BEGIN

	DECLARE cp int DEFAULT  new.codigoPedido;
	declare cant int DEFAULT  new.cantidad;
	declare msg varchar (200);
	declare cantActual int DEFAULT  (select sum(cantidad) from detallePedidos where codigoPedido = cp);
	if cant <= cantActual
	then 
		INSERT INTO CAMBIOS
		(USER, CHA_TIME, CHA_CODIGO,CHA_TYPE)
		VALUES (USER, CURDATE(), NEW.codigoPedido, 'I');
		else  set msg = "ERROR!!";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	end if;
	
END ; //
delimiter ;
 DELETE FROM DETALLEPEDIDOS WHERE CODIGOpedido =128 and codigoProducto = "FR-67";
 TRUNCATE cambios;
 insert into detallePedidos  values (128,"FR-67",200000000,0,0,null);
--   Si se cumple esta condición se insertarán de manera automática en la tabla 
--   ControlClientes los valores: codigo de cliente, codigoProducto, cantidadPedida,
--   FechaPedido,FechaEntrega (utiliza la función FECHA_ENTREGA) e importe a pagar
--   (utiliza la función IMPORTE).

--   También se debe actualizar la cantidadEnStock que quedará del producto que
--   se ha pedido.

--   En caso de que no se pueda servir el producto se debe lanzar un mensaje de error 
--  ("Error, no hay suficientes productos en Stock") y no permitir que se inserte 
--   el pedido.
-- =================================================================================

CREATE TABLE IF NOT EXISTS controlClientes(
	codigoCliente   INTEGER,
	codigoProducto  VARCHAR(15),
	cantidadPedida  INTEGER,
    FechaPedido     VARCHAR(100),
	FechaEntrega    DATE,
	importe			DECIMAL(15,2)
);
drop TRIGGER if EXISTS INSERTA_ARTICULO;

delimiter //
create TRIGGER INSERTA_ARTICULO

BEFORE
INSERT ON detallePedidos FOR EACH ROW
BEGIN

	DECLARE cp int DEFAULT  new.codigoPedido;
	declare cant int DEFAULT  new.cantidad;
	declare msg varchar (200);
	declare cantActual int DEFAULT  (select sum(cantidad) from detallePedidos where codigoPedido = cp);
	if cant <= cantActual
	then 
		INSERT INTO controlClientes
		(USER, CHA_TIME, CHA_CODIGO,CHA_TYPE)
		VALUES (USER, CURDATE(), NEW.codigoPedido, 'I');
		else  set msg = "ERROR!!";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	end if;
	
END ; //
delimiter ;
 DELETE FROM DETALLEPEDIDOS WHERE CODIGOpedido =128 and codigoProducto = "FR-67";
 TRUNCATE cambios;
 insert into detallePedidos  values (128,"FR-67",200000000,0,0,null);

-- =================================================================================
-- OPERACIONES NECESARIAS PARA COMPROBAR EL TRIGGER
-- ==================================================================================

SELECT * FROM controlClientes;

-- El pedido 14 ha sido rechazado.
INSERT INTO DETALLEPEDIDOS 
	(CodigoPedido,CodigoProducto, Cantidad,PrecioUnidad,NumeroLinea)
VALUES
	(14,'AR-009', 100,2,3);
SELECT * FROM controlClientes;

-- El pedido 13 ha sido entregado
INSERT INTO DETALLEPEDIDOS 
	(CodigoPedido,CodigoProducto, Cantidad,PrecioUnidad,NumeroLinea)
VALUES
	(13,'AR-009', 100,2,3);
SELECT * FROM controlClientes;

-- El pedido 12 está pendiente de entrega: Los datos que deben 
-- insertarse en la tabla controlPedidos son: 
-- codigoCliente = 1, FechaPedido: 22 de enero de 2009, importe=490

INSERT INTO DETALLEPEDIDOS 
	(CodigoPedido,CodigoProducto, Cantidad,PrecioUnidad,NumeroLinea)
VALUES
	(12,'FR-11', 100,2,3);
SELECT * FROM controlClientes;