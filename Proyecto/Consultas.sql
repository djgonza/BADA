# 1 consulta con group by
# buscamos cuantas peliculas tenemos por nacionalidad
SELECT COUNT(*) FROM pelicula GROUP BY nacionalidad;

# 1 consulta con order by + limit
# buscamos las 5 peliculas mas recientes
SELECT * FROM pelicula ORDER BY año DESC limit 5;

# 1 consulta con alguna forma de join
# buscamos todas las peliculas con sus directores
SELECT * FROM pelicula p INNER JOIN director d ON p.director = d.id;

# 1 consulta con subconsulta
# buscamos todas las peliculas de los directores cuyo nombre empieze por Kevin
SELECT * FROM pelicula WHERE director in (SELECT ID FROM director WHERE nombre LIKE 'Kevin%');

# 1 consulta con alguna función (de fecha, cadenas)
# buscamos el titulo de las peliculas con su duracion
SELECT concat(titulo, ' (', duración, ')') FROM pelicula;

# 1 consulta con función de agregado

# 1 actualización para todos los datos
# ponemos todas las puntuciones de las peliculas a 0
UPDATE pelicula SET puntuación = 0;

# 1 actualización con subconsulta
# cambiamos todas las pe
# UPDATE pelicula SET nacionalidad = 'EEUU' WHERE nacionalidad = 'USA'


# 1 borrado para toda una tabla
# borramos toda la relacion entre actores y peliculas
DELETE FROM actor_pelicula;

# 1 borrado para unos determinados registros.
# Borramos todas las peliculas que sean comedia
DELETE FROM pelicula WHERE genero = 'Comedia'


