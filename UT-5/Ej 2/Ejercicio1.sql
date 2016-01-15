
CREATE TABLE articulo(
	cod_articulo NUMERIC(6) NOT NULL,
	precio NUMERIC(6,2),
	stock NUMERIC(4),
	denominacion VARCHAR(15),
	PRIMARY KEY(cod_articulo));
)

CREATE TABLE clientes (
	cod_cliente DECIMAL(6) NOT NULL,
	nombre varchar(15),
	direccion varchar (15),
	telefono decimal(10),
	PRIMARY KEY(cod_cliente)
);

CREATE TABLE compra (
	cod_cliente numeric(6) not null,
	cod_articulo numeric(6) not null,
	unidades_vendidas int,
	fecha_venta date,
	constraint pk_compra primary key (cod_cliente, cod_articulo),
	constraint fk_cliente foreign key (cod_cliente) references clientes (cod_cliente) on delete cascade on update cascade,
	constraint fk_articulo foreign key (cod_articulo) references articulos (cod_articulo) on delete cascade on update cascade
);

