drop procedure if exists cursorRaro;
delimiter //
create procedure cursorRaro () 
begin

	declare finCursor tinyint(1) default 0;
	declare codOficina varchar(10);
	declare empleadosPorOficina int default 0;
	declare nombreEmpleado varchar(50);
	declare apellidoEmpleado varchar(50);
	declare puestoEmpleado varchar(50);
	declare cursorOficina cursor for select codigoOficina from oficinas;
	declare cursorEmpleados cursor for select nombre, apellido1, puesto
								from empleados 
								where codigoOficina = codOficina;

	declare continue handler for not found set finCursor = 1;

	open cursorOficina;

	loopUno : loop 

		fetch cursorOficina into codOficina;

		if finCursor then
			leave loopUno;
		end if;

		set empleadosPorOficina =  (select count(*) from empleados where codigoOficina = codOficina);
		Select concat("La oficina ", codOficina, " tiene ", empleadosPorOficina, " empleados");
		select "**************************************************************";

		open cursorEmpleados;

		loopDos : loop

			fetch cursorEmpleados into nombreEmpleado, apellidoEmpleado, puestoEmpleado;

			if finCursor then
				leave loopDos;
			end if;

			if (puestoEmpleado = "Representante Ventas") then
				select concat(nombreEmpleado, " ", apellidoEmpleado, " ", puestoEmpleado);
			end if;

		end loop loopDos;

		close cursorEmpleados;
		set finCursor = 0;

	end loop loopUno;
	close cursorOficina;

end //

delimiter ;


call cursorRaro();