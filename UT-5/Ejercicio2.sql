CREATE DATABASE test DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE test;

CREATE TABLE IF NOT EXISTS bloque_pisos (
  cod_zona NUMERIC(2) NOT NULL,
  calle VARCHAR(30),
  numero NUMERIC(3),
  piso NUMERIC(2),
  puerta CHAR(1),
  cp NUMERIC(5),
  metros NUMERIC(5),
  comentarios VARCHAR(60),
  dni VARCHAR(9),
  PRIMARY KEY (calle, numero, piso, puerta)
) ENGINE = InnoDB;