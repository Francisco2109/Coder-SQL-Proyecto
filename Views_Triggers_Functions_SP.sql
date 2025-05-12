USE aoe2_de;

-- Creacion de Procedimientos almacenados
-- 1. Este procedimiento permite agregar una nueva 'civilizacion' a la tabla civilizaciones.

DELIMITER //

CREATE PROCEDURE Agregar_nueva_civ (
    IN p_nombre_civilizacion VARCHAR(100),
    IN p_bonificacion TEXT,
    IN p_nombre_unidad VARCHAR(100),
    IN p_tipo_unidad VARCHAR(50),
    IN p_ataque INT,
    IN p_armadura INT,
    IN p_puntos_vida INT,
    IN p_coste_madera INT,
    IN p_coste_comida INT,
    IN p_coste_oro INT,
    IN p_coste_piedra INT
)
BEGIN
    INSERT INTO civilizaciones (nombre, bonificacion)
    VALUES (p_nombre_civilizacion, p_bonificacion);

    -- Obtenemos el ID de la civilización recién insertada
    SET @nuevo_id_civ = LAST_INSERT_ID();

    INSERT INTO unidades (
        nombre, tipo, ataque, armadura, puntos_vida,
        coste_madera, coste_comida, coste_oro, coste_piedra,
        civilizacion_id
    ) VALUES (
        p_nombre_unidad, p_tipo_unidad, p_ataque, p_armadura, p_puntos_vida,
        p_coste_madera, p_coste_comida, p_coste_oro, p_coste_piedra,
        @nuevo_id_civ
    );
END //

DELIMITER ;
-- Trigger para verificar que al agregar civilizaciones la suma de todos los recursos de sus unidades unicas sean mayor a cero

DELIMITER //

CREATE TRIGGER validar_coste_unidad
BEFORE INSERT ON unidades
FOR EACH ROW
BEGIN
    IF (NEW.coste_madera + NEW.coste_comida + NEW.coste_oro + NEW.coste_piedra) <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El coste total de la unidad debe ser mayor a cero.';
    END IF;
END //

DELIMITER ;

-- 2. Este procedimiento permite agregar una nueva tecnologia.

DELIMITER //

CREATE PROCEDURE Agregar_tecnologia (
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_coste_madera INT,
    IN p_coste_comida INT,
    IN p_coste_oro INT,
    IN p_coste_piedra INT,
    IN p_edificio_id INT
)
BEGIN
    INSERT INTO tecnologias (
        nombre, descripcion, coste_madera, coste_comida,
        coste_oro, coste_piedra, edificio_id
    ) VALUES (
        p_nombre, p_descripcion, p_coste_madera, p_coste_comida,
        p_coste_oro, p_coste_piedra, p_edificio_id
    );
END //

DELIMITER ;
-- Trigger para verificar que al agregar tecnologias la suma de todos sus recursos sean mayor a cero
DELIMITER //

CREATE TRIGGER validar_coste_tecnologia
BEFORE INSERT ON tecnologias
FOR EACH ROW
BEGIN
    IF (NEW.coste_madera + NEW.coste_comida + NEW.coste_oro + NEW.coste_piedra) <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El coste total de la tecnología debe ser mayor a cero.';
    END IF;
END //

DELIMITER ;
-- Funcion para calcular el daño por recurso invertido de una unidad (Lo puse en ingles para evitar pones la ñ)
DELIMITER //

CREATE FUNCTION FN_damage_per_resource(id_unidad INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ataque_val INT;
    DECLARE total_coste INT;

    SELECT ataque, 
           (coste_madera + coste_comida + coste_oro + coste_piedra)
    INTO ataque_val, total_coste
    FROM unidades
    WHERE id = id_unidad;

    IF total_coste > 0 THEN
        RETURN ataque_val / total_coste;
    ELSE
        RETURN NULL;
    END IF;
END //

DELIMITER ;
-- Funcion que calcula la cantidad de civilizaciones que hay
DELIMITER //

CREATE FUNCTION FN_cantidad_civilizaciones()
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM civilizaciones;

    RETURN total;
END //

DELIMITER ;

-- Creamos las Vistas

CREATE VIEW vista_unidades_por_civilizacion AS
SELECT 
    c.nombre AS civilizacion,
    u.nombre AS unidad,
    u.tipo,
    u.ataque,
    u.armadura,
    u.puntos_vida
FROM unidades u
LEFT JOIN civilizaciones c ON u.civilizacion_id = c.id;

CREATE VIEW vista_unidades_por_edificio AS
SELECT 
    e.nombre AS edificio,
    u.nombre AS unidad,
    u.tipo,
    u.ataque,
    u.armadura
FROM edificio_unidades eu
JOIN edificios e ON eu.edificio_id = e.id
JOIN unidades u ON eu.unidad_id = u.id;

CREATE VIEW vista_info_unidades AS
SELECT 
    u.nombre,
    u.tipo,
    u.ataque,
    u.armadura,
    u.puntos_vida,
    u.coste_madera,
    u.coste_comida,
    u.coste_oro,
    c.nombre AS civilizacion
FROM unidades u
LEFT JOIN civilizaciones c ON u.civilizacion_id = c.id;

CREATE VIEW vista_tecnologias_por_civilizacion AS
SELECT 
    c.nombre AS civilizacion,
    t.nombre AS tecnologia,
    t.descripcion,
    e.nombre AS edificio
FROM tecnologias_civilizacion tc
JOIN civilizaciones c ON tc.civilizacion_id = c.id
JOIN tecnologias t ON tc.tecnologia_id = t.id
JOIN edificios e ON t.edificio_id = e.id;