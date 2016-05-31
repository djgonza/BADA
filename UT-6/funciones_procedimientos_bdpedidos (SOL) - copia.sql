-- *****************************************************************************************
--   			EJERCICIOS BASE DE DATOS PARA REPASO
-- *****************************************************************************************


-- Crea una función para calcular un importe a pagar (precio*cantidad) --
DELIMITER $$
DROP FUNCTION IF EXISTS importe $$
CREATE FUNCTION importe (vprecio float(10,2),vcantidad float(10,2)) RETURNS float(10,2)
BEGIN
declare vimporte float(10,2);
set vimporte=vprecio*vcantidad;
return vimporte;
END $$
DELIMITER;


-- Crea una función que calcule el descuento de un importe --
DELIMITER $$
DROP FUNCTION IF EXISTS descuento $$
CREATE FUNCTION descuento (vimporte float(10,2),vdescuento tinyint) RETURNS float(10,2)
BEGIN
declare vdes float(10,2);
set vdes=vimporte*((vdescuento-1)/100);
return vdes;
END $$
DELIMITER ;

select descuento(25,10);
-- Calcula la cantidad de iva a pagar de un determinado importe (codiva=18 o 8) --
DELIMITER $$
DROP FUNCTION IF EXISTS iva $$
CREATE FUNCTION iva (vimporte float(10,2),vtipo tinyint) RETURNS float(10,2)
BEGIN
declare viva float(10,2);
if vtipo=18 then
	set viva =vimporte*18;
elseif vtipo=8 then
	set viva =vimporte*8;
else
	begin end;
end if;
return viva;
END $$
DELIMITER;

-- Calcula la cantidad a pagar con el iva correspondiente --
DELIMITER $$
DROP FUNCTION IF EXISTS apagar $$
CREATE FUNCTION apagar (vimporte float(10,2),vtipo tinyint) RETURNS float(10,2)
BEGIN
declare viva float(10,2);
/*
set viva = if(vtipo=18,vimporte*1.21,null);
set viva = if(vtipo=8,vimporte*1.09,viva);
*/
set viva = vimporte + iva(vimporte,vtipo);
return viva;
END $$
DELIMITER ;

-- Crea un procedimiento que muestre los datos de la tabla pedidos.
DELIMITER $$
DROP PROCEDURE IF EXISTS Pedido $$
CREATE PROCEDURE Pedido (numero float(5))
BEGIN
 select * from pedidos where numero=numped;
END $$
DELIMITER ;

CALL Pedido(100);

-- Crea un procedimiento que dado un codigo de pedido actualice la cantidad en stock
-- de un producto y el estado del pedido pase a ser 'SE' 
DELIMITER $$
DROP PROCEDURE IF EXISTS EnStock $$
CREATE PROCEDURE EnStock (in pedido integer)
BEGIN
update
 pedidos p join linped l join articulos a
                        on p.numped=l.numped and  l.refart=a.refart
 --pedidos p join linped l on p.numped=l.numped 
 --inner join articulos a on l.refart=a.refart
 set a.cantstok=a.cantstok-l.cantped,
  p.estadoped='SE'
  --where l.cantped<=a.cantstok and p.estadoped='EP';
  where p.numped=pedido;
END $$
DELIMITER ;

CALL EnStock(1210);

-- Crea un procedimiento que muestre los detalles por cliente

DELIMITER $$
DROP PROCEDURE IF EXISTS detallesXCliente $$
CREATE PROCEDURE detallesXCliente (vnomcli varchar(30))
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
l.numlin"Linea",
a.nombre"Articulo",
l.cantped"Unidades Pedidas",
a.precio"Precio",
importe(a.precio,l.cantped)"Importe",
descuento(importe(a.precio,l.cantped),c.descuento)"Descuento",
apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva)"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart
where nomcli=vnomcli;
END $$
DELIMITER ;

call detallesXCliente('DUPONT S.A.');

-- Crea un procedimiento que muestre los detalles por pedido

DELIMITER $$
DROP PROCEDURE IF EXISTS detallesXPedido $$
CREATE  PROCEDURE detallesXPedido(vpedido int)
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
l.numlin"Linea",
a.nombre"Articulo",
a.cantstok"Stock",
l.cantped"Unidades Pedidas",
a.precio"Precio",
importe(a.precio,l.cantped)"Importe",
descuento(importe(a.precio,l.cantped),c.descuento)"Descuento",
apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva)"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart
where p.numped=vpedido;
END $$
DELIMITER ;

call detallesXPedido(100);

-- Muestra los detalles del pedido

DELIMITER $$
DROP PROCEDURE IF EXISTS detallesPedidos $$
CREATE PROCEDURE detallesPedidos()
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
l.numlin"Linea",
a.nombre"Articulo",
a.cantstok"Stock",
l.cantped"Unidades Pedidas",
a.precio"Precio",
importe(a.precio,l.cantped)"Importe",
descuento(importe(a.precio,l.cantped),c.descuento)"Descuento",
apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva)"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart;
END $$
DELIMITER ;

