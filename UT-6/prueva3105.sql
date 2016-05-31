CREATE TABLE IF NOT EXISTS control(
	usuario   varchar(128),
	fecha  date,
	nombreEmpleado varchar(50)
  
);
CREATE TABLE IF NOT EXISTS controlErorres(
	usuario   varchar(128),
	fecha  date,
	error text
  
);

drop trigger if exists controlEmpleados;

delimiter //
create trigger controlEmpleados
before insert on personal for each row
begin
		declare numempleados int default 0;
		declare error_insercion condition for sqlstate '45000';
		
		set numempleados = (select count(*) from personal 
								where funcion=new.funcion);
		
		case 
		when new.funcion = "ADMINISTRATIVO"
		then 
			if numempleados>4
			then 
            insert into controlErrores values(user(), now(), "No se puede insertar");
				signal error_insercion set message_text="No se puede insertar";
				
			end if;
		end case;
		insert into  control values(user(), now(), new.apellidos);


end
//
delimiter ;
insert into personal values(45, 422, "MANOLETE", "ADMINISTRATIVO",451.89 );