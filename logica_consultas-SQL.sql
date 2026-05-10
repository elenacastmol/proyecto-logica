-- 1. Crea el esquema de la BBDD. Creado en .PNG. 

/* 2. Muestra los nombres de todas las películas con una clasificación 
 * por edades de ‘Rʼ*/

SELECT
     F.TITLE AS "pelicula", 
     F.RATING AS "categoria_edad"
FROM FILM AS F
WHERE F.RATING = 'R'
ORDER BY "pelicula" ;

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

SELECT A.ACTOR_ID, 
      concat (A.FIRST_NAME ,' ',A.LAST_NAME) AS "nombre_actor"
FROM  ACTOR AS A
WHERE A.ACTOR_ID BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT F.TITLE AS "titulo_pelicula",
       L."name" AS "idioma",
       F.ORIGINAL_LANGUAGE_ID AS "idioma_original"
FROM FILM AS F 
     INNER JOIN "language" AS L 
     ON F.LANGUAGE_ID = L.LANGUAGE_ID
WHERE L.LANGUAGE_ID = F.ORIGINAL_LANGUAGE_ID ;

/* No aparece resultados porque en la columna "idioma_original" no hay datos/ID. Todos NULL.
 * A continuación verificación*/

SELECT F.LANGUAGE_ID,
       l."name" AS "idioma",
       F.ORIGINAL_LANGUAGE_ID 
FROM FILM AS F 
     LEFT JOIN "language" AS L 
     ON F.LANGUAGE_ID = L.LANGUAGE_ID;

-- 5. Ordena las películas por duración de forma ascendente.

SELECT F.TITLE AS "titulo_pelicula",
       F.LENGTH AS "duracion"
FROM FILM AS F 
ORDER BY "duracion";

/* 6. Encuentra el nombre y apellido de los actores que tengan 
 * ‘Allenʼ en su apellido */

SELECT A.FIRST_NAME AS "nombre",
       A.LAST_NAME AS "apellido"         
FROM ACTOR AS A
WHERE A.LAST_NAME LIKE '%ALLEN%';

/* 7. Encuentra la cantidad total de películas en cada clasificación 
 * de la tabla “filmˮ y muestra la clasificación junto con el recuento */ 

SELECT F.RATING AS "clasificacion",
       count(F.FILM_ID ) AS "num_peliculas"     
FROM FILM AS F 
GROUP BY F.RATING ;

/* 8. Encuentra el título de todas las películas que son ‘PG-13ʼ 
 * o tienen una duración mayor a 3 horas en la tabla film.*/ 

SELECT F.TITLE AS "titulo_pelicula"
FROM FILM AS F 
WHERE F.RATING = 'PG-13' OR
F.LENGTH > 180;

-- Verificación:

SELECT F.TITLE AS "titulo_pelicula",
       F.RATING AS "clasificacion",
       F.LENGTH AS "duracion"
FROM FILM AS F 
WHERE F.RATING = 'PG-13' OR
F.LENGTH > 180
ORDER BY F.LENGTH;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas

SELECT ROUND(STDDEV(replacement_cost), 2) AS "variabilidad"
FROM film;

-- 10.  Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MAX(F.LENGTH )AS "duracion_maxima", 
       MIN(F.LENGTH )AS "duracion minima" 
FROM FILM AS F ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT p.amount AS "coste_alquiler",
       r.RENTAL_DATE AS "fecha_alquiler"
FROM rental r
     INNER JOIN payment p 
     ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC 
LIMIT 1
OFFSET 2;

-- Verificación:

SELECT p.amount AS "coste_alquiler",
       r.RENTAL_DATE 
FROM rental r
     INNER JOIN payment p 
     ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC;


/* El resultado de la consulta devuelve 0, entendiendo que la fecha del penúltimo registro y 
 * el dato de la fila 6 coinciden por algún motivo. Esto no se refleja correctamente, ya que, 
 * aunque aparentemente las fechas son iguales (‘2006-02-14 15:16:03.000’), 
 * puede existir alguna diferencia no visible en el formato o precisión. He revisado esta query 
 * varias veces y he llegado a esta conclusión, aunque es posible que esté cometiendo 
 * algún error en la query o en la interpretación de los datos.*/


/* 12. Encuentra el título de las películas en la tabla “filmˮ 
 * que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación */

