ALTER TABLE personal DROP primary key;
ALTER TABLE personal ADD primary key (dni, cod_centro);

ALTER TABLE centros ADD primary key (cod_centro);
update profesores set dni = 1112348 where dni = 1112345 and cod_centro = 15;

ALTER TABLE profesores DROP primary key;
ALTER TABLE profesores ADD primary key (dni, cod_centro);


ALTER TABLE personal ADD 
foreign key (cod_centro) 
REFERENCES centros(cod_centro)
ON DELETE RESTRICT
on update cascade;

ALTER TABLE profesores DROP foreign key profesores_ibfk_1;

ALTER TABLE profesores ADD 
foreign key (cod_centro)
REFERENCES centros(cod_centro)
ON DELETE RESTRICT
on update cascade;

ALTER TABLE profesores
ADD sueldo int;

ALTER TABLE profesores
MODIFY sueldo double;

INSERT INTO profesores
VALUES (45,02456844,'Quiroga Martín, A. Isabel', 'INFORMÁTICA', 0);

INSERT INTO profesores
VALUES (22,23444800,'González Sevilla, Miguel A.', 'HISTORIA', 0);

INSERT INTO personal
(cod_centro, dni, apellidos, funcion, salario)
SELECT cod_centro, dni, apellidos, "PROFESORES", 1900 
FROM profesores;

INSERT INTO profesores
(apellidos, DNI, especialidad, cod_centro)
SELECT 'Guijarro Alía, Manuela', 28848110, 'INFORMÁTICA', cod_centro 
FROM personal
WHERE funcion = 'CONSERJE'
GROUP BY cod_centro
HAVING count(cod_centro) = 2;

UPDATE centros
SET direccion = 'C/Pilón 13', num_plazas = 295
WHERE cod_centro = 22;

UPDATE personal
SET cod_centro = (	
		SELECT cod_centro 
		from profesores 
		where especialidad = "INFORMÁTICA"
		group by cod_centro 
		HAVING count(*) = 2
) where funcion = "CONSERJE";

UPDATE centros
SET num_plazas = (
	num_plazas + 50
) WHERE cod_centro in (
	SELECT cod_centro from profesores where especialidad = "informatica"
	);

DELETE FROM centros
where cod_centro not in (
	SELECT cod_centro from profesores where especialidad = "informatica"
);

DELETE FROM personal
WHERE cod_centro not in (
	SELECT cod_centro from centros
);

DELETE FROM profesores
WHERE dni is null;