call detallesPedidos;


-- Crea un procedimiento que muestre los totales de un cliente

DELIMITER $$
DROP PROCEDURE IF EXISTS totalesXCliente $$
CREATE PROCEDURE totalesXCliente(vcliente varchar(20))
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
sum(importe(a.precio,l.cantped))"Importe",
sum(descuento(importe(a.precio,l.cantped),c.descuento))"Descuento",
sum(apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva))"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart

where c.nomcli=vcliente
group by p.numped;
END $$
DELIMITER ;

CALL totalesXCliente('ANALIA Laura');

-- Crea un procedimiento que muestre los totales de un pedido

DELIMITER $$
DROP PROCEDURE IF EXISTS totalesXPedido $$
CREATE PROCEDURE totalesXPedido(vnumer tinyint)
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
sum(importe(a.precio,l.cantped))"Importe",
sum(descuento(importe(a.precio,l.cantped),c.descuento))"Descuento",
sum(apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva))"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart

where l.numped=vnumer
group by p.numped;
END $$
DELIMITER ;
CALL totalesXPedido(100);

-- Crea un procedimiento que muestre todos los totales

DELIMITER ;
DELIMITER $$
DROP PROCEDURE IF EXISTS totales $$
CREATE PROCEDURE totales()
BEGIN
select
c.nomcli"Nombre del Cliente",
p.numped"Numero Pedido",
sum(importe(a.precio,l.cantped))"Importe",
sum(descuento(importe(a.precio,l.cantped),c.descuento))"Descuento",
sum(apagar(descuento(importe(a.precio,l.cantped),c.descuento),a.codiva))"Apagar"
from ((clientes c join pedidos p on p.numcli=c.numcli)
                join linped l on l.numped=p.numped)
                join articulos a on a.refart=l.refart
group by p.numped;
END $$
DELIMITER ;

CALL totales;

-- Crea un procedimiento que elimine de linped los pedidos 
-- que no se pueden servir

DELIMITER $$
DROP PROCEDURE IF EXISTS depuracion $$
CREATE PROCEDURE depuracion ()
BEGIN
  delete linped
  from linped, articulos
  where linped.refart = articulos.refart and
		linped.cantped>articulos.cantstok;
END $$
DELIMITER ;

call depuracion;

-- Copia a una nueva tabla llamada desechados los pedidos eliminados por depuracion (trigger)

delimiter $$
create trigger auditoria
  before
  delete
  on linped
  for each row
begin
  insert into desechados
  values (old.numped, old.numlin, old.refart, old.cantped);
end $$
delimiter ;

select * from desechados;

-- Crea un disparador que inserte cada vez que se crea un pedido el correspondiente albarán:
-- codalb = AL+numped, fechaenv = fechaped + 1 mes, codigopedido=numped, estadoalb= estadoped

delimiter //
drop trigger albaran//
create trigger albaran
after insert on pedidos for each row
begin
	insert into albaranes 
    values (concat('AL',new.numped),DATE_ADD( new.fechaped, INTERVAL 1 MONTH ), new.numped, new.estadoped);
end;
//
delimiter ;
insert into pedidos (numped, numcli, fechaped, estadoped) values (101,15,'2015-04-13','EP');
select * from albaranes;

-- crea un disparador que controle que la fecha de un pedido realizado sea anterior o igual 
-- a la fecha actual a la  que se graba la información del pedido.

delimiter //
create trigger pedidos
before insert on pedido for each row
begin
	declare error_fecha CONDITION FOR SQLSTATE '45000';
    if (new.fechaped>current_date) then
		signal error_fecha set message_text='La fecha del pedido debe ser anterior a la fecha actual';
	end if;
end;
//