SELECT F.TITLE AS "titulo_pelicula",
       F.RATING  AS "clasificacion"
FROM FILM AS F 
WHERE F.RATING NOT IN ('NC-17','G')
GROUP BY F.TITLE, F.RATING
ORDER BY "titulo_pelicula";


/* 13. Encuentra el promedio de duración de las películas para cada 
 * clasificación de la tabla film y muestra la clasificación 
 * junto con el promedio de duración */

SELECT F.RATING AS "clasificacion",
       round (avg(F.LENGTH),2) AS "promedio_duracion"
FROM FILM AS F 
GROUP BY F.RATING ;


/* 14. Encuentra el título de todas las películas que tengan una duración 
 * mayor a 180 minutos.*/

SELECT F.TITLE AS "titulo_pelicula",
       F.LENGTH AS "duracion"
FROM FILM AS F 
WHERE F.LENGTH > 180
GROUP BY F.TITLE ,F.LENGTH 
ORDER BY F.LENGTH ;


-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(P.AMOUNT) AS "total_ingresos"
FROM PAYMENT AS P ;


-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT C.CUSTOMER_ID AS "id_cliente",
       concat(C.FIRST_NAME ,' ', C.LAST_NAME ) AS "nombre_cliente"
FROM CUSTOMER AS C 
ORDER BY C.CUSTOMER_ID DESC
LIMIT 10;


/* 17. Encuentra el nombre y apellido de los actores 
 * que aparecen en la película con título ‘Egg Igbyʼ*/

SELECT concat(A.FIRST_NAME  , ' ' , A.LAST_NAME  ) AS "nombre_actor_actriz",
       F.TITLE AS "titulo_pelicula"
FROM FILM AS F 
     INNER JOIN FILM_ACTOR AS FA 
     ON F.FILM_ID = FA.FILM_ID 
     INNER JOIN ACTOR AS A 
     ON A.ACTOR_ID = FA.ACTOR_ID 
WHERE F.TITLE = 'EGG IGBY'
ORDER BY NOMBRE_ACTOR_ACTRIZ ;

/* Hubo una previa revisión de cómo estaba escrito el Titulo_Pelicula excatamente.
 * Se utiliza INNER JOIN dado que es necesario que haya coincidencia en ambas tablas
 */


-- 18. Selecciona todos los nombres de las películas únicos.

SELECT  DISTINCT (F.TITLE) AS "titulo_pelicula"
FROM FILM AS F 
ORDER BY TITULO_PELICULA ;

-- Resgistro únicos, no hay repetidos.


/* 19. Encuentra el título de las películas que son comedias y tienen una 
 * duración mayor a 180 minutos en la tabla “filmˮ */

SELECT F.TITLE AS "titulo_pelicula",
       C."name" AS "genero_pelicula",
       F.LENGTH AS "duracion"
FROM FILM AS F 
     INNER JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     INNER JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
WHERE c.name = 'Comedy' 
      AND F.LENGTH > 180
ORDER BY TITULO_PELICULA ;

-- Se utiliza INNER JOIN dado que es necesario que haya coincidencia en ambas tablas
-- Verificación del número de registros 'Comedy' = 58 

SELECT c.name AS "genero_pelicula",
        F.LENGTH AS "duracion"
FROM FILM AS F 
     INNER JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     INNER JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
WHERE c.name = 'Comedy' 
ORDER BY F.LENGTH desc;


/* 20. Encuentra las categorías de películas que tienen un promedio de 
 * duración superior a 110 minutos y muestra el nombre de la categoría junto 
 * con el promedio de duración */

SELECT  C."name" AS "genero_pelicula",
        round (AVG(F.LENGTH),2) AS "promedio_duracion" 
FROM FILM AS F 
     INNER JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     INNER JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID
GROUP BY C."name" 
HAVING AVG(F.LENGTH) > 110 
ORDER BY PROMEDIO_DURACION  DESC;

-- Verificación de todos los "genero_pelicula"

SELECT  C."name" AS "genero_pelicula",
        round (AVG(F.LENGTH),2) AS "promedio_duracion" 
FROM FILM AS F 
     INNER JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     INNER JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID
GROUP BY  C."name" 
ORDER BY PROMEDIO_DURACION  DESC ;


-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT round (AVG(F.RENTAL_DURATION),2) AS "prom._duracion_alquiler"
FROM FILM AS F ;


