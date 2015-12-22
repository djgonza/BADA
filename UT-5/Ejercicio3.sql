use tienda;

INSERT INTO clientes VALUES (1, 'Francisco', 'C/San Luis 3', 948950789);
INSERT INTO clientes VALUES (3, 'Amaia Zubiri', 'C/Mayor 15', 948950901);
INSERT INTO clientes VALUES (4, 'Patricia Garcia', 'C/San Luis 3', 948950789);
INSERT INTO clientes VALUES (5, 'Jon Leizpig', 'C/Cuesta Labrit', 948950550);
INSERT INTO clientes VALUES (6, 'Jesus Lizae', null, null);
INSERT INTO clientes VALUES (111111, 'Carlos', 'C/mayor', 950950989);

SELECT * FROM clientes;

INSERT INTO articulos VALUES (111222, 15.30, 150, "Teclado ps2");
INSERT INTO articulos VALUES (111333, 499.00, 200, "Notebook A1");
INSERT INTO articulos VALUES (111444, 12.99, 100, "Altavoces E");
INSERT INTO articulos VALUES (123456, 10.50, 2350, "Raton Wireless");

SELECT * FROM articulos;

INSERT INTO compra VALUES (1, 123456, 1, "2015-10-21");
INSERT INTO compra VALUES (3, 111222, 23, "2015-11-21");
INSERT INTO compra VALUES (3, 123456, 2, "2015-11-21");
INSERT INTO compra VALUES (4, 111333, 1, "2015-10-21");
INSERT INTO compra VALUES (5, 111444, 5, "2015-12-21");