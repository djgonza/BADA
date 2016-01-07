DROP DATABASE Peliculas;

CREATE DATABASE Peliculas DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

use Peliculas;

CREATE TABLE director (
	ID int NOT NULL AUTO_INCREMENT,
	nombre varchar(255) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE pelicula (
	ID int NOT NULL AUTO_INCREMENT,
	caratula varchar(255) NOT NULL,
	duración int,
	vista boolean,
	año date,
	formato varchar(255),
	genero varchar(255),
	nacionalidad varchar(255),
	puntuación int,
	soporte varchar (255),
	titulo varchar (255),
	director int,
	PRIMARY KEY (ID),
	CONSTRAINT fk_director
	    FOREIGN KEY (director)
	    REFERENCES director (ID)
	    ON DELETE NO ACTION
	    ON UPDATE CASCADE
);

CREATE TABLE actor (
	ID int NOT NULL AUTO_INCREMENT,
	nombre varchar(255) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE actor_pelicula (
	Pelicula int NOT NULL,
	Actor int NOT NULL,
	CONSTRAINT fk_actor
    	FOREIGN KEY (actor)
    	REFERENCES actor (ID)
    	ON DELETE NO ACTION
    	ON UPDATE CASCADE,
    CONSTRAINT fk_pelicula
    	FOREIGN KEY (pelicula)
    	REFERENCES pelicula (ID)
    	ON DELETE NO ACTION
    	ON UPDATE CASCADE
);

/* directores */
INSERT INTO director VALUES (NULL, 'Kevin Smith.');
INSERT INTO director VALUES (NULL, 'Tom Fernández.');
INSERT INTO director VALUES (NULL, 'Marc Lawrence.');
INSERT INTO director VALUES (NULL, 'Ken Kwapis.');
INSERT INTO director VALUES (NULL, 'Antonio Mercero.');

/* actores */
INSERT INTO actor VALUES (NULL, 'Elizabeth Banks');
INSERT INTO actor VALUES (NULL, ' Seth Rogen');
INSERT INTO actor VALUES (NULL, ' Craig Robinson');
INSERT INTO actor VALUES (NULL, ' Gerry Bednob');
INSERT INTO actor VALUES (NULL, ' Jason Mewes');
INSERT INTO actor VALUES (NULL, ' Edward Janda');
INSERT INTO actor VALUES (NULL, ' Nicholas Lombardi');
INSERT INTO actor VALUES (NULL, ' Chris Milan');
INSERT INTO actor VALUES (NULL, ' Jennifer Schwalbach Smith');
INSERT INTO actor VALUES (NULL, ' Kenny Hotz');
INSERT INTO actor VALUES (NULL, ' Brandon Routh');
INSERT INTO actor VALUES (NULL, ' Anne Wade');
INSERT INTO actor VALUES (NULL, ' Justin Long');
INSERT INTO actor VALUES (NULL, ' Tom Savini');
INSERT INTO actor VALUES (NULL, ' Jeff Anderson.');
INSERT INTO actor VALUES (NULL, 'Geraldine Chaplin');
INSERT INTO actor VALUES (NULL, ' Oona Chaplin');
INSERT INTO actor VALUES (NULL, ' Javier Cámara');
INSERT INTO actor VALUES (NULL, ' Gonzalo de Castro');
INSERT INTO actor VALUES (NULL, ' Sira García');
INSERT INTO actor VALUES (NULL, ' Jesse Johnson');
INSERT INTO actor VALUES (NULL, ' Emma Suárez.');
INSERT INTO actor VALUES (NULL, 'Hugh Grant');
INSERT INTO actor VALUES (NULL, ' Sarah Jessica Parker');
INSERT INTO actor VALUES (NULL, ' Natalia Klimas');
INSERT INTO actor VALUES (NULL, ' Vincenzo Amato');
INSERT INTO actor VALUES (NULL, ' Jesse Liebman');
INSERT INTO actor VALUES (NULL, ' Elisabeth Moss');
INSERT INTO actor VALUES (NULL, ' Michael Kelly');
INSERT INTO actor VALUES (NULL, ' Seth Gilliam');
INSERT INTO actor VALUES (NULL, ' Sándor Técsy');
INSERT INTO actor VALUES (NULL, ' Kevin Brown');
INSERT INTO actor VALUES (NULL, ' Steven Boyer');
INSERT INTO actor VALUES (NULL, ' Sharon Wilkins');
INSERT INTO actor VALUES (NULL, ' Sam Elliott');
INSERT INTO actor VALUES (NULL, ' Mary Steenburgen');
INSERT INTO actor VALUES (NULL, ' Kim Shaw.');
INSERT INTO actor VALUES (NULL, 'Morgan Lily');
INSERT INTO actor VALUES (NULL, ' Trenton Rogers');
INSERT INTO actor VALUES (NULL, ' Michelle Carmichael');
INSERT INTO actor VALUES (NULL, ' Jasmine Woods');
INSERT INTO actor VALUES (NULL, ' Sabrina Revelle');
INSERT INTO actor VALUES (NULL, ' Zoe Jarman');
INSERT INTO actor VALUES (NULL, ' Alia Rhiana Eckerman');
INSERT INTO actor VALUES (NULL, ' Julia Pennington');
INSERT INTO actor VALUES (NULL, ' Renee Scott');
INSERT INTO actor VALUES (NULL, ' Chihiro Fujii');
INSERT INTO actor VALUES (NULL, ' Sachiko Ishida');
INSERT INTO actor VALUES (NULL, ' Claudia DiMartino');
INSERT INTO actor VALUES (NULL, ' Eve Curtis');
INSERT INTO actor VALUES (NULL, ' Carmen PerezTraycee King.');
INSERT INTO actor VALUES (NULL, 'Manuel Alexandre');
INSERT INTO actor VALUES (NULL, ' Cristina Brondo');
INSERT INTO actor VALUES (NULL, ' Monti Castiñeiras');
INSERT INTO actor VALUES (NULL, ' Cristina de Inza');
INSERT INTO actor VALUES (NULL, ' Álvaro de Luna');
INSERT INTO actor VALUES (NULL, ' José Luis López Vázquez');
INSERT INTO actor VALUES (NULL, ' Ángeles Macua');
INSERT INTO actor VALUES (NULL, ' Amparo Moreno');
INSERT INTO actor VALUES (NULL, ' Luis Ángel Priego');
INSERT INTO actor VALUES (NULL, ' Verónica Redondo Moreno');
INSERT INTO actor VALUES (NULL, ' Alejandro Zafra.');

/* peliculas */
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:82A0A094-5E43-4BDE-949D-37DA3F43BF79,1:37,1,2008,Public,Comedia,USA,7,Blu-Ray Screener,¿Hacemos Una Porno?,0,');
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:365D34B3-6B55-4BB6-AB68-8FA3E345DFC5,1:40,0,2011,Video Club 1,Comedia,España,null,DVD-Rip:Avi,¿Para Que Sirve Un Oso?,1,');
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:46CB1E1D-08CC-4D0B-89C0-DDBB33E99BE0,1:43,0,2009,Emetec,Comedia,USA,null,DVD-Rip:Avi,¿Qué Fue De Los Morgan?,2,');
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:97CF092A-D7F5-4043-9E03-08D5F9C07678,2:09,0,2008,Emetec,Comedia,USA,null,DVD-Rip:Avi,¿Que Les Pasa A Los Hombres?,3,');
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:45A7659C-8E5E-4DB8-B9CB-9C838A65D1B6,1:29,1,2007,DVD - R,Drama,España,7,DVD-Rip:Avi,¿Y Tu Quien Eres?,4,');

/* actores peliculas */
INSERT INTO actor_pelicula VALUES (0, '0');
INSERT INTO actor_pelicula VALUES (1, '0');
INSERT INTO actor_pelicula VALUES (2, '0');
INSERT INTO actor_pelicula VALUES (3, '0');
INSERT INTO actor_pelicula VALUES (4, '0');
INSERT INTO actor_pelicula VALUES (5, '0');
INSERT INTO actor_pelicula VALUES (6, '0');
INSERT INTO actor_pelicula VALUES (7, '0');
INSERT INTO actor_pelicula VALUES (8, '0');
INSERT INTO actor_pelicula VALUES (9, '0');
INSERT INTO actor_pelicula VALUES (10, '0');
INSERT INTO actor_pelicula VALUES (11, '0');
INSERT INTO actor_pelicula VALUES (12, '0');
INSERT INTO actor_pelicula VALUES (13, '0');
INSERT INTO actor_pelicula VALUES (14, '0');
INSERT INTO actor_pelicula VALUES (0, '1');
INSERT INTO actor_pelicula VALUES (1, '1');
INSERT INTO actor_pelicula VALUES (2, '1');
INSERT INTO actor_pelicula VALUES (3, '1');
INSERT INTO actor_pelicula VALUES (4, '1');
INSERT INTO actor_pelicula VALUES (5, '1');
INSERT INTO actor_pelicula VALUES (6, '1');
INSERT INTO actor_pelicula VALUES (0, '2');
INSERT INTO actor_pelicula VALUES (1, '2');
INSERT INTO actor_pelicula VALUES (2, '2');
INSERT INTO actor_pelicula VALUES (3, '2');
INSERT INTO actor_pelicula VALUES (4, '2');
INSERT INTO actor_pelicula VALUES (5, '2');
INSERT INTO actor_pelicula VALUES (6, '2');
INSERT INTO actor_pelicula VALUES (7, '2');
INSERT INTO actor_pelicula VALUES (8, '2');
INSERT INTO actor_pelicula VALUES (9, '2');
INSERT INTO actor_pelicula VALUES (10, '2');
INSERT INTO actor_pelicula VALUES (11, '2');
INSERT INTO actor_pelicula VALUES (12, '2');
INSERT INTO actor_pelicula VALUES (13, '2');
INSERT INTO actor_pelicula VALUES (14, '2');
INSERT INTO actor_pelicula VALUES (0, '3');
INSERT INTO actor_pelicula VALUES (1, '3');
INSERT INTO actor_pelicula VALUES (2, '3');
INSERT INTO actor_pelicula VALUES (3, '3');
INSERT INTO actor_pelicula VALUES (4, '3');
INSERT INTO actor_pelicula VALUES (5, '3');
INSERT INTO actor_pelicula VALUES (6, '3');
INSERT INTO actor_pelicula VALUES (7, '3');
INSERT INTO actor_pelicula VALUES (8, '3');
INSERT INTO actor_pelicula VALUES (9, '3');
INSERT INTO actor_pelicula VALUES (10, '3');
INSERT INTO actor_pelicula VALUES (11, '3');
INSERT INTO actor_pelicula VALUES (12, '3');
INSERT INTO actor_pelicula VALUES (13, '3');
INSERT INTO actor_pelicula VALUES (0, '4');
INSERT INTO actor_pelicula VALUES (1, '4');
INSERT INTO actor_pelicula VALUES (2, '4');
INSERT INTO actor_pelicula VALUES (3, '4');
INSERT INTO actor_pelicula VALUES (4, '4');
INSERT INTO actor_pelicula VALUES (5, '4');
INSERT INTO actor_pelicula VALUES (6, '4');
INSERT INTO actor_pelicula VALUES (7, '4');
INSERT INTO actor_pelicula VALUES (8, '4');
INSERT INTO actor_pelicula VALUES (9, '4');
INSERT INTO actor_pelicula VALUES (10, '4');