-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT concat(A.FIRST_NAME ,' ' ,A.LAST_NAME ) AS nombre_actor_actriz
FROM ACTOR AS A 
ORDER BY NOMBRE_ACTOR_ACTRIZ ;


/* 23. Números de alquiler por día, ordenados por cantidad de alquiler
 * de forma descendente.*/ 

SELECT date (rental_date) AS "fecha_alquiler", 
       COUNT(RENTAL_ID ) AS "num_alquiler"
FROM rental 
GROUP BY date  (rental_date) 
ORDER BY FECHA_ALQUILER asc;

-- Comprobación fecha específica

SELECT date (rental_date) AS "fecha_alquiler",
      RENTAL_ID 
FROM rental 
WHERE date (RENTAL_DATE )='2005-05-24'
GROUP BY RENTAL_ID , FECHA_ALQUILER;


-- 24. Encuentra las películas con una duración superior al promedio

SELECT F.title AS "titulo_pelicula",
       F.length AS "duracion"
FROM FILM F
WHERE F.length > (
          SELECT AVG(length)
          FROM FILM)
ORDER BY
     F.length;

-- Consulta Promedio

SELECT ROUND (AVG(F.LENGTH ),2) AS "promedio_duracion"
FROM FILM AS F ;

--25. Averigua el número de alquileres registrados por mes.

SELECT TO_CHAR(r.RENTAL_DATE, 'MM')AS mes,
       count(R.RENTAL_ID ) AS "num_alquileres"
FROM RENTAL AS R 
GROUP BY TO_CHAR(rental_date, 'MM')
ORDER BY mes;

--Verificación mes 02

SELECT TO_CHAR(r.RENTAL_DATE, 'MM')AS mes,
       R.RENTAL_ID AS "alquiler_id"
FROM RENTAL AS R 
WHERE TO_CHAR(r.RENTAL_DATE, 'MM') = '02'
GROUP BY TO_CHAR(rental_date, 'MM'),
         R.RENTAL_ID 
ORDER BY mes ;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT round (AVG(AMOUNT),2) AS "promedio_pagos",
       round (stddev(P.AMOUNT),2) AS "desv_estandar_pagos",
       round (variance(P.AMOUNT),2) AS "varianza_pagos"
FROM PAYMENT AS P ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?


SELECT f.title AS "titulo_pelicula",
       f.rental_rate AS "precio_alquiler"
FROM film f
WHERE f.rental_rate > (
                    SELECT AVG(rental_rate)  
                    FROM FILM AS F2)
GROUP BY f.TITLE , f.RENTAL_RATE 
ORDER BY PRECIO_ALQUILER ;  

-- Consulta promedio alquiler

SELECT AVG (F.RENTAL_RATE) AS "promedio_alquiler"
FROM FILM AS F ;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT FA.ACTOR_ID AS "id_actor_actriz",
       count(F.FILM_ID)AS "total_peliculas"
FROM FILM_ACTOR AS FA
     LEFT JOIN FILM AS F      
     ON FA.FILM_ID = F.FILM_ID 
GROUP BY FA.ACTOR_ID 
HAVING  count(F.FILM_ID)> 40
ORDER BY FA.ACTOR_ID ;

/* Se utiliza LEFT JOIN para sacar todos los id_actor y se cuenten las 
 * peliculas de cada id_actor que coincidan en la tabla de la derecha.
 * A continuación comprobación de total peliculas  de cada id_actor*/

SELECT FA.ACTOR_ID AS "id_actor_actriz",
       count(F.FILM_ID)AS "total_peliculas"
FROM FILM_ACTOR AS FA
     LEFT JOIN FILM AS F      
     ON FA.FILM_ID = F.FILM_ID 
GROUP BY FA.ACTOR_ID 
ORDER BY count(F.FILM_ID) desc;


/* 29. Obtener todas las películas y, si están disponibles en el inventario, 
 * mostrar la cantidad disponible */

SELECT F.FILM_ID  AS "id_pelicula",
       F.TITLE AS "titulo_pelicula",
       COUNT (I.FILM_ID ) AS "num_peliculas"
FROM FILM AS F 
     LEFT  JOIN INVENTORY AS I 
     ON I.FILM_ID =F.FILM_ID
GROUP BY f.FILM_ID 
ORDER BY F.FILM_ID;

