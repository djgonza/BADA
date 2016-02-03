
-- Creación de la base de datos

CREATE DATABASE bd_empresa CHARACTER SET latin1 COLLATE latin1_spanish_ci;

-- Conexión a la base de datos
USE bd_empresa;

-- Eliminamos la tabla si existe
DROP TABLE IF EXISTS departamentos ;

-- Creamos la tabla departamentos
CREATE TABLE departamentos
(
    dept_no INTEGER,

	dnombre VARCHAR(30),

	loc VARCHAR(30),
	
	primary key (dept_no)
	)ENGINE = innoDB;

-- Eliminamos la tabla EMPLEADOs si existe
DROP TABLE IF EXISTS empleados ;

-- Creamos la tabla EMPLEADOs. La relación entre empleadoss y departamentos es 1:N
CREATE TABLE empleados(
	emp_no 	INTEGER NOT NULL,

	apellido VARCHAR(50) NOT NULL,
	
	oficio VARCHAR(30),
	
	director INTEGER,
	
	fecha_alta DATE,
	
	salario INTEGER,
	
	comision INTEGER,	
	
	dept_no INTEGER,
	
	PRIMARY KEY (emp_no),
	
	CONSTRAINT fk_emp_dept FOREIGN KEY (dept_no) REFERENCES departamentos(dept_no) ON DELETE NO ACTION ON UPDATE NO ACTION
	)ENGINE =innoDB;



-- Se insertan los datos en la tabla departamentos

INSERT INTO departamentos VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO departamentos VALUES (20,'INVESTIGACIÓN','MADRID');
INSERT INTO departamentos VALUES (30,'VENTAS','BARCELONA');
INSERT INTO departamentos VALUES (40,'PRODUCCIÓN','BILBAO');

-- Se insertan los datos en la tabla empleados
INSERT INTO empleados VALUES (7369,'SÁNCHEZ','EMPLEADO',7902,'1990-12-17',
                        1040,NULL,20);
INSERT INTO empleados VALUES (7499,'ARROYO','VENDEDOR',7698,'1990-02-20',
                        1500,390,30);
INSERT INTO empleados VALUES (7521,'SALA','VENDEDOR',7698,'1991-02-22',
                        1625,650,30);
INSERT INTO empleados VALUES (7566,'JIMÉNEZ','DIRECTOR',7839,'1991-04-02',
                        2900,NULL,20);
INSERT INTO empleados VALUES (7654,'MARTÍN','VENDEDOR',7698,'1991-09-29',
                        1600,1020,30);
INSERT INTO empleados VALUES (7698,'NEGRO','DIRECTOR',7839,'1991-05-01',
                        3005,NULL,30);
INSERT INTO empleados VALUES (7782,'CEREZO','DIRECTOR',7839,'1991-06-09',
                       2885,NULL,10);
INSERT INTO empleados VALUES (7788,'GIL','ANALISTA',7566,'1991-11-09',
                        3000,NULL,20);
INSERT INTO empleados VALUES (7839,'REY','PRESIDENTE',NULL,'1991-11-17',
                        4100,NULL,10);
INSERT INTO empleados VALUES (7844,'TOVAR','VENDEDOR',7698,'1991-09-08',
                        1350,0,30);
INSERT INTO empleados VALUES (7876,'ALONSO','EMPLEADO',7788,'1991-09-23',
                        1430,NULL,20);
INSERT INTO empleados VALUES (7900,'JIMENO','EMPLEADO',7698,'1991-12-03',
                        1335,NULL,30);
INSERT INTO empleados VALUES (7902,'FERNÁNDEZ','ANALISTA',7566,'1991-12-03',
                        3000,NULL,20);
INSERT INTO empleados VALUES (7934,'MUÑOZ','EMPLEADO',7782,'1992-01-23',
                        1690,NULL,10);