delimiter ;
-- Crea un procedimiento que `por cada cliente muestre los pedidos que haya hecho (numped y fechaped) 
-- y cuántos pedidos ha hecho en total.


DELIMITER //
DROP PROCEDURE IF EXISTS clientesPedidos//
CREATE PROCEDURE clientesPedidos()
BEGIN
	DECLARE c_numcli INT;
    DECLARE c_nomcli VARCHAR(30);
    DECLARE c_numped INT;
    DECLARE c_fechaped date;
    
    DECLARE fincursor tinyint DEFAULT 0;
    DECLARE totalpedidos INT;
    DECLARE c_clientes CURSOR FOR SELECT numcli, nomcli FROM clientes;
    DECLARE c_pedidos CURSOR FOR SELECT numped, fechaped FROM pedidos WHERE pedidos.numcli=c_numcli;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fincursor=1;
    
    OPEN c_clientes;
    
    cursor_clientes: loop
    FETCH c_clientes INTO c_numcli,c_nomcli;
    IF fincursor=1 THEN
		LEAVE cursor_clientes;
	END IF;
    
    SELECT CONCAT('Cliente:', c_numcli, ' - ', c_nomcli) AS 'CLIENTE';
    SET totalpedidos =0;
    OPEN c_pedidos;
		cursor_pedidos: LOOP
			FETCH c_pedidos INTO c_numped,c_fechaped;
            IF fincursor=1 THEN
				LEAVE cursor_pedidos;
			END IF;
            SELECT CONCAT('Pedido: ',c_numped, ' - ',c_fechaped) as 'DATOS DEL PEDIDO';
            SET totalpedidos = totalpedidos +1;
		END LOOP cursor_pedidos;
	CLOSE c_pedidos;
        SELECT totalpedidos as 'TOTAL DE PEDIDOS DEL CLIENTE: ';
        SET fincursor=0;
	END LOOP cursor_clientes;
    CLOSE c_clientes;   
END 
//

delimiter ;
CALL clientesPedidos;

-- Crea un cursor que por cada pedido (linped) muestre los articulos que se han pedido (articulos)

DELIMITER //

DROP PROCEDURE IF EXISTS articulosPedidos//
CREATE PROCEDURE articulosPedidos()
BEGIN
	
							DECLARE c_numped INT;
							DECLARE c_nombre VARCHAR(30);
						   -- DECLARE totalarticulos int DEFAULT 0;
							DECLARE fincursor tinyint DEFAULT 0;
							DECLARE c_pedidos CURSOR FOR SELECT numped FROM linped;
							DECLARE c_articulos CURSOR FOR SELECT nombre FROM articulos WHERE articulos.refart=refart;
							
							DECLARE CONTINUE HANDLER FOR NOT FOUND SET fincursor=1;
							
							OPEN c_pedidos;
							loop1: loop
							FETCH c_pedidos INTO c_numped;
							IF fincursor=1 THEN
								LEAVE loop1;
							END IF;
							
							SELECT CONCAT('Pedido: ', c_numped) AS 'PEDIDOS';
							-- SET totalarticulos =0;
							OPEN c_articulos;
									loop2: LOOP
									FETCH c_articulos INTO c_nombre;
									IF fincursor=1 THEN
										LEAVE loop2;
									END IF;
									SELECT c_nombre as 'ARTICULOS PEDIDOS';
									-- SET totalarticulos = totalarticulos +1;
								END LOOP loop2;
							 CLOSE c_articulos;
							   --  SELECT totalarticulos as 'TOTAL DE ARTICULOS: ';
								SET fincursor=0;
							END LOOP loop1;
							CLOSE c_pedidos;   
END;
//

CALL articulosPedidos;




-- ******************************************************************************************
-- Crea la vista de las lineas de pedido de un mismo pedido
create view LineaPedidos
as select
ped.numped"Pedido",
cli.numcli"Cliente",
lin.numlin"NºLinea",
art.nombre"Articulo",
lin.cantped"Unidades",
art.precio"Precio",
art.precio*lin.cantped"Importe",
Importe((art.precio*lin.cantped),cli.descuento)"Apagar",
((Importe((art.precio*lin.cantped),cli.descuento))*iva(art.codiva))/100"IVA"
FROM linped lin JOIN pedidos ped ON lin.numped=ped.numped
JOIN articulos art ON lin.refart=art.refart
JOIN clientes cli ON ped.numcli=cli.numcli;

-- crea la vista de un pedido

CREATE VIEW Pedido AS SELECT
lin.numped "Pedido",
cli.nomcli "Cliente",
SUM(art.precio*lin.cantped)"Importe",
SUM((art.precio*lin.cantped)-(Importe((lin.cantped*art.precio), cli.descuento)))"ConDescuento",
SUM(((Importe((art.precio*lin.cantped),cli.descuento))*iva(art.codiva))/100)"IVA",
SUM(Apagar(Importe((lin.cantped*art.precio), cli.descuento), art.codiva)) "Apagar"
FROM linped lin
JOIN pedidos ped ON lin.numped=ped.numped
JOIN articulos art ON lin.refart=art.refart
JOIN clientes cli ON ped.numcli=cli.numcli
group by lin.numped;

-- Codifica la categoria del articulo

DELIMITER $$
DROP PROCEDURE IF EXISTS `cursores`.`Codificar_categoria` $$
CREATE PROCEDURE `cursores`.`Codificar_categoria` ()
BEGIN

/*Crea la tabla para codificar la categoria*/

create table codcategoria(
  cod tinyint auto_increment,
  categoria varchar(20),
constraint kp10 primary key (cod)
);

insert into codcategoria(categoria)
  select distinct(categoria) from articulos;

alter table articulos
  add(cod_categoria int not null);

update codcategoria,articulos
set articulos.cod_categoria=codcategoria.cod
where articulos.categoria=codcategoria.categoria;

alter table articulos
  drop categoria;

END $$
DELIMITER;

DELIMITER $$
DROP PROCEDURE IF EXISTS `cursores`.`Descodificar_categoria` $$
CREATE PROCEDURE `cursores`.`Descodificar_categoria` ()
BEGIN

alter table articulos
  add(categoria varchar(20));

update codcategoria,articulos
set articulos.categoria=codcategoria.categoria
where articulos.cod_categoria=codcategoria.cod;

drop table codcategoria;

END $$
DELIMITER ;