/* Se utiliza LEFT JOIN, queremos todas las pelicula (tablas izquierda) 
 * y que nos indique las disponible en inventario aunque no tengan disponibilidad
 */


-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT concat(A.FIRST_NAME ,' ' ,A.LAST_NAME ) AS "actor_actriz",
       count(F.FILM_ID)AS "num_peliculas"
FROM ACTOR AS A 
     INNER JOIN FILM_ACTOR AS FA 
     ON A.ACTOR_ID = FA.ACTOR_ID 
     INNER JOIN FILM AS F     
     ON F.FILM_ID = FA.FILM_ID 
GROUP BY concat(A.FIRST_NAME ,' ' ,A.LAST_NAME )
ORDER BY "actor_actriz";

-- Consulta verificación de 'ADAM GRANT'  con 18 peliculas

SELECT concat(A.FIRST_NAME ,' ' ,A.LAST_NAME ) AS "actor",
       count(F.FILM_ID ) 
FROM ACTOR AS A 
     INNER JOIN FILM_ACTOR AS FA 
     ON A.ACTOR_ID = FA.ACTOR_ID 
     INNER JOIN FILM AS F     
     ON F.FILM_ID = FA.FILM_ID 
WHERE A.LAST_NAME = 'GRANT' 
GROUP BY  F.FILM_ID , A.ACTOR_ID    
ORDER BY F.FILM_ID ;


/* 31. Obtener todas las películas y mostrar los actores que han actuado en ellas,
 * incluso si algunas películas no tienen actores asociados */

SELECT F.TITLE AS "titulo_pelicula",
       CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME) AS "actor_actriz"
FROM FILM AS F
     LEFT JOIN FILM_ACTOR AS FA 
     ON F.FILM_ID = FA.FILM_ID
     LEFT JOIN ACTOR AS A 
     ON A.ACTOR_ID = FA.ACTOR_ID
ORDER BY "titulo_pelicula", "actor_actriz" ;


/* Se utiliza lEFT JOIN porque garantiza que todas las películas aparezcan, 
 * aunque no tengan actores.*/

-- Verificación películas sin actores:

SELECT DISTINCT f.film_id AS peliculas_sin_actores,
       f.TITLE 
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.film_id IS NULL;


/* 32. Obtener todos los actores y mostrar las películas en las que han actuado, 
 * incluso si algunos actores no han actuado en ninguna película*/

SELECT  CONCAT(a.first_name, ' ', a.last_name) AS "actor_actriz",
         f.title AS "titulo_pelicula"
FROM film AS f
     RIGHT JOIN film_actor AS fa
     ON f.film_id = fa.film_id
     RIGHT JOIN actor AS a
     ON fa.actor_id = a.actor_id
ORDER BY "actor_actriz" , "titulo_pelicula";


/* Se utiliza RIGHT JOIN  garantiza que todas los actores aparezcan, 
 * aunque no hayan actuado en ninguna pelicula, misma consulta anterior
 * pero con los datos principales de la tabla derecha.*/


-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT  R.RENTAL_ID AS "registros",
       F.TITLE AS "titulo_pelicula"      
FROM FILM AS F 
     FULL JOIN INVENTORY AS I 
     ON F.FILM_ID =I.FILM_ID 
     FULL JOIN RENTAL AS R 
     ON I.INVENTORY_ID = R.INVENTORY_ID;

-- FULL JOIN queremos obtener todos los resultados.


-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT  concat(C.FIRST_NAME ,' ', C.LAST_NAME) AS "nombre_cliente",
        ROUND (SUM(P.AMOUNT),2) AS "total_gastado"      
FROM PAYMENT AS P
     INNER JOIN CUSTOMER AS C 
     ON C.CUSTOMER_ID = P.CUSTOMER_ID 
GROUP BY concat(C.FIRST_NAME ,' ', C.LAST_NAME)
ORDER BY TOTAL_GASTADO DESC  
LIMIT 5;

-- Utilizamos INNER JOIN porque solo queremos los clientes con pago.


-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT A.FIRST_NAME AS "nombre",
       A.LAST_NAME AS "apellido"
FROM ACTOR AS A 
WHERE A.FIRST_NAME = 'JOHNNY'
GROUP BY A.FIRST_NAME, 
          A.LAST_NAME ;

