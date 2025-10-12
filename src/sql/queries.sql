SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- **¿Cuáles son las primeras 10 observaciones registradas?**; 
select * from observations limit 10;

-- MISSION 2
-- **¿Qué identificadores de región (`region_id`) aparecen en los datos?**;
select distinct "region_id" from observations;

-- MISSION 3
-- **¿Cuántas especies distintas (`species_id`) se han observado?**;
select COUNT(DISTINCT species_id) from observations;


-- MISSION 4
-- **¿Cuántas observaciones hay para la región con `region_id = 2`?**;
select COUNT("region_id")
from observations
where "region_id" = 2;


-- MISSION 5
-- **¿Cuántas observaciones se registraron el día `1998-08-08`?**;
select COUNT(*)
from observations
where observation_date = '1998-08-08'; 


-- MISSION 6
-- **¿Cuál es el `region_id` con más observaciones?**;
select region_id, count(*) as total
from observations
group by region_id
order by total desc
limit 1;
 


-- MISSION 7
-- **¿Cuáles son los 5 `species_id` más frecuentes?**;
select species_id, count(*) as frecuencia
from observations
group by species_id
order by frecuencia desc
limit 5;


-- MISSION 8
-- **¿Qué especies (`species_id`) tienen menos de 5 registros?**;
select species_id, count(*) as registros
from observations
group by species_id
having count(species_id) < 5;

--**9¿Qué observadores (`observer`) registraron más observaciones?**;
select observer, count(*) as total_observations
from observations
group by observer
having count(*) = (
    select max(cnt)
    from (
        select count(*) as cnt
        from observations
        group by observer
    ) AS total
);
--**10 Muestra el nombre de la región (regions.name) para cada observación.
select o.id, o.region_id, r.name
from observations as o
join regions as r on r.id = o.region_id;

--**11 -- Muestra el nombre científico de cada especie registrada
SELECT o.id as [observation_number], s.scientific_name
from observations as o
join species s on s.species_id = o.species_id;

--** 12. ¿Cuál es la especie más observada por cada región?
CREATE TEMP VIEW species_counts AS
SELECT 
    r.name AS region_name,
    s.scientific_name,
    COUNT(o.id) AS observations
FROM observations o
JOIN regions r ON r.id = o.region_id
JOIN species s ON s.id = o.species_id
GROUP BY r.name, s.scientific_name;

CREATE TEMP VIEW max_by_region AS
SELECT 
    region_name,
    MAX(observations) AS max_observations
FROM species_counts
GROUP BY region_name;

SELECT 
    sc.region_name,
    sc.scientific_name,
    sc.observations
FROM species_counts sc
JOIN max_by_region mbr ON sc.region_name = mbr.region_name 
                      AND sc.observations = mbr.max_observations
ORDER BY sc.observations DESC;