import React from "react";
import { MapContainer, TileLayer } from "react-leaflet";

const VistaMapa = () => {
  return (
    <MapContainer
      center={[0, 0]}   // Coordenadas iniciales
      zoom={2}          // Nivel de zoom inicial
      minZoom={2}       // Zoom mínimo para evitar mosaico repetido
      maxZoom={10}      // Zoom máximo permitido
      style={{ height: "100vh", width: "100%" }}
      maxBounds={[[85, -180], [-85, 180]]} // Limitar el desplazamiento del mapa
    >
      {/* Estilo plano con MapTiler */}
      <TileLayer
        url="https://api.maptiler.com/maps/2430c147-275f-493b-8e22-2df37acb64cb/?key=cwNIqMDGUqfzmEWcBuqA"
        attribution='&copy; <a href="https://www.maptiler.com/">MapTiler</a>'
      />
    </MapContainer>
  );
};

export default VistaMapa;