-- Primero se ha revisado cómo estaba escrito el nombre


-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

SELECT A.FIRST_NAME AS "nombre",
       A.LAST_NAME AS "apellido"
FROM ACTOR AS A 
GROUP BY A.FIRST_NAME,
         A.LAST_NAME 
ORDER BY NOMBRE ;


-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN(A.ACTOR_ID ) AS "id_mas_bajo",
       MAX(A.ACTOR_ID ) AS "id_mas_alto"
FROM ACTOR AS A;

-- Verificación

SELECT A.ACTOR_ID 
FROM ACTOR AS A ;


-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT count(A.ACTOR_ID ) AS "num_actores"
FROM ACTOR AS A ;


-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT A.FIRST_NAME AS "nombre",
       A.LAST_NAME AS "apellido"
FROM ACTOR AS A 
GROUP BY A.FIRST_NAME, 
         A.LAST_NAME  
ORDER BY APELLIDO;


-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT F.TITLE AS "titulo_pelicula",
      F.FILM_ID AS "id_pelicula"
FROM FILM AS F 
ORDER BY ID_PELICULA 
LIMIT 5;

-- Verificación 

SELECT F.TITLE AS "titulo_pelicula",
       F.FILM_ID AS "id_pelicula"
FROM FILM AS F;


/* 41. Agrupa los actores por su nombre y cuenta cuántos actores 
 * tienen el mismo nombre. ¿Cuál es el nombre más repetido?*/

SELECT A.FIRST_NAME AS "nombre",
       count(A.ACTOR_ID ) AS "num_repeticiones"
FROM ACTOR AS A 
GROUP BY A.FIRST_NAME 
HAVING count(A.ACTOR_ID ) > 1
ORDER BY NUM_REPETICIONES desc ;

-- Los nombre más repetidos son Penelope, Kenneth y Julia

-- Verificación de uno de ello como por ejemplo Penelope

SELECT A.FIRST_NAME AS "nombre",
       A.ACTOR_ID AS "id_actor_actriz" 
FROM ACTOR AS A 
WHERE A.FIRST_NAME  = 'PENELOPE'
GROUP BY A.FIRST_NAME, A.ACTOR_ID ;


/* 42. Encuentra todos los alquileres y los nombres de los 
 * clientes que los realizaron.*/

SELECT concat(C.FIRST_NAME ,' ',C.LAST_NAME ) AS "nombre_cliente", 
       count(r.rental_id) AS "num.alquileres"
FROM  RENTAL AS R 
     INNER JOIN CUSTOMER AS C 
     ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY concat(C.FIRST_NAME ,' ',C.LAST_NAME ), C.CUSTOMER_ID 
ORDER BY nombre_cliente ;


/* 43. Muestra todos los clientes y sus alquileres si existen, 
 incluyendo aquellos que no tienen alquileres.*/


SELECT concat(C.FIRST_NAME ,' ',C.LAST_NAME ) AS "nombre_cliente", 
       count(r.rental_id) AS "num.alquileres"
FROM  CUSTOMER AS C
      LEFT JOIN RENTAL AS R 
     ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY concat(C.FIRST_NAME ,' ',C.LAST_NAME ), C.CUSTOMER_ID 
ORDER BY nombre_cliente ;

/* Utilizamos LEFT JOIN para mostrar todos los clientes tenga o no alquileres.
 * En este caso todos tiene alquileres*/

 
/* 44. Realiza un CROSS JOIN entre las tablas film y category. 
 ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta
 la contestación.*/

SELECT *
FROM FILM AS F 
     CROSS JOIN CATEGORY AS C ; 

/* No, no aporta valor, combina todas las filas de film con las de de category sin 
condición y sin una relación lógica.*/


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT C."name" AS "genero_pelicula",
       concat(A.FIRST_NAME ,' ', A.LAST_NAME ) AS "nombre_actor_actriz"
FROM CATEGORY AS C
     INNER JOIN FILM_CATEGORY AS FC  
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
     INNER JOIN FILM AS F 
     ON F.FILM_ID = FC.FILM_ID 
     INNER JOIN FILM_ACTOR AS FA 
     ON F.FILM_ID = FA.FILM_ID 
     INNER JOIN ACTOR AS A 
     ON A.ACTOR_ID = FA.ACTOR_ID
