drop procedure if exists pruebaCase;

delimiter //

create procedure pruebaCase ()
begin



	declare cRefart varchar(50);
	declare cPrecio double;

	declare fincursor tinyint(1) default 0;

	declare cursorPrecio cursor for select refart, precio from articulos;

	declare continue handler for not found set fincursor = 1;

	open cursorPrecio;

	loopUno : loop
		
		fetch cursorPrecio into cRefart, cPrecio;

		if fincursor then 
			leave loopUno;
		end if;

		select cPrecio;
		case
			when cPrecio > 100 and cPrecio < 200 then
				update articulos set precio = cPrecio + 10 where refart = cRefart;
			when cPrecio > 200 then
				update articulos set precio = cPrecio + 20 where refart = cRefart;
			else
				update articulos set precio = 0 where refart = cRefart;

		end case;

	end loop loopUno;


end; //

delimiter ;