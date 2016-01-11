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
	duración varchar(8),
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
);

/* directores */
INSERT INTO director VALUES (NULL, 'Kevin Smith.');
INSERT INTO director VALUES (NULL, 'Tom Fernández.');
INSERT INTO director VALUES (NULL, 'Marc Lawrence.');
INSERT INTO director VALUES (NULL, 'Ken Kwapis.');
INSERT INTO director VALUES (NULL, 'Antonio Mercero.');

/* actores */
INSERT INTO actor VALUES (NULL, 'Elizabeth Banks');
INSERT INTO actor VALUES (NULL, 'Seth Rogen');
INSERT INTO actor VALUES (NULL, 'Craig Robinson');
INSERT INTO actor VALUES (NULL, 'Gerry Bednob');
INSERT INTO actor VALUES (NULL, 'Jason Mewes');
INSERT INTO actor VALUES (NULL, 'Edward Janda');
INSERT INTO actor VALUES (NULL, 'Nicholas Lombardi');
INSERT INTO actor VALUES (NULL, 'Chris Milan');
INSERT INTO actor VALUES (NULL, 'Jennifer Schwalbach Smith');
INSERT INTO actor VALUES (NULL, 'Kenny Hotz');
INSERT INTO actor VALUES (NULL, 'Brandon Routh');
INSERT INTO actor VALUES (NULL, 'Anne Wade');
INSERT INTO actor VALUES (NULL, 'Justin Long');
INSERT INTO actor VALUES (NULL, 'Tom Savini');
INSERT INTO actor VALUES (NULL, 'Jeff Anderson.');
INSERT INTO actor VALUES (NULL, 'Geraldine Chaplin');
INSERT INTO actor VALUES (NULL, 'Oona Chaplin');
INSERT INTO actor VALUES (NULL, 'Javier Cámara');
INSERT INTO actor VALUES (NULL, 'Gonzalo de Castro');
INSERT INTO actor VALUES (NULL, 'Sira García');
INSERT INTO actor VALUES (NULL, 'Jesse Johnson');
INSERT INTO actor VALUES (NULL, 'Emma Suárez.');
INSERT INTO actor VALUES (NULL, 'Hugh Grant');
INSERT INTO actor VALUES (NULL, 'Sarah Jessica Parker');
INSERT INTO actor VALUES (NULL, 'Natalia Klimas');
INSERT INTO actor VALUES (NULL, 'Vincenzo Amato');
INSERT INTO actor VALUES (NULL, 'Jesse Liebman');
INSERT INTO actor VALUES (NULL, 'Elisabeth Moss');
INSERT INTO actor VALUES (NULL, 'Michael Kelly');
INSERT INTO actor VALUES (NULL, 'Seth Gilliam');
INSERT INTO actor VALUES (NULL, 'Sándor Técsy');
INSERT INTO actor VALUES (NULL, 'Kevin Brown');
INSERT INTO actor VALUES (NULL, 'Steven Boyer');
INSERT INTO actor VALUES (NULL, 'Sharon Wilkins');
INSERT INTO actor VALUES (NULL, 'Sam Elliott');
INSERT INTO actor VALUES (NULL, 'Mary Steenburgen');
INSERT INTO actor VALUES (NULL, 'Kim Shaw.');
INSERT INTO actor VALUES (NULL, 'Morgan Lily');
INSERT INTO actor VALUES (NULL, 'Trenton Rogers');
INSERT INTO actor VALUES (NULL, 'Michelle Carmichael');
INSERT INTO actor VALUES (NULL, 'Jasmine Woods');
INSERT INTO actor VALUES (NULL, 'Sabrina Revelle');
INSERT INTO actor VALUES (NULL, 'Zoe Jarman');
INSERT INTO actor VALUES (NULL, 'Alia Rhiana Eckerman');
INSERT INTO actor VALUES (NULL, 'Julia Pennington');
INSERT INTO actor VALUES (NULL, 'Renee Scott');
INSERT INTO actor VALUES (NULL, 'Chihiro Fujii');
INSERT INTO actor VALUES (NULL, 'Sachiko Ishida');
INSERT INTO actor VALUES (NULL, 'Claudia DiMartino');
INSERT INTO actor VALUES (NULL, 'Eve Curtis');
INSERT INTO actor VALUES (NULL, 'Carmen PerezTraycee King.');
INSERT INTO actor VALUES (NULL, 'Manuel Alexandre');
INSERT INTO actor VALUES (NULL, 'Cristina Brondo');
INSERT INTO actor VALUES (NULL, 'Monti Castiñeiras');
INSERT INTO actor VALUES (NULL, 'Cristina de Inza');
INSERT INTO actor VALUES (NULL, 'Álvaro de Luna');
INSERT INTO actor VALUES (NULL, 'José Luis López Vázquez');
INSERT INTO actor VALUES (NULL, 'Ángeles Macua');
INSERT INTO actor VALUES (NULL, 'Amparo Moreno');
INSERT INTO actor VALUES (NULL, 'Luis Ángel Priego');
INSERT INTO actor VALUES (NULL, 'Verónica Redondo Moreno');
INSERT INTO actor VALUES (NULL, 'Alejandro Zafra.');