WHERE C."name" = 'Action'
GROUP BY C."name" , concat(A.FIRST_NAME ,' ', A.LAST_NAME )
ORDER BY "nombre_actor_actriz";


-- 46. Encuentra todos los actores que no han participado en películas.

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "nombre_actor_actriz"
FROM actor a
     LEFT JOIN film_actor fa 
     ON a.actor_id = fa.ACTOR_ID 
     LEFT JOIN FILM AS F 
     ON F.FILM_ID = fa.FILM_ID 
WHERE fa.ACTOR_ID  IS NULL;

-- Verificacion que todos los actores han participado en peliculas

SELECT 
    (SELECT COUNT(*) FROM actor) AS "total_actores",
    (SELECT COUNT(DISTINCT fa.actor_id) FROM film_actor fa) AS "actores_con_peliculas",
    CASE 
        WHEN (SELECT COUNT(*) FROM actor) = (SELECT COUNT(DISTINCT fa.actor_id) FROM film_actor fa)
        THEN 'Todos tienen películas'
        ELSE 'Algunos sin películas'
    END AS verificacion;

    
/* 47. Selecciona el nombre de los actores y la cantidad de películas 
 * en las que han participado.*/

SELECT concat(A.FIRST_NAME ,' ', A.LAST_NAME ) AS "nombre_actor_actriz",
       count(FA.FILM_ID ) AS "num_peliculas"
FROM ACTOR AS A 
     LEFT JOIN FILM_ACTOR AS FA  
     ON A.ACTOR_ID = FA.ACTOR_ID 
GROUP BY concat(A.FIRST_NAME ,' ', A.LAST_NAME ) 
ORDER BY nombre_actor_actriz ;


/* 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
 * de los actores y el número de películas en las que han participado.*/


CREATE VIEW “actor_num_peliculasˮ AS
SELECT concat(A.FIRST_NAME ,' ', A.LAST_NAME ) AS "nombre_actor_actriz",
       count(FA.FILM_ID ) AS "num_peliculas"
FROM ACTOR AS A 
     LEFT JOIN FILM_ACTOR AS FA  
     ON A.ACTOR_ID = FA.ACTOR_ID 
GROUP BY concat(A.FIRST_NAME ,' ', A.LAST_NAME ) 
ORDER BY nombre_actor_actriz ;


-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT  concat(C.FIRST_NAME ,' ', C.LAST_NAME) AS "nombre_cliente",
        count(R.RENTAL_ID ) AS "total_aquileres"
FROM RENTAL AS R 
     INNER JOIN CUSTOMER AS C 
     ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY concat(C.FIRST_NAME ,' ', C.LAST_NAME),
         C.CUSTOMER_ID
ORDER BY "total_aquileres" DESC;


-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT name AS "categoria",
       SUM(F.LENGTH) AS "duracion_total"
FROM CATEGORY AS C
     INNER JOIN FILM_CATEGORY AS FC 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
     INNER JOIN FILM AS F 
     ON F.FILM_ID = FC.FILM_ID 
WHERE C."name" = 'Action'
GROUP BY C."name";


/* 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ 
 * para almacenar el total de alquileres por cliente.*/

CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS "cliente",
       COUNT(r.rental_id) AS "total_alquileres"
FROM customer c
     LEFT JOIN rental r 
     ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Verificación 
SELECT * FROM cliente_rentas_temporal 
ORDER BY total_alquileres DESC
LIMIT 5;


/* 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene 
 * las películas que han sido alquiladas al menos 10 veces. */

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.film_id AS "id_pelicula",
       f.title AS "titulo",
       COUNT(r.rental_id) AS "total_alquileres"
FROM film f
     INNER JOIN inventory i 
     ON f.film_id = i.film_id
     INNER JOIN rental r 
     ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

-- Verificación (top 5 más alquiladas)

SELECT * FROM peliculas_alquiladas 
ORDER BY total_alquileres DESC
LIMIT 5;


/* 53. Encuentra el título de las películas que han sido alquiladas por el 
 * cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. 
 * Ordena los resultados alfabéticamente por título de película.*/

SELECT F.TITLE AS  "titulos",
       R.RETURN_DATE AS "fecha_devolucion" ,
       concat(C.FIRST_NAME ,' ',C.LAST_NAME) AS "cliente"
