-- Crear la base de datos
CREATE DATABASE aoe2_de;
USE aoe2_de;

-- Tabla de Civilizaciones
CREATE TABLE civilizaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    bonificacion TEXT,
    unidad_unica VARCHAR(100)
);

-- Tabla de Unidades
CREATE TABLE unidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    ataque INT,
    armadura INT,
    puntos_vida INT,
    coste_madera INT DEFAULT 0,
    coste_comida INT DEFAULT 0,
    coste_oro INT DEFAULT 0,
    coste_piedra INT DEFAULT 0,
    civilizacion_id INT,
    FOREIGN KEY (civilizacion_id) REFERENCES civilizaciones(id),
    CHECK (
        (coste_madera + coste_comida + coste_oro + coste_piedra) > 0
    )
);

-- Tabla de Edificios
CREATE TABLE edificios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puntos_vida INT,
    coste_madera INT DEFAULT 0,
    coste_comida INT DEFAULT 0,
    coste_oro INT DEFAULT 0,
    coste_piedra INT DEFAULT 0
);

-- Tabla de Tecnologías
CREATE TABLE tecnologias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    coste_madera INT DEFAULT 0,
    coste_comida INT DEFAULT 0,
    coste_oro INT DEFAULT 0,
    coste_piedra INT DEFAULT 0,
    edificio_id INT,
    FOREIGN KEY (edificio_id) REFERENCES edificios(id)
);

-- Tabla de tecnologías disponibles por civilización
CREATE TABLE tecnologias_civilizacion (
    civilizacion_id INT,
    tecnologia_id INT,
    PRIMARY KEY (civilizacion_id, tecnologia_id),
    FOREIGN KEY (civilizacion_id) REFERENCES civilizaciones(id),
    FOREIGN KEY (tecnologia_id) REFERENCES tecnologias(id)
);

-- Tabla de unidades entrenables por edificio
CREATE TABLE edificio_unidades (
    edificio_id INT,
    unidad_id INT,
    PRIMARY KEY (edificio_id, unidad_id),
    FOREIGN KEY (edificio_id) REFERENCES edificios(id),
    FOREIGN KEY (unidad_id) REFERENCES unidades(id)
);

-- Insertar civilizaciones
INSERT INTO civilizaciones (nombre, bonificacion, unidad_unica) VALUES
('Aztecas', 'Infantería fuerte, monjes más eficaces', 'Guerrero Jaguar'),
('Británicos', 'Arqueros de tiro largo, centros urbanos más baratos', 'Arquero largo'),
('Bizantinos', 'Edificios más resistentes, unidades defensivas baratas', 'Catafracta'),
('Chinos', 'Comienzan con más aldeanos pero menos recursos', 'Chu Ko Nu'),
('Francos', 'Caballería poderosa, centros urbanos más baratos', 'Caballero con hacha'),
('Godos', 'Infantería barata y rápida de producir', 'Huscarle'),
('Japoneses', 'Infantería de ataque rápido, pesca eficiente', 'Samurái'),
('Mongoles', 'Arqueros a caballo veloces, cazadores eficientes', 'Mangudai'),
('Persas', 'Economía fuerte, elefantes de guerra', 'Elefante de guerra'),
('Sarracenos', 'Comercio eficiente, arqueros a camello', 'Mameluco'),
('Teutones', 'Unidades defensivas fuertes, monjes potentes', 'Caballero Teutón'),
('Turcos', 'Pólvora avanzada, oro abundante', 'Jenízaro'),
('Vikingos', 'Infantería más rápida, barcos económicos', 'Berserker'),
('Búlgaros', 'Infantería fuerte, herrería gratis', 'Konnik'),
('Cumanos', 'Desarrollan edificios únicos, movilidad temprana', 'Kipchak'),
('Lituanos', 'Bonificación por reliquias, caballería fuerte', 'Leitis'),
('Polacos', 'Caballería con escudo, economía basada en granjas', 'Obuch'),
('Burgundios', 'Tecnologías económicas tempranas', 'Caballero flamenco'),
('Sicilianos', 'Daño reducido, construyen donjons', 'Serjeant'),
('Bohemios', 'Pólvora y monjes mejorados', 'Hussite Wagon'),
('Hindustanis', 'Economía eficiente, unidades de pólvora avanzadas', 'Ghulam'),
('Dravídicos', 'Fuerza naval y elefantes únicos', 'Urumi Swordsman'),
('Bengalíes', 'Elefantes resistentes, monjes avanzados', 'Ratha'),
('Gurjaras', 'Economía de pastoreo, unidades montadas únicas', 'Shrivamsha Rider');

