use mi_bicing;

SELECT *
FROM estacions;


## Consultas sobre una tabla

-- 1. Obtener la lista de todas las categorías de personal con su nombre.
SELECT nom
FROM categoria_personal;

-- 2. Mostrar todos los usuarios con su nombre completo y correo electrónico.
SELECT concat_ws(" ", nom, cognom1, cognom2) as nom_cognoms, mail
FROM usuaris;

-- 3. Listar las estaciones con su nombre, distrito y número de anclajes.
SELECT nom as nom_estacio, districte_id, enclatges
FROM estacions;

-- 4. Obtener la lista de todas las tarifas con su nombre y precio.
SELECT nom_tarifa, preu
FROM tarifes;

-- 5. Mostrar las averías registradas con su nombre.
SELECT nom as nom_avaries
FROM avaries;

## Consultas sobre varias tablas (composición interna)

-- 1. Obtener el personal con su categoría y salario.
SELECT concat_ws(" ", P.nom, P.cognom1, P.cognom2) as nom_cognoms, CP.nom as categoria_personal, sou
FROM categoria_personal CP
JOIN personal P
ON P.CATEGORIA_PERSONAL_id = CP.id
JOIN salaris S
ON S.CATEGORIA_PERSONAL_id = CP.id;

-- 2. Listar los alquileres con la bicicleta, usuario y tarifa utilizada.
SELECT LL.id as lloguer_id, B.id as num_bici, CB.nom as tipus_bici, concat_ws(" ", U.nom, cognom1, cognom2) as usuari, nom_tarifa
FROM usuaris U
JOIN tarifes T
ON U.tarifa_id = T.id
JOIN bicicletes_has_lloguer BL
ON BL.USUARIS_id = U.id
JOIN lloguer LL
ON BL.LLOGUER_id = LL.id
JOIN bicicletes B
ON BL.BICICLETES_id = B.id
JOIN categoria_bici CB
ON B.categoria_bici_id = CB.id;


-- 3. Obtener el mantenimiento realizado a cada bicicleta con la avería y la fecha.
SELECT bicicleta_id, A.nom as avaries, date(data_inici_reparacio) as data_reparacio
FROM manteniment M
JOIN avaries A
ON M.avaria_id = A.id;

-- 4. Mostrar los usuarios con su tarifa y los alquileres realizados.
SELECT concat_ws(" ", U.nom, cognom1, cognom2) as usuari_nom, nom_tarifa, count(lloguer_id) as lloguers_totals
FROM usuaris U
JOIN tarifes T
ON U.tarifa_id = T.id
JOIN bicicletes_has_lloguer BL
ON U.id = BL.usuaris_id
group by usuari_nom
;

-- 5. Listar las estaciones con los alquileres realizados en cada una.
SELECT E.id as id_estacio, nom as nom_estacio, count(estacio_origen_id) as lloguers_origen, count(estacio_final_id) as lloguers_final
FROM lloguer L
JOIN estacions E
ON E.id = L.estacio_origen_id
group by 1, 2
order by 3 desc, 4 desc;

-- 6. Obtener el personal con su categoría, salario y las nóminas generadas.
SELECT concat_ws(" ", P.nom, cognom1, cognom2) as nom_treballador, CP.nom as categoria_laboral, sou, N.id as numero_nomina, date(data_nomina) as data_nomina
FROM personal P
JOIN categoria_personal CP
ON CP.id = P.categoria_personal_id
JOIN nomines N
ON P.id = N.personal_id
JOIN salaris S
on S.id = N.salaris_id;

-- 7. Mostrar las bicicletas con su categoría y los alquileres realizados.
SELECT B.id as numero_bici, CB.Nom as categoria_bici, count(lloguer_id) as lloguers_totals
FROM bicicletes B
JOIN bicicletes_has_lloguer BL
ON B.id = BL.bicicletes_id
JOIN categoria_bici CB
ON CB.id = B.categoria_bici_id
group by 1
order by lloguers_totals desc;

-- 8. Obtener los usuarios con su tarifa y las facturas generadas.
SELECT U.id as usuari_id, concat_ws(" ", U.nom, cognom1, cognom2) as nom_usuari, nom_tarifa, facturacio_id as num_factura
FROM usuaris U
JOIN tarifes T
ON T.id = U.tarifa_id
JOIN facturacio_has_usuaris FU
ON U.id = FU.usuaris_id
order by num_factura;

-- 9. Listar las estaciones con los distritos y las bicicletas disponibles en cada una.
SELECT E.id as num_estacio, E.nom as nom_estacio, districte_id, nom_districte, count(bicicletes_id) as total_bicicletes
FROM lloguer L
JOIN bicicletes_has_lloguer BL
ON L.id = BL.lloguer_id
JOIN estacions E
ON E.id = L.estacio_origen_id
JOIN districtes D
ON D.id = E.districte_id
group by nom_estacio;

