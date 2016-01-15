CREATE DATABASE ALUMNOS;

USE ALUMNOS;
--
-- TABLA NOTAS_ALUMNOS
--

CREATE TABLE NOTAS_ALUMNOS
 (
   nombre_alumno VARCHAR(25) NOT NULL ,
   nota1 TINYINT(2),
   nota2 TINYINT(2),
   nota3 TINYINT(2),
   asignatura VARCHAR(25),
   curso VARCHAR(4)
 );
 


--
-- TABLA ALUM2006
--


CREATE TABLE ALUM2006
(
  dni	        VARCHAR(10),
  nombre	VARCHAR(15),
  apellidos	VARCHAR(20),
  fecha_nac	DATE,
  direccion	VARCHAR(20),
  poblacion	VARCHAR(20),
  provincia	VARCHAR(20),
  curso	        INT(2),
  nivel	        VARCHAR(3),
  clase	        CHAR(1),
  faltas1	INT(2),
  faltas2	INT(2),
  faltas3	INT(2)
 ) ;






