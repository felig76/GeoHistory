CREATE DATABASE eventos_historicos;

USE eventos_historicos;

CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_corto VARCHAR(100) NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    fecha VARCHAR(25) NOT NULL,
    orden_relevancia INT NOT NULL,
    coordenadas VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    link VARCHAR(255) NOT NULL
);

INSERT INTO eventos (id, nombre_corto, nombre_completo, fecha, orden_relevancia, coordenadas, descripcion, link) VALUES
(1, "Batalla de Waterloo", "Batalla de Waterloo", "18/06/1815", 1, '4.4187, 50.6821', "La batalla que culminó con la derrota de Napoleón Bonaparte, poniendo fin a las Guerras Napoleónicas y marcando un cambio crucial en la historia de Europa.", "https://es.wikipedia.org/wiki/Batalla_de_Waterloo"),
(2, "Descubrimiento de América", "Primer viaje de Cristóbal Colón a América", "12/10/1492", 2, '-72.195689, 19.764901', "Cristóbal Colón llega al continente americano, un hito que transformó las relaciones entre Europa y las Américas y dio inicio a una nueva era de exploración.", "https://es.wikipedia.org/wiki/Descubrimiento_de_Am%C3%A9rica"),
(3, "Día D", "Desembarco de Normandía en la Segunda Guerra Mundial", "6/06/1944", 3, '-0.611642, 49.339818', "Las fuerzas aliadas desembarcan en las playas de Normandía en una de las operaciones más grandes de la Segunda Guerra Mundial, que resultó decisiva en la liberación de Europa del régimen nazi.", "https://es.wikipedia.org/wiki/Desembarco_de_Normand%C3%ADa"),
(4, "Caída del Muro de Berlín", "Caída del Muro de Berlín", "9/11/1989", 4, '13.4050, 52.5200', "La caída del Muro simbolizó el fin de la Guerra Fría, iniciando la reunificación de Alemania y marcando un cambio significativo en la política global.", "https://es.wikipedia.org/wiki/Ca%C3%ADda_del_Muro_de_Berl%C3%ADn"),
(5, "Llegada a la Luna", "Primera llegada del ser humano a la Luna (Misión Apolo 11)", "20/07/1969", 5, '-88.5832, 29.7274', "Neil Armstrong y Buzz Aldrin pisan la Luna, un logro monumental para la humanidad y un hito en la exploración espacial.", "https://es.wikipedia.org/wiki/Misi%C3%B3n_Apolo_11"),
(6, "Independencia de EE.UU.", "Declaración de Independencia de los Estados Unidos", "4/07/1776", 6, '-77.0369, 38.9072', "La declaración de independencia marcó el nacimiento de los Estados Unidos como una nación independiente y redefinió los conceptos de libertad y democracia.", "https://es.wikipedia.org/wiki/Declaraci%C3%B3n_de_Independencia_de_los_Estados_Unidos"),
(7, "Revolución Francesa", "Revolución Francesa", "14/07/1789 - 9/11/1799", 7, '2.3522, 48.8566', "Un levantamiento social y político que transformó profundamente a Francia, impactando la historia global con sus ideas de libertad, igualdad y derechos humanos.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_Francesa"),
(8, "Invención de la escritura", "Primera aparición de la escritura en Mesopotamia", "~3000 a.C.", 8, '47.489, 32.381', "La escritura se desarrolla en Mesopotamia, permitiendo la conservación del conocimiento y el avance de la civilización.", "https://es.wikipedia.org/wiki/Historia_de_la_escritura"),
(9, "Civilización del Indo", "Apogeo de la civilización del Valle del Indo", "2500 a.C.", 9, '70.000, 30.000', "Una de las primeras civilizaciones urbanas de Asia Meridional, conocida por su avanzada planificación y sistemas de ingeniería.", "https://es.wikipedia.org/wiki/Civilizaci%C3%B3n_del_Valle_del_Indo"),
(10, "Dinastía Han", "Comienzo de la Dinastía Han en China", "202 a.C.", 10, '104.1954, 35.8617', "Inicio de la Dinastía Han, una era de grandes desarrollos culturales, científicos y económicos en la antigua China.", "https://es.wikipedia.org/wiki/Dinast%C3%ADa_Han");