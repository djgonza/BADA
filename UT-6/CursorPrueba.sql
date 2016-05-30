drop procedure if exists empleadosPorOfcina;

delimiter //

create procedure empleadosPorOfcina ()
begin

	declare codOficina varchar(10);
	declare fincursor tinyint(1) default 0;
	declare antiguoSueldo double;
	declare nombreEmpleado varchar (255);

	declare cursorepo cursor for select codigoOficina from oficinas;
	declare cursorSueldo for select nombre, sueldo from empleados where codigoOficina = codOficina;

	declare continue handler for not found set fincursor = 1;

	open cursorepo;

	loopUno : loop

		fetch cursorepo into codOficina;

		if fincursor then 
			leave loopUno;
		end if;

		if ((select count(*) from empleados where codigoOficina = codOficina) >= 3)
		then
			open cursorSueldo;

			loopDos : loop

				fetch cursorSueldo into nombreEmpleado, antiguoSueldo;

				if fincursor then 
					leave loopDos;
				end if;

				update empleados set sueldo = (antiguoSueldo + 1000) where nombre = nombreEmpleado;
				select concat("El empleado ", nombreEmpleado, " antes ganaba ", antiguoSueldo, " y  ahora gana ", antiguoSueldo + 1000);

			end loop loopDos;
		
			close cursorSueldo;
			set fincursor = 0;

		end if;

		/*select codigoOficina, nombre, sueldo from empleados where codigoOficina = codOficina;*/

		/*select codOficina, count(*) from empleados where codigoOficina = codOficina;*/
		/*select concat("La oficina ", codOficina, " tiene ", count(*), " empleados") from empleados where codigoOficina = codOficina;*/

	end loop loopUno;

	close cursorepo;

end //

delimiter ;

call empleadosPorOfcina;