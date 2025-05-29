USE aoe2_de;
-- Tests

-- Agregar Civ con Unidad Unica --

-- Caso malo
SELECT * FROM civilizaciones;
CALL Agregar_nueva_civ('Argentina', 'Recoleccion de comida de animales mas rapida', 'Gaucho','Caballeria Unica','18','2','120','0','0','0','0');
SELECT * FROM civilizaciones ORDER BY id DESC LIMIT 5;
SELECT * FROM unidades;
-- Caso bueno
CALL Agregar_nueva_civ('Argentina', 'Recoleccion de comida de animales mas rapida', 'Gaucho','Caballeria Unica','18','2','120','0','100','20','0');
SELECT * FROM civilizaciones ORDER BY id DESC LIMIT 5;
SELECT * FROM unidades;

-- Agregar Nueva Tecnologia --

-- Caso malo
SELECT * FROM tecnologias;
CALL Agregar_tecnologia('Muros Avanzados', 'Muros de Piedra tiene mas puntos de vida', '0', '0', '0', '0', '6');
SELECT * FROM tecnologias ORDER BY id DESC LIMIT 5;
-- Caso bueno
CALL Agregar_tecnologia('Muros Avanzados', 'Muros de Piedra tiene mas puntos de vida', '0', '0', '300', '200', '6');
SELECT * FROM tecnologias ORDER BY id DESC LIMIT 5;

-- Funcion Daño por recurso -
SELECT * FROM unidades;
SELECT id, nombre,`FN_damage_per_resource`(id) as 'Eficiencia por Recurso' FROM unidades;

-- Funcion Cantidad de Civilizaciones --
SELECT `FN_cantidad_civilizaciones`() as 'Cantidad de Civilizaciones:';

-- Vistas

SELECT * FROM vista_unidades_por_edificio;

SELECT * FROM vista_info_unidades;

SELECT * FROM vista_tecnologias_por_civilizacion;