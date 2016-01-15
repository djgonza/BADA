CREATE DATABASE Mascotas DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

use Mascotas;

CREATE TABLE personas (
  dni VARCHAR(9) NOT NULL,
  nombre VARCHAR(255),
  telefono INT(9),
  direccion TEXT,
  PRIMARY KEY (dni)
) ENGINE = InnoDB;

CREATE TABLE datosMascotas (
  identificador INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255),
  fechaDeNacimiento DATE,
  raza VARCHAR(255),
  dni_persona VARCHAR(9),
  PRIMARY KEY (identificador),
  CONSTRAINT fk_persona
    FOREIGN KEY (dni_persona)
    REFERENCES personas (dni)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
) ENGINE = InnoDB;

DESCRIBE personas;
DESCRIBE datosMascotas;

INSERT INTO personas VALUES ('75835681B', 'Pepe', 658951245, 'Direccion del cliente');
INSERT INTO personas VALUES ("74586847A", "Manolo", 658951245, "Direccion del cliente");
INSERT INTO personas VALUES ("77458954R", "Sara", 655684855, "Direccion del cliente");
INSERT INTO personas VALUES ("86542126T", "Maria", 458756789, "Direccion del cliente");
INSERT INTO personas VALUES ("78456544O", "Pedro", 945623122, "Direccion del cliente");

SELECT * FROM personas;

INSERT INTO datosMascotas VALUES (null, "Gato de pepe", "1995-12-25", "Raza del gato", "75835681B");
INSERT INTO datosMascotas VALUES (null, "Gato de manolo", "2000-05-10", "Raza del gato", "74586847A");
INSERT INTO datosMascotas VALUES (null, "Gato de sara", "1995-12-08", "Raza del gato", "77458954R");
INSERT INTO datosMascotas VALUES (null, "Gato de maria", "2005-07-02", "Raza del gato", "86542126T");
INSERT INTO datosMascotas VALUES (null, "Gato de pedro", "2017-12-11", "Raza del gato", "78456544O");

SELECT * FROM datosMascotas;

SELECT * FROM personas WHERE dni LIKE "7_4%" (comienza por 7 el siguiente caracter vacio un 4 y el resto de la cadena)