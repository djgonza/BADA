
/* trigger para llevar el control de que usuario añade informacion a la bd */
CREATE TABLE controlInsertsPelicula (
	Usuario varchar(255) NOT NULL,
	fecha date NOT NULL,
	idPelicula int
);

drop TRIGGER if EXISTS insertPelicula;

delimiter //

create trigger insertPelicula 
before
insert on pelicula for each row 
begin

	insert into controlInsertsPelicula values (user(), now(), (
		select max(id) from pelicula
	));

end ; //

delimiter ;

## Prueba: INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:45A7659C-8E5E-4DB8-B9CB-9C838A65D1B6', '01:29:00', true, '2007-01-01', 'DVD - R', 'Drama', 'España', 7, 'DVD-Rip:Avi', '¿Y Tu Quien Eres?', 5);

/* controla que las peliculas insertadas tengan duracion mayor a 0 */
drop TRIGGER if EXISTS insertPeliculaValida;

delimiter //

create trigger insertPeliculaValida
after
insert on pelicula for each row 
begin

	if (select formateoDuracion(new.duración) <= 0)
	then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La duracion de la pelicula no es correcta";
	end if;

end ; //

delimiter ;

## Prueba: INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:45A7659C-8E5E-4DB8-B9CB-9C838A65D1B6', '00:00:00', true, '2007-01-01', 'DVD - R', 'Drama', 'España', 7, 'DVD-Rip:Avi', '¿Y Tu Quien Eres?', 5);

/* devulve la cantidad de peliculas que no han sido vistas */
drop procedure if EXISTS peliculasPorVer;

delimiter //

create procedure peliculasPorVer (out numeroPeliculas int) 
begin

	declare numeroPeliculas int default 0;

	set numeroPeliculas = (select count(*) from pelicula where vista = false);

end ; //
delimiter ;

## Prueba: 	call PeliculasPorVer(@numeroPeliculas)
##			select @numeroPeliculas

/* funcion que formatea la duracion de las peliculas */
drop function if EXISTS formateoDuracion;

delimiter //

create function formateoDuracion (duracion varchar(9)) returns int
begin

	return (select second (duracion));

end ; //

delimiter ;

## Prueba: select formateoDuracion ("01:25:15");

/* procedimiento que devulve la cantidad de horas que llevaria ver todas las peliculas */
drop procedure if EXISTS totalTiempoPeliculas;

delimiter //

create procedure totalTiempoPeliculas (out tiempo int)
begin

	declare tiempo int default 0;
	declare tiempoPelicula varchar(8);
	declare fincursor int default 0;

	declare ctiempo cursor for select duracion from peliculas;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fincursor = 1;

	open ctiempo;
	loopuno : loop
		
		fetch ctiempo into tiempoPelicula;
		
		if fincursor = 1 
		then 
			leave loopuno;
		end if;
		
		set tiempo = (select formateoDuracion(tiempoPelicula));

	end loop loopuno;

end ; // 

## Prueba: call totalTiempoPeliculas (@tiempo)