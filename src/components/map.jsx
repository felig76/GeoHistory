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
  maptilersdk.config.apiKey = 'D3W7mM6N8VLQzfLbmthY';

  const [selectedEvent, setSelectedEvent] = useState(null);
  const [events, setEvents] = useState([]);

  /* const events = [
    { id: 1, name: "Batalla de Waterloo", shortName: "Batalla de Waterloo", coordinates: [4.4187, 50.6821], description: "Ocurrió en 1815, poniendo fin a las guerras napoleónicas." },
    { id: 2, name: "Descubrimiento de América", shortName: "Descubrimiento de américa", coordinates: [-72.195689,19.764901], description: "Cristóbal Colón llega a América en 1492." },
    { id: 3, name: "Desembarco de Normandía", shortName: "Día D", coordinates: [-0.611642, 49.339818], description: "Desembarco de Normandía en 1944 durante la Segunda Guerra Mundial." }
  ]; */

  useEffect(() => {
    axios.get('http://127.0.0.1:5000/api/eventos')
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
      style: maptilersdk.MapStyle.BACKDROP.DARK,
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