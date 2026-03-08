-- 1. Busqué el reporte del crimen ocurrido el 15 de enero de 2018 en SQL City.
-- En el reporte se indica la existencia de dos testigos del crimen.
SELECT *
FROM crime_scene_report
WHERE date = 20180115
AND city = 'SQL City'
AND type = 'murder';

-- 2. Búsqueda del primer testigo que vive en  Northwestern Dr según el reporte.
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC;

-- 3. Se revisa la entrevista del primer testigo para más pistas
SELECT *
FROM interview
WHERE person_id = 14887;      
              
-- 4. Búsqueda del segundo testigo llamada Annabel según el reporte.
SELECT *
FROM person
WHERE name LIKE 'Annabel%'
AND address_street_name = 'Franklin Ave';

-- 5. Se revisa la entrevista del segundo testigo.
SELECT *
FROM interview
WHERE person_id = 16371;

-- 6. Se busca en el Gym los miembros con membresía Gold y código que inicia en "48Z"
SELECT *
FROM get_fit_now_member
WHERE membership_status = 'gold'
AND id LIKE '48Z%';

-- 7. Se revisa la entrevista del sospechoso Jeremy Bowers.
SELECT *
FROM interview
WHERE person_id = 67318;

-- 8. Buscar el nombre de la persona que contrató al asesino Jeremy Bower.
-- Se hace la busqueda teniendo en cuenta las características físicas y el carro (Dados en la entrevista a Jeremy B).
SELECT *
FROM drivers_license
WHERE gender = 'female'
AND hair_color = 'red'
AND height BETWEEN 65 AND 67
AND car_make = 'Tesla'
AND car_model = 'Model S';        

-- 9. Búsqueda del nombre de la sospechosa quien contrató al asesinó.
SELECT *
FROM person
WHERE license_id IN (
    SELECT id
    FROM drivers_license
    WHERE gender = 'female'
    AND hair_color = 'red'
    AND height BETWEEN 65 AND 67
    AND car_make = 'Tesla'
    AND car_model = 'Model S'
);

-- 10. Búsqueda ID de la persona que haya asistido 3 veces en diciembre al concierto SQL Symphony Concert, según Jeremy Bower.
SELECT person_id, COUNT(*) as veces
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND date LIKE '201712%'
GROUP BY person_id
HAVING COUNT(*) = 3;

-- 11. Nombre de la persona y se haya que Miranda Priestly contrató al asesinó.
SELECT *
FROM person
WHERE id IN (
    SELECT person_id
    FROM facebook_event_checkin
    WHERE event_name = 'SQL Symphony Concert'
    AND date LIKE '201712%'
    GROUP BY person_id
    HAVING COUNT(*) = 3
);