-- Insertar unidades únicas
INSERT INTO unidades (nombre, tipo, ataque, armadura, puntos_vida, coste_madera, coste_comida, coste_oro, coste_piedra, civilizacion_id) VALUES
('Guerrero Jaguar', 'Infantería única', 10, 2, 50, 0, 60, 30, 0, 1),
('Arquero largo', 'Arquería única', 6, 0, 40, 0, 0, 40, 0, 2),
('Catafracta', 'Caballería única', 12, 5, 150, 0, 0, 70, 0, 3),
('Chu Ko Nu', 'Arquería única', 8, 0, 45, 0, 0, 40, 0, 4),
('Caballero con hacha', 'Infantería única', 9, 2, 60, 0, 55, 20, 0, 5),
('Huscarle', 'Infantería única', 8, 6, 60, 0, 50, 30, 0, 6),
('Samurái', 'Infantería única', 8, 1, 60, 0, 60, 30, 0, 7),
('Mangudai', 'Arquería a caballo única', 8, 0, 50, 0, 0, 55, 0, 8),
('Elefante de guerra', 'Caballería única', 15, 1, 600, 0, 200, 75, 0, 9),
('Mameluco', 'Caballería a camello única', 9, 2, 85, 0, 0, 55, 0, 10),
('Caballero Teutón', 'Infantería única', 12, 2, 100, 0, 50, 50, 0, 11),
('Jenízaro', 'Infantería con pólvora única', 17, 1, 40, 0, 0, 60, 0, 12),
('Berserker', 'Infantería única', 18, 4, 62, 0, 0, 45, 0, 13),
('Konnik', 'Infantería única montada', 12, 2, 100, 0, 70, 30, 0, 14),
('Kipchak', 'Arquería a caballo única', 6, 0, 60, 0, 0, 50, 0, 15),
('Leitis', 'Caballería única', 12, 1, 100, 0, 70, 50, 0, 16),
('Obuch', 'Infantería única', 10, 2, 80, 0, 60, 40, 0, 17),
('Caballero flamenco', 'Infantería única', 11, 1, 70, 0, 60, 30, 0, 18),
('Serjeant', 'Infantería única', 8, 3, 60, 0, 60, 35, 0, 19),
('Hussite Wagon', 'Unidad con pólvora única', 12, 4, 150, 0, 0, 60, 0, 20),
('Ghulam', 'Infantería única anti-arqueros', 9, 1, 80, 0, 60, 30, 0, 21),
('Urumi Swordsman', 'Infantería única cargada', 7, 1, 60, 0, 60, 25, 0, 22),
('Ratha', 'Unidad híbrida de ataque a distancia', 10, 2, 90, 0, 0, 70, 0, 23),
('Shrivamsha Rider', 'Caballería con evasión', 8, 0, 65, 0, 60, 40, 0, 24);

-- Insertar edificios
INSERT INTO edificios (nombre, puntos_vida, coste_madera, coste_comida, coste_oro, coste_piedra) VALUES
('Cuartel', 1500, 175, 0, 0, 0),
('Galería de tiro con arco', 1200, 200, 0, 0, 0),
('Establo', 1500, 175, 0, 0, 0),
('Castillo', 4800, 0, 0, 0, 650),
('Monasterio', 900, 175, 0, 0, 0),
('Universidad', 1050, 200, 0, 0, 0),
('Taller de maquinaria de asedio', 1500, 200, 0, 0, 0),
('Centro urbano', 2400, 275, 0, 0, 100);

