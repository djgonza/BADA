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

delimiter $$

USE jardineria$$
DROP PROCEDURE LISTA_PEDIDOS$$
CREATE PROCEDURE LISTA_PEDIDOS (IN nombrecli VARCHAR(50))
BEGIN
 DECLARE c_codPedido, Importe_Euros INTEGER;
 DECLARE c_estado VARCHAR(15);
 DECLARE FOUND BOOLEAN DEFAULT TRUE;
 DECLARE C_PEDIDOS CURSOR FOR 
    SELECT CodigoPedido, Estado
    FROM Pedidos inner join Clientes ON pedidos.CodigoCliente=Clientes.codigoCliente 
    WHERE nombreCliente = nombrecli;    
 DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET FOUND = FALSE;

OPEN C_PEDIDOS;
FETCH C_PEDIDOS INTO c_codPedido,c_estado;
WHILE FOUND DO
  SELECT SUM(IMPORTE(PrecioUnidad,cantidad))
    INTO Importe_Euros
    FROM detallePedidos
    WHERE CodigoPedido = c_codPedido;
  SELECT c_codPedido, c_estado, Importe_Euros, DOLARES(Importe_Euros) AS Importe_Dolares;
  FETCH C_PEDIDOS INTO c_codPedido,c_estado;
END WHILE;
CLOSE C_PEDIDOS;
END$$

delimiter ;

call lista_pedidos('DGPRODUCTIONS GARDEN');

-- =================================================================================
--   Ejercicio 
--
--   Crea un diparador INSERTA_PEDIDOS que cada vez que se  uninserte pedido para un 
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

DROP TRIGGER IF EXISTS INSERTA_PEDIDOS;
DELIMITER //
CREATE TRIGGER INSERTA_PEDIDOS 
BEFORE INSERT ON pedidos FOR EACH ROW 
BEGIN
	DECLARE importe DECIMAL(15,2) DEFAULT 0;
    DECLARE error_fecha CONDITION FOR SQLSTATE '45000';
    
	IF(NEW.FechaEntrega<NEW.FechaPedido) THEN
		SIGNAL error_fecha SET MESSAGE_TEXT='Error, la fecha de entrega
            debe ser posterior a la fecha realización del pedido';
	ELSE
		SELECT SUM(IMPORTE(precioUnidad,cantidad)) INTO importe
        FROM detallePedidos 
        WHERE CodigoPedido=NEW.CodigoPedido;
        
		INSERT INTO controlClientes
		VALUES(NEW.codigoCliente, MESFECHA(NEW.FechaPedido), importe);
	END IF;
END;
//

DELIMITER ;

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
DROP TRIGGER IF EXISTS AUMENTA_SUELDO;
DELIMITER //
CREATE TRIGGER AUMENTA_SUELDO
AFTER INSERT ON clientes FOR EACH ROW 
BEGIN
	DECLARE numCli INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO numCli
	FROM clientes
    WHERE codigoEmpleadoRepVentas=NEW.codigoEmpleadoRepVentas
    GROUP BY codigoEmpleadoRepVentas;
    IF numCli>=2 THEN
		UPDATE empleados
		SET sueldo = sueldo + 100
        WHERE codigoEmpleado=NEW.codigoEmpleadoRepVentas;
	END IF;
END;
//

DELIMITER ;


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

CREATE TRIGGER INSERTA_CLIENTES
BEFORE INSERT ON clientes FOR EACH ROW
BEGIN
	DECLARE ERRO_LIMITE CONDITION FOR SQLSTATE '45000';
	IF (NEW.limiteCredito < 2000) THEN
		SIGNAL ERRO_LIMITE '45000' SET MESSAGE_TEXT='ERROR';
	ELSE
	INSERT INTO controlClientes 
	VALUES (NEW.CodigoCliente,NEW.nombrecliente,MESFECHA(NOW()),
	NEW.codigoEmpleadoRepVentas,new.limiteCredito)
	END IF;
END;


-- =================================================================================
-- OPERACIONES NECESARIAS PARA COMPROBAR EL TRIGGER
-- =================================================================================

SELECT * FROM controlClientes;

-- El nuevo cliente insertado no tiene un límite de crédito superior a 2000 euros
INSERT INTO Clientes VALUES (39,'NAVARRA GARDEN S.L','Julian','Sánchez',
'948-333555','948-333555','176 Avd. Baja Navarra',NULL,'Mutilva','Navarra','España',
'31003',31,1000);



-- El nuevo cliente insertado tiene un límite de crédito superior a 2000 euros
INSERT INTO Clientes VALUES (39,'NAVARRA GARDEN S.L','Julian','Sánchez',
'948-333555','948-333555','176 Avd. Baja Navarra',NULL,'Mutilva','Navarra','España',
'31003',31,8000);

SELECT * FROM controlClientes;

-- =================================================================================
--   Ejercicio 6    [2 puntos]
--
--   Crea un diparador INSERTA_ARTICULO que cada vez que se añada algún
--   artículo a un pedido, es decir, en la tabla detallePedidos, se compruebe que 
--   hay suficientes productos en stock para poder servilo.

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