FROM FILM AS F 
     INNER JOIN INVENTORY AS I 
     ON F.FILM_ID = I.FILM_ID 
     INNER JOIN RENTAL AS R 
     ON I.INVENTORY_ID =R.INVENTORY_ID 
     INNER JOIN CUSTOMER AS C 
     ON C.CUSTOMER_ID = R.CUSTOMER_ID 
WHERE CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) = 'TAMMY SANDERS'      
      AND R.RETURN_DATE IS NULL
ORDER BY F.TITLE ASC;
         

/* 54. Encuentra los nombres de los actores que han actuado en al menos una 
 * película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
 * alfabéticamente por apellido.*/

SELECT concat(A.FIRST_NAME ,' ', A.LAST_NAME ) AS "nombre"
FROM CATEGORY AS C 
     INNER  JOIN FILM_CATEGORY AS FC 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
     INNER  JOIN FILM AS F 
     ON F.FILM_ID = FC.FILM_ID 
     INNER  JOIN FILM_ACTOR AS FA 
     ON F.FILM_ID = FA.FILM_ID 
     INNER JOIN ACTOR AS A 
     ON A.ACTOR_ID = FA.ACTOR_ID 
WHERE NAME ='Sci-Fi'
GROUP BY A.FIRST_NAME ,
         A.LAST_NAME 
HAVING COUNT(DISTINCT C.CATEGORY_ID ) >= 1
ORDER BY A.LAST_NAME asc ;

-- Verificacion: 

SELECT concat(A.FIRST_NAME ,' ', A.LAST_NAME ) AS "nombre",
       C."name"  AS "categoria",
       count(C.CATEGORY_ID) AS "numero_peliculas"
FROM CATEGORY AS C 
     INNER  JOIN FILM_CATEGORY AS FC 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
     INNER  JOIN FILM AS F 
     ON F.FILM_ID = FC.FILM_ID 
     INNER  JOIN FILM_ACTOR AS FA 
     ON F.FILM_ID = FA.FILM_ID 
     INNER JOIN ACTOR AS A 
     ON A.ACTOR_ID = FA.ACTOR_ID 
WHERE NAME ='Sci-Fi'
GROUP BY A.FIRST_NAME ,
         A.LAST_NAME,
         C.CATEGORY_ID 
HAVING COUNT(DISTINCT C.CATEGORY_ID ) >= 1
ORDER BY A.LAST_NAME asc ;


/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas
 * que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara 
 * por primera vez. Ordena los resultados alfabéticamente por apellido.*/

SELECT DISTINCT a.first_name, a.last_name AS "nombre_actor_actriz"
FROM actor a
     INNER JOIN film_actor fa 
     ON a.actor_id = fa.actor_id
     INNER JOIN film f 
     ON fa.film_id = f.film_id
     INNER JOIN inventory i 
     ON f.film_id = i.film_id
     INNER JOIN rental r 
     ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
     INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
     INNER JOIN film f2 ON i2.film_id = f2.film_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;

-- Verificación de primer alquiler de la pelicula Spartacus Cheaper:

 SELECT MIN(r2.rental_date), 
        f2.TITLE AS nombre_pelicula
    FROM rental r2
     INNER JOIN inventory i2 
     ON r2.inventory_id = i2.inventory_id
     INNER JOIN film f2 
     ON i2.film_id = f2.film_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
    GROUP BY f2.TITLE;

    
-- Verificación de los actores que actuaron en otras peliculas después de esa fecha de alquiler concreto:
    

SELECT DISTINCT a.first_name, a.last_name AS "nombre_actor_actriz",
               MIN(r.rental_date) AS fecha_primer_alquiler_pelicula  
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
    INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    INNER JOIN film f2 ON i2.film_id = f2.film_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY a.LAST_NAME,
         MIN(r.rental_date)  ;
    


/* 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna 
 * película de la categoría ‘Musicʼ.*/

SELECT DISTINCT concat(A.FIRST_NAME ,' ', A.LAST_NAME) AS "nombre"
FROM ACTOR AS A 
     LEFT JOIN FILM_ACTOR AS FA 
     ON A.ACTOR_ID = FA.ACTOR_ID 
     LEFT JOIN FILM AS F 
     ON F.FILM_ID = FA.FILM_ID 
     LEFT JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     LEFT JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
WHERE C."name" = 'Music'IS NOT NULL
ORDER BY concat(A.FIRST_NAME ,' ', A.LAST_NAME);

