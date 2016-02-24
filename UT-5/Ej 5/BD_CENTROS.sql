-- ---------------------------------------------------
--  TABLAS PERSONAL, PROFESORES, CENTROS  -----------
-- ---------------------------------------------------
Create database centros;
use centros;

-- TABLA PERSONAL 

CREATE TABLE personal (
 cod_centro   SMALLINT NOT NULL,
 dni          INT UNSIGNED,
 apellidos    VARCHAR(30),
 funcion      VARCHAR(15),
 salario      FLOAT(7,2)
);

INSERT INTO personal VALUES (10,4123005, 'Gomez Bueno, Elisa', 'LIMPIADORA', 1200.00);
INSERT INTO personal VALUES (10,4122025, 'García García, Sabina', 'LIMPIADORA', 1200.00);
INSERT INTO personal VALUES (10,4480099, 'Ruano Cerezo, Manuel','ADMINISTRATIVO', 1800.00);
INSERT INTO personal VALUES (15,1002345, 'Albarrán Serrano, Alicia', 'ADMINISTRATIVO', 1800.00);
INSERT INTO personal VALUES (15,7002660, 'Muñoz Rey, Felicia', 'ADMINISTRATIVO', 1800.00);
INSERT INTO personal VALUES (22,5502678, 'Marín Marín, Pedro', 'ADMINISTRATIVO', 1800.00);
INSERT INTO personal VALUES (22,6600980, 'Peinado Gil, Elena','CONSERJE', 1750.00);
INSERT INTO personal VALUES (45,4163222, 'Sarro Molina, Carmen','CONSERJE', 1750.00);
INSERT INTO personal VALUES (22,1112345, 'Flores Pérez, Fernando','CONSERJE', 1300.00);


-- TABLA PROFESORES
CREATE TABLE profesores (
 cod_centro   SMALLINT NOT NULL,
 dni          INT UNSIGNED,
 apellidos    VARCHAR(30),
 especialidad VARCHAR(16) 
);


INSERT INTO profesores VALUES (10,1112345,'Martínez Salas, Fernando',  'INFORMÁTICA');
INSERT INTO profesores VALUES (10,4123005,'Bueno Zarco, Elisa', 'MATEMÁTICAS');
INSERT INTO profesores VALUES (10,4122025,'Montes García, M.Pilar', 'MATEMÁTICAS');
INSERT INTO profesores VALUES (15,9800990, 'Ramos Ruiz, Luis', 	'LENGUA');
INSERT INTO profesores VALUES (15,1112345,'Rivera Silvestre, Ana', 'DIBUJO');
INSERT INTO profesores VALUES (15,8660990, 'De Lucas Fdez, M.Angel',  'LENGUA');
INSERT INTO profesores VALUES (22,7650000, 'Ruiz Lafuente, Manuel',  'MATEMÁTICAS');
INSERT INTO profesores VALUES (45,43526789, 'Serrano Laguía, María','INFORMÁTICA');

-- TABLA CENTROS

CREATE TABLE centros (
 cod_centro   SMALLINT NOT NULL,
 tipo_centro  CHAR(1),
 nombre       VARCHAR(30),
 direccion    VARCHAR(26),
 telefono     VARCHAR(10),
 num_plazas   SMALLINT  UNSIGNED
 ) ;


INSERT INTO centros VALUES (10,'S','IES El Quijote','Avda. Los Molinos 25', '965-887654',538);
INSERT INTO centros VALUES (15,'P','CP Los Danzantes', 'C/Las Musas s/n','985-112322',250);
INSERT INTO centros VALUES (22,'S', 'IES Planeta Tierra', 'C/Mina 45','925-443400',300);
INSERT INTO centros VALUES (45,'P', 'CP Manuel Hidalgo', 'C/Granada 5','926-202310',220);
INSERT INTO centros VALUES (50,'S', 'IES Antoñete 1', 'C/Los Toreros 21','989-406090',310);
INSERT INTO centros VALUES (60,'P', 'CP Antoñete 2', 'C/Los Toreros 22','989-406092',300);