-- Insertar tecnologías
INSERT INTO tecnologias (nombre, descripcion, coste_madera, coste_comida, coste_oro, coste_piedra, edificio_id) VALUES
('Herrería', 'Permite mejorar armas y armaduras', 0, 100, 50, 0, 1),
('Balística', 'Mejora la puntería de arqueros', 300, 0, 175, 0, 2),
('Sangre fría', 'Mejora la armadura de caballería', 0, 100, 150, 0, 3),
('Química', 'Permite el uso de pólvora en unidades y edificios', 0, 300, 200, 0, 6),
('Teología', 'Reduce el tiempo de conversión de los monjes', 0, 200, 300, 0, 5),
('Masonería', 'Aumenta la resistencia de edificios', 0, 200, 100, 0, 6),
('Ingeniería de asedio', 'Aumenta el alcance de las armas de asedio', 0, 200, 200, 0, 7),
('Carretilla', 'Aumenta la capacidad de carga de los aldeanos', 0, 175, 50, 0, 8),
('Stirrups', 'Incrementa la velocidad de ataque de la caballería', 0, 200, 150, 0, 4),     -- Búlgaros
('Steppe Husbandry', 'Las unidades a caballo se crean más rápido', 0, 200, 100, 0, 4),    -- Cumanos
('Hill Forts', 'Más alcance para centros urbanos', 0, 300, 150, 0, 4),                    -- Lituanos
('Szlachta Privileges', 'Reduce coste de Leitis', 0, 300, 200, 0, 4),                    -- Polacos
('Burgundian Vineyards', 'Convierte comida en oro', 0, 600, 300, 0, 4),                 -- Burgundios
('First Crusade', 'Crea Caballeros flamencos gratis', 0, 400, 300, 0, 4),               -- Sicilianos
('Wagenburg Tactics', 'Reduce daño recibido por pólvora', 0, 300, 200, 0, 4),           -- Bohemios
('Shatagni', 'Mejora precisión y alcance de pólvora', 0, 400, 250, 0, 4),               -- Hindustanis
('Wootz Steel', 'Ignora armadura enemiga', 0, 400, 300, 0, 4),                          -- Dravídicos
('Paiks', 'Rathas disparan más rápido', 0, 350, 250, 0, 4),                             -- Bengalíes
('Kshatriyas', 'Unidades cuestan menos comida', 0, 400, 200, 0, 4);                     -- Gurjaras

-- Unidades comunes
INSERT INTO edificio_unidades (edificio_id, unidad_id) VALUES
(1, 1); -- Aldeano para el Centro Urbano 

-- Unidades únicas por civilización (4 es para Castillo)
INSERT INTO edificio_unidades (edificio_id, unidad_id) VALUES
(4, 2), -- Berserker
(4, 3), -- Arquero largo
(4, 4), -- Catafracta
(4, 5), -- Chu Ko Nu
(4, 6), -- Caballero con hacha
(4, 7), -- Huscarle
(4, 8), -- Samurái
(4, 9), -- Mangudai
(4, 10), -- Elefante de guerra
(4, 11), -- Mameluco
(4, 12), -- Caballero Teutón
(4, 13), -- Jenízaro
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(4, 24);

-- Relación de tecnologías disponibles por civilización
INSERT INTO tecnologias_civilizacion (civilizacion_id, tecnologia_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 2),
(3, 1), (3, 2),
(4, 1), (4, 2),
(5, 1), (5, 2),
(6, 1), (6, 2),
(7, 1), (7, 2),
(8, 1), (8, 2),
(9, 1), (9, 2),
(10, 1), (10, 2),
(11, 1), (11, 2),
(12, 1), (12, 2),
(13, 1), (13, 2);
INSERT INTO tecnologias_civilizacion (civilizacion_id, tecnologia_id) VALUES
(5, 3), -- Francos (id 5) Sangre fría (id 3)
(14, 9),
(15, 10),
(16, 11),
(17, 12),
(18, 13),
(19, 14),
(20, 15),
(21, 16),
(22, 17),
(23, 18),
(24, 19);

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
    u.coste_piedra,
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

-- Faltan todas las civilizaciones de DLCs estan son las civilizaciones que tenia el juego cuando salio