-- 10. Obtener el personal con su categoría, salario y el distrito donde trabajan.
SELECT concat_ws(" ", P.nom, P.cognom1, P.cognom2) as nom_treballador, CP.nom as categoria_professional, sou, nom_districte
FROM personal P
JOIN categoria_personal CP ON CP.id = P.categoria_personal_id
JOIN salaris S ON CP.id = S.categoria_personal_id
JOIN districtes D ON D.id = P.districte_id;


## Consultas sobre varias tablas (composición externa)

-- 1. Obtener la lista de todas las categorías de personal con su nombre y los salarios asociados.
SELECT nom as categoria_personal, sou
FROM categoria_personal CP 
LEFT JOIN salaris S ON CP.id = S.categoria_personal_id;

-- 2. Mostrar todos los usuarios con su nombre completo, correo electrónico y las facturas generadas.
SELECT concat_ws(" ", U.nom, cognom1, cognom2) as nom_usuari, mail, facturacio_id as num_factura
FROM usuaris U
LEFT JOIN facturacio_has_usuaris FU ON U.id = FU.usuaris_id;

-- 3. Listar las estaciones con su nombre, distrito, número de anclajes y los alquileres realizados en cada una.
SELECT nom as nom_estacio, districte_id as num_districte, enclatges, count(estacio_origen_id) as total_origen, count(estacio_final_id) as total_final
FROM estacions E
LEFT JOIN lloguer L ON E.id = L.estacio_origen_id
group by 1
order by 4 desc, 5 desc;

-- 4. Obtener la lista de todas las tarifas con su nombre, precio y los usuarios asociados a cada una.
SELECT nom_tarifa, preu, concat_ws(" ", U.nom, cognom1, cognom2) as nom_usuari
FROM tarifes T
LEFT JOIN usuaris U ON U.tarifa_id = T.id;

-- 5. Mostrar las averías registradas con su nombre y los mantenimientos realizados para cada una.
SELECT A.*, count(M.id) as reparacions_totals
FROM avaries A
LEFT JOIN manteniment M ON A.id = M.avaria_id
group by 1;

-- 6. Obtener el personal con su categoría, salario y las nóminas generadas para cada uno.
SELECT concat_ws(" ", P.nom, cognom1, cognom2) as nom_treballador, CP.nom as categoria_professional, sou, N.id as num_nomina
FROM personal P
LEFT JOIN nomines N ON P.id = N.personal_id
LEFT JOIN categoria_personal CP ON P.categoria_personal_id = CP.id
RIGHT JOIN salaris S ON S.id = N.salaris_id;

-- 7. Mostrar las bicicletas con su categoría y los alquileres realizados con cada una.
SELECT B.id as num_bicicleta, CB.nom as categoria_bici, count(lloguer_id)
FROM bicicletes B
LEFT JOIN bicicletes_has_lloguer BL ON B.id = BL.bicicletes_id
LEFT JOIN categoria_bici CB ON CB.id = B.categoria_bici_id
group by 1;

-- 8. Obtener los usuarios con su tarifa, las facturas generadas y los alquileres realizados por cada uno.
SELECT concat_ws(" ", U.nom, cognom1, cognom2) as nom_usuari, facturacio_id, lloguer_id
FROM usuaris U
LEFT JOIN facturacio_has_usuaris FU ON FU.usuaris_id = U.id
LEFT JOIN bicicletes_has_lloguer BL ON U.id = BL.usuaris_id;

-- 9. Listar las estaciones con los distritos, las bicicletas disponibles en cada una y los alquileres realizados desde cada estación.
SELECT E.nom as nom_estacions, districte_id, nom_districte, count(B.id) as bicicletes_totals, count(L.id) as lloguers_totals
FROM estacions E
LEFT JOIN DISTRICTES D ON D.id = E.districte_id
LEFT JOIN lloguer L ON E.id = L.estacio_origen_id
LEFT JOIN bicicletes_has_lloguer BL ON L.id = BL.lloguer_id
LEFT JOIN bicicletes B ON B.id = BL.bicicletes_id
group by nom_estacions
ORDER BY bicicletes_totals DESC, lloguers_totals desc;

-- 10. Obtener el personal con su categoría, salario, las nóminas generadas y el distrito donde trabajan.
SELECT concat_ws(" ", P.nom, cognom1, cognom2) as nom_personal, CP.nom as categoria, sou, DATE(data_nomina) as data_nomina, districte_id, nom_districte
FROM personal P
left join categoria_personal CP ON CP.id = P.categoria_personal_id
left join nomines N on P.id = N.personal_id
left join salaris S ON S.id = N.salaris_id
left join districtes D ON D.id = P.districte_id;

## Consultas resumen

-- 1. Contar el número total de usuarios.
SELECT count(*) as usuaris_totals
FROM usuaris;