-- Verificación inlcuyendo categoría:

SELECT concat(A.FIRST_NAME ,' ', A.LAST_NAME) AS "nombre",
       C."name" AS "categoria"
FROM ACTOR AS A 
     LEFT JOIN FILM_ACTOR AS FA 
     ON A.ACTOR_ID = FA.ACTOR_ID 
     LEFT JOIN FILM AS F 
     ON F.FILM_ID = FA.FILM_ID 
     LEFT JOIN FILM_CATEGORY AS FC 
     ON F.FILM_ID = FC.FILM_ID 
     LEFT JOIN CATEGORY AS C 
     ON C.CATEGORY_ID = FC.CATEGORY_ID 
WHERE C."name" = 'Music'IS NOT NULL
ORDER BY concat(A.FIRST_NAME ,' ', A.LAST_NAME);


/* 57. Encuentra el título de todas las películas que fueron alquiladas 
 * por más de 8 días. */

SELECT F.TITLE AS "titulo"
FROM FILM AS F 
     INNER JOIN INVENTORY AS I 
     ON F.FILM_ID = I.FILM_ID 
     INNER JOIN RENTAL AS R 
     ON I.INVENTORY_ID = R.INVENTORY_ID 
     

/* 58. Encuentra el título de todas las películas que son de la misma categoría 
 * que ‘Animationʼ.*/
     

SELECT f.title AS "titulo", 
       c."name" AS "categoria"
FROM film f
     INNER JOIN film_category fc 
     ON f.film_id = fc.film_id
     INNER JOIN category c 
     ON fc.category_id = c.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;


 
/* 59. Encuentra los nombres de las películas que tienen la misma duración que la 
 * película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente
 *  por título de película.*/

SELECT title AS "titulo",
       LENGTH AS "duracion"
FROM film
WHERE length = (
               SELECT length
               FROM film
               WHERE title = 'DANCING FEVER'
)
ORDER BY  title, length;

 -- Verificacion duracion pelicula 'Dancing Fever'

SELECT length AS "duracion"
FROM film
WHERE title = 'DANCING FEVER';

 
/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas 
 * distintas. Ordena los resultados alfabéticamente por apellido.*/

SELECT concat(c.first_name,' ', c.last_name),
       COUNT(DISTINCT i.film_id) AS "num_peliculas"
FROM customer c
     INNER JOIN rental r 
     ON c.customer_id = r.customer_id
     INNER JOIN inventory i 
     ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;



/* 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra 
 * el nombre de la categoría junto con el recuento de alquileres.*/

SELECT c.name AS "categoria", 
       COUNT(r.rental_id) AS "total_alquileres"
FROM category c
     INNER JOIN film_category fc 
     ON c.category_id = fc.category_id
     INNER JOIN film f 
     ON fc.film_id = f.film_id
     INNER JOIN inventory i 
     ON f.film_id = i.film_id
     INNER JOIN rental r 
     ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY total_alquileres DESC;


-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c.name AS "categoria",
       COUNT(f.film_id) AS "num_peliculas",
       f.RELEASE_YEAR AS "año"
FROM category c
     INNER JOIN film_category fc 
     ON c.category_id = fc.category_id
     INNER JOIN film f 
     ON fc.film_id = f.film_id
     WHERE f.release_year = 2006
GROUP BY c.category_id, c.name, f.RELEASE_YEAR 
ORDER BY num_peliculas DESC;


-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT CONCAT(s.first_name, ' ', s.last_name) AS "trabajador",
       a.address AS "direccion_tienda"
FROM staff s
     CROSS JOIN store st
     INNER JOIN address a 
     ON st.address_id = a.address_id  
ORDER BY s.last_name, a.address;

-- Verificacion 
SELECT COUNT(*) AS "num_trabajadores"
FROM staff; 

SELECT COUNT(*) AS "num_tiendas"
FROM store;

SELECT COUNT(*) AS "num_combinaciones"
FROM staff 
CROSS JOIN store; 


/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra 
 * el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT c.customer_id AS "id_cliente",
       CONCAT(c.first_name, ' ', c.last_name) AS "cliente",
       COUNT(r.rental_id) AS "total_alquileres"
FROM customer c
     LEFT JOIN rental r 
     ON c.customer_id = r.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC, c.last_name;


