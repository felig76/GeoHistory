DROP DATABASE IF EXISTS eventos_historicos;

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

DELIMITER //

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_coordenadas`
BEFORE INSERT ON `eventos`
FOR EACH ROW
BEGIN
    DECLARE longitud FLOAT;
    DECLARE latitud FLOAT;
    DECLARE orden_relevancia INT;
    SET longitud = CAST(SUBSTRING_INDEX(NEW.coordenadas, ',', 1) AS FLOAT);
    SET latitud = CAST(SUBSTRING_INDEX(NEW.coordenadas, ',', -1) AS FLOAT);
    SET orden_relevancia = NEW.orden_relevancia;

    IF longitud < -180 OR longitud > 180 OR latitud < -90 OR latitud > 90 THEN
        SET longitud = 0.0000;
        SET latitud = 0.0000;
        SET NEW.coordenadas = CONCAT(CAST(latitud AS CHAR), ',', CAST(longitud AS CHAR));
        SET NEW.nombre_corto = CONCAT(NEW.nombre_corto, ' (coordenadas incorrectas)');
    END IF;

    IF orden_relevancia < 1 OR orden_relevancia > 20 THEN
        SET NEW.orden_relevancia = 5;
    END IF;
END//

DELIMITER ;


CREATE PROCEDURE `consultar_eventos`() NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER SELECT * FROM eventos;

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
(10, "Dinastía Han", "Comienzo de la Dinastía Han en China", "202 a.C.", 10, '104.1954, 35.8617', "Inicio de la Dinastía Han, una era de grandes desarrollos culturales, científicos y económicos en la antigua China.", "https://es.wikipedia.org/wiki/Dinast%C3%ADa_Han"),
(11, "Independencia de Madagascar", "Madagascar se convierte en un país independiente de Francia", "26/06/1960", 1, '46.8691, -18.7669', "La independencia de Madagascar marcó el fin de un largo periodo de colonización francesa.", "https://es.wikipedia.org/wiki/Independencia_de_Madagascar"),
(12, "Independencia de Papua Nueva Guinea", "Papua Nueva Guinea se independiza de Australia", "16/09/1975", 2, '144.2687, -6.3145', "El país se convierte en un estado independiente tras años de tutela australiana.", "https://es.wikipedia.org/wiki/Independencia_de_Papua_Nueva_Guinea"),
(13, "Batalla de Isandlwana", "Conflicto entre el ejército británico y los zulúes", "22/01/1879", 3, '30.7922, -28.4333', "Una de las principales batallas de la Guerra Anglo-Zulú que resultó en una victoria zulú.", "https://es.wikipedia.org/wiki/Batalla_de_Isandlwana"),
(14, "Cruzada de las mujeres", "Cruzada de mujeres para liberar Jerusalén", "1147", 4, '35.2137, 31.7683', "Un evento único en la historia, donde un grupo de mujeres tomó la iniciativa de luchar por la liberación de Jerusalén.", "https://es.wikipedia.org/wiki/Cruzadas"),
(15, "Descubrimiento de la Isla de Pascua", "Descubrimiento de Rapa Nui por los europeos", "5/04/1722", 5, '-109.3497, -27.1212', "La llegada de los europeos a la remota Isla de Pascua, conocida por sus moáis.", "https://es.wikipedia.org/wiki/Isla_de_Pascua"),
(16, "Revolución de Argelia", "Lucha por la independencia de Argelia de Francia", "1954 - 1962", 6, '3.0588, 36.7538', "Un conflicto que resultó en la independencia de Argelia tras años de colonización francesa.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_argelina"),
(17, "Guerra del Opio", "Conflicto entre China y Gran Bretaña", "1839 - 1842", 7, '104.1954, 35.8617', "Un conflicto que marcó el inicio de la intervención europea en China y el comercio de opio.", "https://es.wikipedia.org/wiki/Guerra_del_Opio"),
(18, "Revolución de los Claveles", "Revolución pacífica en Portugal", "25/04/1974", 8, '-9.1394, 38.7223', "Un levantamiento que terminó con la dictadura en Portugal sin derramamiento de sangre.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_de_los_Claveles"),
(19, "Descubrimiento del fuego", "Control del fuego por los humanos", "~1.000.000 a.C.", 9, '0.0000, 0.0000', "Un avance crucial para la humanidad que permitió la cocción de alimentos y protección.", "https://es.wikipedia.org/wiki/Historia_del_fuego"),
(20, "Invención del papel", "Invención del papel en China", "~105 d.C.", 10, '123.1954, 55.8617', "Un avance significativo que revolucionó la comunicación y el registro de información.", "https://es.wikipedia.org/wiki/Papel"),
(21, "Guerra Civil Americana", "Conflicto entre los estados del norte y del sur de EE.UU.", "1861 - 1865", 1, '-95.7129, 37.0902', "Un conflicto que determinó el futuro de la esclavitud y la unión del país.", "https://es.wikipedia.org/wiki/Guerra_Civil_de_los_Estados_Unidos"),
(22, "Revolución Mexicana", "Movimientos armados para derrocar a la dictadura de Porfirio Díaz", "1910 - 1920", 2, '-102.5528, 23.6345', "Una serie de luchas políticas y sociales que transformaron a México.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_Mexicana"),
(23, "La Gran Depresión", "Crisis económica mundial", "1929 - 1939", 3, '-97.7431, 30.2672', "Una crisis económica que afectó a países de todo el mundo, iniciando en EE.UU.", "https://es.wikipedia.org/wiki/Gran_Depresi%C3%B3n"),
(24, "El Holocausto", "Genocidio de judíos y otros grupos durante la Segunda Guerra Mundial", "1941 - 1945", 4, '13.4050, 52.5200', "La persecución y exterminio sistemático de millones de personas por el régimen nazi.", "https://es.wikipedia.org/wiki/Holocausto"),
(25, "Movimiento por los Derechos Civiles", "Lucha por la igualdad racial en EE.UU.", "1954 - 1968", 5, '-98.5834, 39.8283', "Un movimiento social que buscó terminar con la segregación racial y garantizar los derechos de los afroamericanos.", "https://es.wikipedia.org/wiki/Movimiento_por_los_derechos_civiles_en_los_Estados_Unidos"),
(26, "Primera Misión Tripulada al Espacio", "Yuri Gagarin se convierte en el primer hombre en el espacio", "12/04/1961", 6, '30.2672, 59.9343', "El primer viaje humano al espacio, un hito en la carrera espacial.", "https://es.wikipedia.org/wiki/Yuri_Gagarin"),
(27, "Caída del Muro de Berlín", "Fin de la división de Alemania", "9/11/1989", 7, '13.4050, 52.5200', "La caída del muro que separaba Berlín Oriental y Occidental, simbolizando el fin de la Guerra Fría.", "https://es.wikipedia.org/wiki/Ca%C3%ADda_del_Muro_de_Berl%C3%ADn"),
(28, "11 de septiembre", "Ataques terroristas en EE.UU.", "11/09/2001", 8, '-74.0060, 40.7128', "Una serie de ataques que cambiaron la política y la seguridad global en el siglo XXI.", "https://es.wikipedia.org/wiki/Atentados_del_11_de_septiembre_de_2001"),
(29, "Covid-19", "Pandemia global", "2019 - presente", 9, '130.0000, -12.0000', "Una pandemia que ha impactado la salud, la economía y la vida cotidiana en todo el mundo.", "https://es.wikipedia.org/wiki/Pandemia_de_COVID-19"),
(30, "Inundación de La Plata", "Inundación en La Plata, Argentina", "2/04/2013", 11, '-58.0012, -34.9214', "Una de las inundaciones más devastadoras en la historia de La Plata, con más de 100 mm de lluvia en una hora, causando severos daños materiales y la muerte de al menos 89 personas.", "https://es.wikipedia.org/wiki/Inundaci%C3%B3n_en_La_Plata_de_2013"),
(31, "Independencia de Madagascar", "Madagascar se convierte en un país independiente de Francia", "26/06/1960", 1, '46.8691, -18.7669', "La independencia de Madagascar marcó el fin de un largo periodo de colonización francesa.", "https://es.wikipedia.org/wiki/Independencia_de_Madagascar"),
(32, "Independencia de Papua Nueva Guinea", "Papua Nueva Guinea se independiza de Australia", "16/09/1975", 2, '144.2687, -6.3145', "El país se convierte en un estado independiente tras años de tutela australiana.", "https://es.wikipedia.org/wiki/Independencia_de_Papua_Nueva_Guinea"),
(33, "Batalla de Isandlwana", "Conflicto entre el ejército británico y los zulúes", "22/01/1879", 3, '30.7922, -28.4333', "Una de las principales batallas de la Guerra Anglo-Zulú que resultó en una victoria zulú.", "https://es.wikipedia.org/wiki/Batalla_de_Isandlwana"),
(34, "Cruzada de las mujeres", "Cruzada de mujeres para liberar Jerusalén", "1147", 4, '35.2137, 31.7683', "Un evento único en la historia, donde un grupo de mujeres tomó la iniciativa de luchar por la liberación de Jerusalén.", "https://es.wikipedia.org/wiki/Cruzadas"),
(35, "Descubrimiento de la Isla de Pascua", "Descubrimiento de Rapa Nui por los europeos", "5/04/1722", 5, '-109.3497, -27.1212', "La llegada de los europeos a la remota Isla de Pascua, conocida por sus moáis.", "https://es.wikipedia.org/wiki/Isla_de_Pascua"),
(36, "Revolución de Argelia", "Lucha por la independencia de Argelia de Francia", "1954 - 1962", 6, '3.0588, 36.7538', "Un conflicto que resultó en la independencia de Argelia tras años de colonización francesa.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_argelina"),
(37, "Guerra del Opio", "Conflicto entre China y Gran Bretaña", "1839 - 1842", 7, '104.1954, 35.8617', "Un conflicto que marcó el inicio de la intervención europea en China y el comercio de opio.", "https://es.wikipedia.org/wiki/Guerra_del_Opio"),
(38, "Revolución de los Claveles", "Revolución pacífica en Portugal", "25/04/1974", 8, '-9.1394, 38.7223', "Un levantamiento que terminó con la dictadura en Portugal sin derramamiento de sangre.", "https://es.wikipedia.org/wiki/Revoluci%C3%B3n_de_los_Claveles"),
(39, "Descubrimiento del fuego", "Control del fuego por los humanos", "~1.000.000 a.C.", 9, '30.0000, 40.0000', "Un avance crucial para la humanidad que permitió la cocción de alimentos y protección.", "https://es.wikipedia.org/wiki/Historia_del_fuego")
;
