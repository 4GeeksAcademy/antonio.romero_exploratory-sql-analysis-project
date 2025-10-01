SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- **¿Cuáles son las primeras 10 observaciones registradas?**; 
select * from climate limit 10;

-- MISSION 2
-- **¿Qué identificadores de región (`region_id`) aparecen en los datos?**;
select distinct "region_id" from regions;

-- MISSION 3
-- **¿Cuántas especies distintas (`species_id`) se han observado?**;
select DISTINCT COUNT("species_id") from species;


-- MISSION 4
-- **¿Cuántas observaciones hay para la región con `region_id = 2`?**;
select COUNT("region_id")
from observations
where "region_id" = 2;


-- MISSION 5
-- **¿Cuántas observaciones se registraron el día `1998-08-08`?**;
select *
from observations
where observation_date = '1998-08-08'; 


-- MISSION 6
-- **¿Cuál es el `region_id` con más observaciones?**;
select count(region_id)
from observations
group by region_id;
 


-- MISSION 7
-- **¿Cuáles son los 5 `species_id` más frecuentes?**;
select *
from observations
group by species_id
order by species_id DESC
limit 5;


-- MISSION 8
-- **¿Qué especies (`species_id`) tienen menos de 5 registros?**;
select *
from observations
group by species_id
having count(species_id) < 5

--**¿Qué observadores (`observer`) registraron más observaciones?**;
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
--** Muestra el nombre de la región (regions.name) para cada observación.
select o.id, o.region_id, r.region_name
from observations as o
join regions as r on r.region_id = o.region_id;

--**11 -- Muestra el nombre científico de cada especie registrada
SELECT o.id as [observation_number], s.scientific_name
from observations as o
join species s on s.species_id = o.species_id;

--** 12. ¿Cuál es la especie más observada por cada región?
select 
    r.name, 
    s.scientific_name, 
    count(o.id) as total_observations
from observations o
join regions r on r.region_id = o.region_id
join species s on s.species_id = o.species_id
group by r.name, s.scientific_name
order by total_observations desc;