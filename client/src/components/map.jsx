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
    axios.get('http://localhost:3000/api/eventos')
      .then(response => {
        setEvents(response.data);
        console.log('Eventos cargados:', response.data); // Verificar la data recibida
      })
      .catch(error => {
        console.error("Error al obtener los eventos:", error);
      });
  }, []);

  useEffect(() => {
    if (map.current) return;

    map.current = new maptilersdk.Map({
      container: mapContainer.current,
      style: "19d00ef7-e89d-48a7-ba5e-f7521217a2bf",
      center: [0, 0],
      zoom: 2
    });
  }, []);

  useEffect(() => {
    if (!map.current || events.length === 0) return;

    console.log('Eventos en el mapa:', events); // Verificar el contenido de events

    events.forEach(event => {
      const marker = new maptilersdk.Marker({
        element: document.createElement('div')
      })
        .setLngLat(event.coordenadas)
        .addTo(map.current);

      const markerElement = marker.getElement();
      markerElement.style.backgroundImage = `url(${customMarker})`;
      markerElement.style.backgroundSize = 'contain';
      markerElement.style.width = '0.5rem';
      markerElement.style.height = '0.5rem';

      markerElement.addEventListener('click', () => {
        setSelectedEvent(event);
      });

      const label = document.createElement('span');
      label.className = 'marker-label';
      label.innerText = event.nombre_corto;
      markerElement.appendChild(label);
    });
  }, [events]);

  return (
    <div className="map-wrap">
      <div ref={mapContainer} className="map" />
      <EventPanel event={selectedEvent} onClose={() => setSelectedEvent(null)} />
    </div>
  );
}
