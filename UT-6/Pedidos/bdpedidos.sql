-- drop schema ejercicio_repaso;
create schema ejercicio_repaso;
use ejercicio_repaso;


-- drop table clientes;
create table clientes(
numcli 	int not null,
nomcli	varchar(30) not null,
dircli	varchar(60),
cod_postal char(5),
pobla char(30) DEFAULT 'Pamplona',
descuento int,
PRIMARY KEY(numcli)
);

-- drop table articulos;
create table articulos(
refart char(4) not null,
nombre varchar(30) not null,
precio DECIMAL(8,2),
codiva INT,
categoria char(10),
cantstok INT check (cantstok > 5),
PRIMARY KEY(refart)
);

-- drop table pedidos;
create table pedidos(
  numped    INT not null,
  numcli    INT,
  fechaped  date,
  estadoped char(2) CHECK( estadoped IN('EP','LI','SE')),
  PRIMARY KEY(numped),
  CONSTRAINT fk_ped FOREIGN KEY (numcli) REFERENCES clientes(numcli)  on delete restrict on update cascade
);
-- drop table linped;
create table linped(
  numped INT,
  numlin INT,
  refart char(4),
  cantped INT,
  CONSTRAINT pk_lin PRIMARY KEY (numped, numlin),
  CONSTRAINT fk_lin_art FOREIGN KEY (refart) REFERENCES articulos(refart) on delete restrict on update cascade,
  CONSTRAINT fk_lin_ped FOREIGN KEY (numped) REFERENCES pedidos(numped) on delete restrict on update cascade 
);

create table desechados(
  numped INT,
  numlin INT,
  refart char(4),
  cantped INT,
  CONSTRAINT pk_lin1 PRIMARY KEY (numped, numlin),
  CONSTRAINT fk_lin_art1 FOREIGN KEY (refart) REFERENCES articulos(refart)
  on delete restrict on update cascade ,
  CONSTRAINT fk_lin_ped1 FOREIGN KEY (numped) REFERENCES pedidos(numped)
  on delete restrict on update cascade 
);


-- drop table albaranes;
create table albaranes(
  codalb varchar(10) not null,
  fechaenv date not null,
  codpedido INT not null,
  estadoalb char(2) not null CHECK( estadoalb IN('PE','PA')),
  PRIMARY KEY(codalb),
  CONSTRAINT fk_alb FOREIGN KEY (codpedido) REFERENCES pedidos(numped)
  on delete restrict on update cascade 
);

insert into articulos (refart, nombre, precio, codiva,categoria, cantstok)
              values ('AB22','Tapiz persa',1250.1,18,'IMPORT',15);
insert into articulos (refart, nombre, precio, codiva,categoria, cantstok)
              values ('CD50','Alfombra persa',890.70, 18,'IMPORT',17);
insert into articulos (refart,nombre, precio, codiva, categoria, cantstok)
              values ('CD21','Platina laser',500,18,'IMPORT',20);
insert into articulos (refart, nombre,precio, codiva,categoria,cantstok)
              values ('ZZZZ','Chucheria',2.10, 8,'DIVERSOS',250);
insert into articulos (refart,nombre, precio, codiva, categoria, cantstok)
              values ('AA00','Regalo',54, 18,'DIVERSOS',18);
insert into articulos (refart, nombre, precio, codiva, categoria, cantstok)
              values ('AB03','Carpeta',150,18,'SALDOS',116);
insert into articulos (refart, nombre, precio, codiva, categoria, cantstok)
              values ('AB','Tapiz',340, 18,'DIVERSOS',200);
insert into articulos (refart, nombre, precio, codiva, categoria, cantstok)
              values ('ZZ01','Lote de tapices',500,18,'DIVERSOS',10);
insert into articulos (refart, nombre, precio, codiva, categoria, cantstok)
              values ('AB10','Tapiz chino',1500,18,'IMPORT',110);


insert into clientes (numcli, nomcli,dircli, cod_postal, pobla, descuento) values (1,'ANALIA Laura','calle cármenes',default,default,5);
insert into clientes (numcli, nomcli, cod_postal, pobla, descuento) values (15,'DUPONT S.A.','08030','BARCELONA', 15);
insert into clientes (numcli, nomcli, cod_postal, pobla, descuento) values (20,'Etb LABICHE','08010','BARCELONA',24);
insert into clientes (numcli, nomcli, cod_postal, pobla, descuento) values (35,'DUBOIS Juan','08002','BARCELONA',10);
insert into clientes (numcli, nomcli,dircli, cod_postal, pobla, descuento) values (36,'Bernard S.A.','calle carmen','23000','MADRID',5);
insert into clientes (numcli, nomcli,pobla, descuento) values (37,'Ets LAROCHE',default, default);
insert into clientes (numcli, nomcli, cod_postal, pobla, descuento) values (138,'DUBOIS Juan','41005','SEVILLA',8);
insert into clientes (numcli, nomcli, cod_postal, pobla, descuento) values (152,'LAROCHE','20002','BILBAO',5);

insert into pedidos (numped, numcli, fechaped, estadoped) values (100,15,'2012-04-13','EP');
insert into pedidos (numped, numcli, fechaped, estadoped) values (1301,36,'2012-05-12','EP');
insert into pedidos (numped, numcli, fechaped, estadoped) values (1210,15,'2010-10-13','EP');
insert into pedidos (numped, numcli, fechaped, estadoped) values (1250,20,'2012-06-01','EP');
insert into pedidos (numped, numcli, fechaped, estadoped) values (1230,1,'2011-12-22','EP');


insert into linped(numped, numlin, refart, cantped) values (1210,1,'AB10',3);
insert into linped(numped, numlin, refart, cantped) values (1210,2,'CD50',14);
insert into linped(numped, numlin, refart, cantped) values (100,1,'ZZZZ',2);
insert into linped(numped, numlin, refart, cantped) values (100,2,'AB',1);
insert into linped(numped, numlin, refart, cantped) values (100,3,'CD50',1000);
insert into linped(numped, numlin, refart, cantped) values (1301,1,'CD50',2);
insert into linped(numped, numlin, refart, cantped) values (1301,2,'AA00',10);
insert into linped(numped, numlin, refart, cantped) values (1301,3,'CD21',4);
insert into linped(numped, numlin, refart, cantped) values (1301,4,'ZZZZ',20);
insert into linped(numped, numlin, refart, cantped) values (1250,1,'AB10',4);
insert into linped(numped, numlin, refart, cantped) values (1250,2,'ZZ01',1);
insert into linped(numped, numlin, refart, cantped) values (1250,3,'AB',2);
insert into linped(numped, numlin, refart, cantped) values (1230,1,'CD50',3);
insert into linped(numped, numlin, refart, cantped) values (1230,2,'CD21',11);