DROP TRIGGER IF EXISTS INSERTA_ARTICULO;
DELIMITER //
CREATE TRIGGER INSERTA_ARTICULO 
BEFORE INSERT ON detallepedidos FOR EACH ROW 
BEGIN
	DECLARE CodCli INTEGER DEFAULT 0;
    DECLARE cantStock SMALLINT(6) DEFAULT 0;
	SELECT cantidadEnStock INTO cantStock
	FROM detallepedidos d INNER JOIN productos p 
		ON d.codigoPedido=p.codigoPedido
	WHERE p.codigoPedido=NEW.codigoPedido;
	
    IF (cantidadEnStock < cantStock) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT='Error, no hay suficientes productos en Stock';
	ELSE
       
        SELECT CodigoCliente 
		FROM Pedidos P, detallePedidos d 
		WHERE p.codigoPedido=d.codigoPedido AND
		NEW.CodigoPedido=P.CodigoPedido INTO CodCli;
		
		SELECT FechaPedido FROM PEDIDOS P WHERE NEW.CodigoPedido=P.CodigoPedido INTO fec;
        
        INSERT INTO controlClientes VALUES(CodCli,new.CODIGOPRODUCTO, NEW.cantidadPedida, 
			CURRENT_DATE,MESFECHA(CURRENT_DATE),IMPORTE(new.preciounidad,new.cantidad));
			
		UPDATE productos
		SET cantidadEnStock=cantidadEnStock - new.cantidadPedida
		WHERE codigoProducto=new.codigoProducto;
		
	END IF;
END;
//

DELIMITER ;
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




DROP PROCEDURE if exists num_empleados;
delimiter $$

CREATE PROCEDURE num_empleados ()
BEGIN

declare c_cod_oficina varchar(10);
declare c_cod_empleado integer;
declare fincursorUno tinyint default 0;
declare cursor_numEmpleados cursor for select CodigoOficina , count(CodigoEmpleado) from empleados group by CodigoOficina;

declare continue handler for not found set fincursorUno=1;

open cursor_numEmpleados;

loop1: loop
fetch cursor_numEmpleados into c_cod_oficina, c_cod_empleado;
if fincursorUno then
leave loop1;
end if;
if (c_cod_empleado>= 5) then
select concat("La oficina ", c_cod_oficina, " tiene ", c_cod_empleado, " empleados");
end if;
end loop loop1;
    
    close cursor_numEmpleados;


END $$

delimiter ;

#el empleado ganara 1000 si la oficina en la que trabaja tiene mas de 5 empleados. 

DROP PROCEDURE if exists aumento_salario;
delimiter $$

CREATE PROCEDURE aumento_salario()
BEGIN

declare c_cod_oficina varchar(10);
declare c_cod_empleado integer;
declare fincursorUno tinyint default 0;
declare cursor_numEmpleados cursor for select CodigoOficina , count(CodigoEmpleado) from empleados group by CodigoOficina;

declare continue handler for not found set fincursorUno=1;

open cursor_numEmpleados;

loop1: loop
fetch cursor_numEmpleados into c_cod_oficina, c_cod_empleado;
if fincursorUno then
leave loop1;
end if;
if (c_cod_empleado>= 5) then
update empleados 
set Sueldo = Sueldo + 1000
where CodigoOficina=c_cod_oficina;
end if;
end loop loop1;
    
    close cursor_numEmpleados;


END $$

delimiter ;

#mostrar codigo oficina, con sus empleados y salario

DROP PROCEDURE if exists aumento_salario;
delimiter $$

CREATE PROCEDURE aumento_salario()
BEGIN

declare c_cod_oficina varchar(10);
declare c_cod_empleado integer;
declare c_nombre varchar(50);
declare c_cod_empleado integer;

declare fincursorUno tinyint default 0;
declare cursor_numEmpleados cursor for select CodigoOficina , count(CodigoEmpleado) from empleados group by CodigoOficina;
declare cursor_sueldo cursor for select Nombre , Sueldo from empleados where CodigoOficina=c_cod_oficina;


declare continue handler for not found set fincursorUno=1;

open cursor_numEmpleados;

	loop1: loop
		fetch cursor_numEmpleados into c_cod_oficina, c_cod_empleado;
		if fincursorUno then
			leave loop1;
		end if;
        
		if (c_cod_empleado>= 5) then
			update empleados 
			set Sueldo = Sueldo + 1000
			where CodigoOficina=c_cod_oficina;
		end if;
	end loop loop1;
    
    close cursor_numEmpleados;


END $$

delimiter ;



drop procedure if exists chapuzaDos;
delimiter //
create procedure chapuzaDos()
begin

	declare cont int default 0;
    declare totalNotas int default 0;
    declare notaUno int default 0;
    declare notaDos int default 0;
    declare notaTres int default 0;
    
    declare fin  tinyint default 0;
    declare curChap cursor for select nota1, nota2, nota3 from notas_alumnos;
    declare continue handler for not found set fin = 1;
    
	

	open curChap;
	loop1: loop
		fetch curChap into notaUno, notaDos, notaTres;
       
		if fin then
			leave loop1;
		end if;
		
        if notaUno is not  null then
		set totalNotas = totalNotas + (notaUno);
        
        end if;
        if notaDos is not null then
		set totalNotas = totalNotas + (notaDos);
        end if;
        if notaTres is not null then
		set totalNotas = totalNotas + (notaTres);
        end if;
        
		set cont = cont + 3;
		
	end loop loop1;
	
	close curChap;
	
	select (totalNotas/cont);



end
//
delimiter ;
call chapuzaDos();