/* peliculas */
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:82A0A094-5E43-4BDE-949D-37DA3F43BF79', '01:37:00', true, '2008-01-01', 'Public', 'Comedia', 'USA', 7, 'Blu-Ray Screener', '¿Hacemos Una Porno?', 1);
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:365D34B3-6B55-4BB6-AB68-8FA3E345DFC5', '01:40:00', false, '2011-01-01', 'Video Club 1', 'Comedia', 'España', null, 'DVD-Rip:Avi', '¿Para Que Sirve Un Oso?', 2);
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:46CB1E1D-08CC-4D0B-89C0-DDBB33E99BE0', '01:43:00', false, '2009-01-01', 'Emetec', 'Comedia', 'USA', null, 'DVD-Rip:Avi', '¿Qué Fue De Los Morgan?', 3);
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:97CF092A-D7F5-4043-9E03-08D5F9C07678', '02:09:00', false, '2008-01-01', 'Emetec', 'Comedia', 'USA', null, 'DVD-Rip:Avi', '¿Que Les Pasa A Los Hombres?', 4);
INSERT INTO pelicula VALUES (NULL, 'lib_dvd_importados:45A7659C-8E5E-4DB8-B9CB-9C838A65D1B6', '01:29:00', true, '2007-01-01', 'DVD - R', 'Drama', 'España', 7, 'DVD-Rip:Avi', '¿Y Tu Quien Eres?', 5);

/* actores peliculas */
INSERT INTO actor_pelicula VALUES (1, 1);
INSERT INTO actor_pelicula VALUES (1, 2);
INSERT INTO actor_pelicula VALUES (1, 3);
INSERT INTO actor_pelicula VALUES (1, 4);
INSERT INTO actor_pelicula VALUES (1, 5);
INSERT INTO actor_pelicula VALUES (1, 6);
INSERT INTO actor_pelicula VALUES (1, 7);
INSERT INTO actor_pelicula VALUES (1, 8);
INSERT INTO actor_pelicula VALUES (1, 9);
INSERT INTO actor_pelicula VALUES (1, 10);
INSERT INTO actor_pelicula VALUES (1, 11);
INSERT INTO actor_pelicula VALUES (1, 12);
INSERT INTO actor_pelicula VALUES (1, 13);
INSERT INTO actor_pelicula VALUES (1, 14);
INSERT INTO actor_pelicula VALUES (1, 15);
INSERT INTO actor_pelicula VALUES (2, 16);
INSERT INTO actor_pelicula VALUES (2, 17);
INSERT INTO actor_pelicula VALUES (2, 18);
INSERT INTO actor_pelicula VALUES (2, 19);
INSERT INTO actor_pelicula VALUES (2, 20);
INSERT INTO actor_pelicula VALUES (2, 21);
INSERT INTO actor_pelicula VALUES (2, 22);
INSERT INTO actor_pelicula VALUES (3, 23);
INSERT INTO actor_pelicula VALUES (3, 24);
INSERT INTO actor_pelicula VALUES (3, 25);
INSERT INTO actor_pelicula VALUES (3, 26);
INSERT INTO actor_pelicula VALUES (3, 27);
INSERT INTO actor_pelicula VALUES (3, 28);
INSERT INTO actor_pelicula VALUES (3, 29);
INSERT INTO actor_pelicula VALUES (3, 30);
INSERT INTO actor_pelicula VALUES (3, 31);
INSERT INTO actor_pelicula VALUES (3, 32);
INSERT INTO actor_pelicula VALUES (3, 33);
INSERT INTO actor_pelicula VALUES (3, 34);
INSERT INTO actor_pelicula VALUES (3, 35);
INSERT INTO actor_pelicula VALUES (3, 36);
INSERT INTO actor_pelicula VALUES (3, 37);
INSERT INTO actor_pelicula VALUES (4, 38);
INSERT INTO actor_pelicula VALUES (4, 39);
INSERT INTO actor_pelicula VALUES (4, 40);
INSERT INTO actor_pelicula VALUES (4, 41);
INSERT INTO actor_pelicula VALUES (4, 42);
INSERT INTO actor_pelicula VALUES (4, 43);
INSERT INTO actor_pelicula VALUES (4, 44);
INSERT INTO actor_pelicula VALUES (4, 45);
INSERT INTO actor_pelicula VALUES (4, 46);
INSERT INTO actor_pelicula VALUES (4, 47);
INSERT INTO actor_pelicula VALUES (4, 48);
INSERT INTO actor_pelicula VALUES (4, 49);
INSERT INTO actor_pelicula VALUES (4, 50);
INSERT INTO actor_pelicula VALUES (4, 51);
INSERT INTO actor_pelicula VALUES (5, 52);
INSERT INTO actor_pelicula VALUES (5, 53);
INSERT INTO actor_pelicula VALUES (5, 54);
INSERT INTO actor_pelicula VALUES (5, 55);
INSERT INTO actor_pelicula VALUES (5, 56);
INSERT INTO actor_pelicula VALUES (5, 57);
INSERT INTO actor_pelicula VALUES (5, 58);
INSERT INTO actor_pelicula VALUES (5, 59);
INSERT INTO actor_pelicula VALUES (5, 60);
INSERT INTO actor_pelicula VALUES (5, 61);
INSERT INTO actor_pelicula VALUES (5, 62);