Create database Fabricantes;

use Fabricantes;

create table fabricante(
  id_fab integer primary key,
  nombre varchar(50),
  pais   varchar(30));

create table programa(
  codigo integer primary key,
  nombre varchar(50),
  version varchar(50));

create table comercio(
  cif integer primary key,
  nombre varchar(50),
  ciudad varchar(50));

create table cliente(
  dni integer primary key,
  nombre varchar(50),
  edad integer);

create table desarrolla(
  id_fab integer,
  codigo integer,
  primary key(id_fab,codigo));

create table distribuye(
  cif integer,
  codigo integer,
  cantidad integer,
  primary key(cif,codigo));

create table registra(
  cif integer,
  dni integer,
  codigo integer,
  medio varchar(20),
  primary key(cif,dni));

insert into fabricante values(1,'Oracle','Estados Unidos');
insert into fabricante values(2,'Microsoft','Estados Unidos');
insert into fabricante values(3,'IBM','Estados Unidos');
insert into fabricante values(4,'Dinamic','España');
insert into fabricante values(5,'Borland','Estados Unidos');
insert into fabricante values(6,'Symantec','Estados Unidos');

insert into programa values(1,'Application Server','9i');
insert into programa values(2,'Database','8i');
insert into programa values(3,'Database','9i');
insert into programa values(4,'Database','10g');
insert into programa values(5,'Developer','6i');
insert into programa values(6,'Access','97');
insert into programa values(7,'Access','2000');
insert into programa values(8,'Access','XP');
insert into programa values(9,'Windows','98');
insert into programa values(10,'Windows','XP Professional');
insert into programa values(11,'Windows','XP Home Edition');
insert into programa values(12,'Windows','2003 Server');
insert into programa values(13,'Norton Internet Security','2004');
insert into programa values(14,'Freddy Hardest',NULL);
insert into programa values(15,'Paradox','2');
insert into programa values(16,'C++ Builder','5.5');
insert into programa values(17,'DB/2','2.0');
insert into programa values(18,'OS/2','1.0');
insert into programa values(19,'JBuilder','X');
insert into programa values(20,'La prisión','1.0');

insert into comercio values(1,'El Corte Inglés','Sevilla');
insert into comercio values(2,'El Corte Inglés','Madrid');
insert into comercio values(3,'Jump','Valencia');
insert into comercio values(4,'Centro Mail','Sevilla');
insert into comercio values(5,'FNAC','Barcelona');

insert into cliente values(1,'Pepe Pérez',45);
insert into cliente values(2,'Juan González',45);
insert into cliente values(3,'María Gómez',33);
insert into cliente values(4,'Javier Casado',18);
insert into cliente values(5,'Nuria Sánchez',29);
insert into cliente values(6,'Antonio Navarro',58);

insert into desarrolla values(1,1);
insert into desarrolla values(1,2);
insert into desarrolla values(1,3);
insert into desarrolla values(1,4);
insert into desarrolla values(1,5);
insert into desarrolla values(2,6);
insert into desarrolla values(2,7);
insert into desarrolla values(2,8);
insert into desarrolla values(2,9);
insert into desarrolla values(2,10);
insert into desarrolla values(2,11);
insert into desarrolla values(2,12);
insert into desarrolla values(6,13);
insert into desarrolla values(4,14);
insert into desarrolla values(5,15);
insert into desarrolla values(5,16);
insert into desarrolla values(3,17);
insert into desarrolla values(3,18);
insert into desarrolla values(5,19);
insert into desarrolla values(4,20);

insert into distribuye values(1,1,10);
insert into distribuye values(1,2,11);
insert into distribuye values(1,6,5);
insert into distribuye values(1,7,3);
insert into distribuye values(1,10,5);
insert into distribuye values(1,13,7);
insert into distribuye values(2,1,6);
insert into distribuye values(2,2,6);
insert into distribuye values(2,6,4);
insert into distribuye values(2,7,7);
insert into distribuye values(3,10,8);
insert into distribuye values(3,13,5);
insert into distribuye values(4,14,3);
insert into distribuye values(4,20,6);
insert into distribuye values(5,15,8);
insert into distribuye values(5,16,2);
insert into distribuye values(5,17,3);
insert into distribuye values(5,19,6);
insert into distribuye values(5,8,8);

insert into registra values(1,1,1,'Internet');
insert into registra values(1,3,4,'Tarjeta postal');
insert into registra values(4,2,10,'Teléfono');
insert into registra values(4,1,10,'Tarjeta postal');
insert into registra values(5,2,12,'Internet');
insert into registra values(2,4,15,'Internet');

