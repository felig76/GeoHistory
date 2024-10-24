CREATE DATABASE eventos_historicos;

USE eventos_historicos;

CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_corto VARCHAR(100) NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    orden_relevancia INT NOT NULL,
    coordenadas VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    link VARCHAR(255) NOT NULL
);

INSERT INTO eventos (nombre_corto, nombre_completo, fecha_inicio, fecha_fin, orden_relevancia, coordenadas, descripcion, link) 
VALUES 
('Batalla de Waterloo', 'Batalla de Waterloo', '1815-06-18', NULL, 1, '4.4187,50.6821', 'Ocurrió en 1815, poniendo fin a las guerras napoleónicas.', 'https://es.wikipedia.org/wiki/Batalla_de_Waterloo'),
('Descubrimiento de América', 'Descubrimiento de América', '1492-10-12', NULL, 2, '-72.195689,19.764901', 'Cristóbal Colón llega a América en 1492.', 'https://es.wikipedia.org/wiki/Descubrimiento_de_Am%C3%A9rica'),
('Desembarco de Normandía', 'Desembarco de Normandía', '1944-06-06', NULL, 3, '-0.611642,49.339818', 'Desembarco de Normandía en 1944 durante la Segunda Guerra Mundial.', 'https://es.wikipedia.org/wiki/Desembarco_de_Normand%C3%ADa'),
('Caída del Muro de Berlín', 'Caída del Muro de Berlín', '1989-11-09', NULL, 4, '13.4050,52.5200', 'El Muro de Berlín cayó, simbolizando el fin de la Guerra Fría.', 'https://es.wikipedia.org/wiki/Ca%C3%ADda_del_Muro_de_Berl%C3%ADn'),
('Primera Luna', 'Primera llegada del ser humano a la Luna', '1969-07-20', NULL, 5, '-88.5832,29.7274', 'Neil Armstrong y Buzz Aldrin pisan la Luna durante la misión Apolo 11.', 'https://es.wikipedia.org/wiki/Misi%C3%B3n_Apolo_11'),
('Independencia de los Estados Unidos', 'Declaración de Independencia de los Estados Unidos', '1776-07-04', NULL, 6, '-77.0369,38.9072', 'Los Estados Unidos declaran su independencia del Reino Unido.', 'https://es.wikipedia.org/wiki/Declaraci%C3%B3n_de_Independencia_de_los_Estados_Unidos'),
('Revolución Francesa', 'Revolución Francesa', '1789-07-14', '1799-11-09', 7, '2.3522,48.8566', 'Un conflicto social y político que transformó Francia.', 'https://es.wikipedia.org/wiki/Revoluci%C3%B3n_Francesa');