-- 2. Obtener el número de alquileres realizados por cada usuario.
SELECT concat_ws(" ", nom, cognom1, cognom2) as nom_usuari, count(lloguer_id) as lloguers_totals
FROM usuaris U
JOIN bicicletes_has_lloguer BL ON U.id = BL.usuaris_id
group by nom_usuari
order by lloguers_totals desc;

-- 3. Calcular el costo total de los alquileres realizados.
select sum(tarifa_minutatge) as cost_total_lloguers
from lloguer;

-- 4. Obtener la lista de estaciones ordenadas por número de anclajes.
SELECT nom
FROM estacions
order by enclatges desc;

-- 5. Contar el número de bicicletas disponibles en cada estación.
SELECT E.nom as nom_estacio, count(estacio_final_id) as total_bicis
-- , count(B.id) as total_bicis
FROM estacions E
JOIN lloguer L ON E.id = L.estacio_origen_id
-- JOIN bicicletes_has_lloguer BL ON L.id = BL.lloguer_id
-- JOIN bicicletes B ON B.id = BL.bicicletes_id
GROUP BY 1
order by 2 desc;

-- 6. Calcular el salario promedio del personal por categoría.
SELECT nom as categoria_personal, round(avg(sou), 0) as sou_promig
FROM categoria_personal CP
JOIN salaris S ON CP.id = S.categoria_personal_id
group by 1
order by 2 desc;

-- 7. Obtener la lista de usuarios con más alquileres realizados.
SELECT concat_ws(" ", nom, cognom1, cognom2) as nom_usuari, count(lloguer_id) as lloguers_realitzats
FROM usuaris U
JOIN bicicletes_has_lloguer BL ON U.id = BL.usuaris_id
group by 1
order by 2 desc;

-- 8. Calcular el número de mantenimientos realizados por cada categoría de bicicleta.
SELECT CB.nom as tipus_bici, count(avaria_id) as avaries_totals
FROM categoria_bici CB
JOIN bicicletes B ON CB.id = B.categoria_bici_id
JOIN manteniment M ON B.id = M.bicicleta_id
group by 1
order by 2 desc;

-- 9. Obtener la lista de estaciones con más alquileres realizados.
SELECT nom as nom_estacio, count(L.id) as lloguers_totals
FROM estacions E
JOIN lloguer L ON E.id = L.estacio_origen_id
group by 1
order by 2 desc;

-- 10. Calcular el número de nóminas generadas por cada categoría de personal.
SELECT nom as categoria_personal, count(N.id) as nomines_totals
FROM categoria_personal CP
join salaris S ON CP.id = S.categoria_personal_id
join nomines N ON S.id = N.salaris_id
group by 1
order by 2 desc;


## 2 o 3 Vistas
/*
Vista 1: Información general de usuarios y alquileres
Esta vista podría combinar información de las tablas USUARIS, LLOGUER y BICICLETES_has_LLOGUER para obtener un resumen de los usuarios 
y sus alquileres realizados. Algunos campos que podrías incluir:
Nombre y apellidos del usuario
Correo electrónico
Número total de alquileres realizados
Fecha del último alquiler
Bicicleta utilizada en el último alquiler
Estación de origen y destino del último alquiler
*/

CREATE VIEW usuaris_lloguers as
SELECT U.nom as nom, cognom1, cognom2, mail, count(L.id) as total_lloguers , max(fi_lloguer) as darrer_lloguer, bicicletes_id as bicicleta_id, 
	estacio_origen_id as origen_id, E1.nom as estacio_origen, estacio_final_id as final_id, E2.nom as estacio_final
FROM usuaris U
JOIN bicicletes_has_lloguer BL ON U.id = BL.usuaris_id
JOIN lloguer L ON L.id = BL.lloguer_id
JOIN estacions E1 ON E1.id = L.estacio_origen_id
JOIN estacions E2 ON E2.id = L.estacio_final_id
group by 1;


/*
Vista 2: Mantenimiento de bicicletas por categoría
Esta vista podría combinar información de las tablas BICICLETES, CATEGORIA_BICI, MANTENIMENT y AVARIES para obtener un resumen del 
mantenimiento realizado a las bicicletas agrupado por categoría. Algunos campos que podrías incluir:
Categoría de bicicleta
Número total de bicicletas por categoría
Número total de mantenimientos realizados
Avería más común en cada categoría
*/

CREATE VIEW bicicletes_manteniment as
SELECT CB.nom as categoria_bici, count(B.id) as total_bicis, count(M.id) as total_manteniment, A.nom as avaria_mes_usual
FROM manteniment M
JOIN avaries A ON A.id = M.avaria_id
JOIN bicicletes B ON B.id = M.bicicleta_id
JOIN categoria_bici CB ON CB.id = B.categoria_bici_id
group by 1
order by avaria_mes_usual desc;
