drop procedure if exists pedidosPorCliente;

delimiter //

create procedure pedidosPorCliente (in nomCli varchar(255))
begin

    declare codPed int;
    declare estadoPedido varchar(255);
    declare codCliente int(11) default (select CodigoCliente from clientes where NombreCliente = nomCli);
    declare fincursor tinyint(1) default 0;
    declare totalPedidosPorEstado int(11);
    declare cont int(11) default 0;
    
    declare cursorPedidos cursor for select CodigoPedido, Estado from pedidos where codigoCliente = codCliente;
    
    declare continue handler for not found set fincursor = 1;
    
    create temporary table IF NOT EXISTS tTemp (
        estado varchar(255),
        codigoPedido varchar(255),
        codigoCliente varchar(255)
    );
    
    open cursorPedidos;
    
    wCursor : while fincursor != 1 do
    
        fetch cursorPedidos into codPed, estadoPedido;
        
        case 
        when estadoPedido = "entregado" then
            
            set totalPedidosPorEstado = (select count(*) from pedidos where estado = "entregado");
            
            wContador : while cont < totalPedidosPorEstado do
            
                insert into tTemp select "entregado", CodigoPedido, codigoCliente from pedidos where estado = "entregado" limit cont, 1;
                set cont = cont + 1;
            
            end while wContador;
            
        when estadoPedido = "Pendiente" then
        
            set totalPedidosPorEstado = (select count(*) from pedidos where estado = "pendiente");
            
            wContador : while cont < totalPedidosPorEstado do
            
                insert into tTemp select "pendiente", CodigoPedido, codigoCliente from pedidos where estado = "pendiente" limit cont, 1;
                set cont = cont + 1;
            
            end while wContador;
        
        when estadoPedido = "Servido" then
        
            set totalPedidosPorEstado = (select count(*) from pedidos where estado = "Servido");
            
            wContador : while cont < totalPedidosPorEstado do
            
                insert into tTemp select "Servido", CodigoPedido, codigoCliente from pedidos where estado = "Servido" limit cont, 1;
                set cont = cont + 1;
            
            end while wContador;
        
        else
        
            select "Estado incorrecto de pedidos";
            
        end case;
        
    end while wCursor;
    
    close cursorPedidos;
    
    select * from tTemp;

end //

call pedidosPorCliente("Gerudo Valley")