CREATE DATABASE Eventos_Historicos;

USE Eventos_Historicos;

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