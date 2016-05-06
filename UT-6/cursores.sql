drop procedure if exists aumentaSalario;

delimiter //

create procedure aumentaSalario ()
begin

	declare csalario, cdept, cnumeroEmpleado int;

	declare fincursor tinyint(1) default 0;

	declare cursorSalario cursor for select emp_no, salario, dept_no from empleados;

	declare continue handler for not found set fincursor = 1;

	open cursorSalario;

	loopUno : loop

		fetch cursorSalario into cnumeroEmpleado, csalario, cdept;

		if fincursor then 
			leave loopUno;
		end if;

		case cdept
			when 10 then
				update empleados set salario = csalario + 10 where emp_no = cnumeroEmpleado;
			when 20 then
				update empleados set salario = csalario + 20 where emp_no = cnumeroEmpleado;
			when 30 then
				update empleados set salario = csalario + 30 where emp_no = cnumeroEmpleado;
			else
				begin
				end;
		end case;

	end loop loopUno;

	close cursorSalario;


end //

delimiter ;