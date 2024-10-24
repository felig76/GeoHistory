import React, { useRef, useEffect, useState } from 'react';
import * as maptilersdk from '@maptiler/sdk';
import "@maptiler/sdk/dist/maptiler-sdk.css";
import './map.css';
import customMarker from '../assets/marker.png';
import EventPanel from './EventPanel.jsx';
import axios from 'axios';

export default function Map() {
  const mapContainer = useRef(null);
  const map = useRef(null);
  maptilersdk.config.apiKey = 'h61PKvbK3NMMfF5kGaf3';

  const [selectedEvent, setSelectedEvent] = useState(null);
  const [events, setEvents] = useState([]);

  useEffect(() => {
    axios.get('http://localhost/api/eventos')
      .then(response => {
        setEvents(response.data);
      })
      .catch(error => {
        console.error("Error al obtener los eventos:", error);
      });
  }, []);
  
  useEffect(() => {
    if (map.current) return; // stops map from intializing more than once

    map.current = new maptilersdk.Map({
      container: mapContainer.current,
      style: "19d00ef7-e89d-48a7-ba5e-f7521217a2bf",
      center: [0, 0],
      zoom: 2
    });

    events.forEach(event => {
      const marker = new maptilersdk.Marker({
        element: document.createElement('div') // Crea un contenedor div para el icono personalizado
      })
        .setLngLat(event.coordenadas)
        .addTo(map.current);

      const markerElement = marker.getElement(); // Accede al elemento DOM del marcador
      markerElement.style.backgroundImage = `url(${customMarker})`; // Aplica la imagen de fondo
      markerElement.style.backgroundSize = 'contain'; // Asegura que la imagen se ajuste
      markerElement.style.width = '0.5rem'; // Ajusta el tamaño del marcador
      markerElement.style.height = '0.5rem'; // Ajusta el tamaño del marcador

      // Manejar clic en el marcador
      marker.getElement().addEventListener('click', () => {
        setSelectedEvent(event); // Cambia el estado para mostrar el panel de info
      });

      // Crear el label del evento
      const label = document.createElement('span');
      label.className = 'marker-label';
      label.innerText = event.nombre_corto;

      // Añadir el label al elemento del marcador
      markerElement.appendChild(label);

      // Manejar clic en el marcador
      markerElement.addEventListener('click', () => {
        setSelectedEvent(event);
      });
    });
  }, [events]);

  return (
    <div className="map-wrap">
      <div ref={mapContainer} className="map" />
      <EventPanel event={selectedEvent} onClose={() => setSelectedEvent(null)} />
    </div>
  );
}