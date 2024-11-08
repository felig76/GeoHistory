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
  const [zoomLevel, setZoomLevel] = useState(1.3);
  const markersRef = useRef([]); // Array para almacenar los marcadores actuales

  useEffect(() => {
    axios.get('http://localhost:3000/api/eventos')
      .then(response => {
        setEvents(response.data);
        console.log('Eventos cargados:', response.data);
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
      center: [10, 27],
      zoom: 1.3
    });

    // Actualiza el nivel de zoom en el estado cuando cambia
    map.current.on('zoom', () => {
      setZoomLevel(map.current.getZoom());
    });
  }, []);

  // Función para actualizar los marcadores según el nivel de zoom
  const updateMarkers = () => {
    // Elimina marcadores previos
    markersRef.current.forEach(marker => marker.remove());
    markersRef.current = [];

    // Filtra eventos según el nivel de zoom y relevancia
    events.forEach(event => {
      const relevance = event.orden_relevancia;

      if (
        (zoomLevel > 8 && relevance >= 1) ||
        (zoomLevel > 5 && relevance >= 3) ||
        (zoomLevel > 3 && relevance >= 5) ||
        (zoomLevel > 1.5 && relevance >= 7) ||
        (zoomLevel <= 1.5 && relevance === 10)
      ) {
        const marker = new maptilersdk.Marker({
          element: document.createElement('div')
        })
          .setLngLat(event.coordenadas)
          .addTo(map.current);

        const markerElement = marker.getElement();
        markerElement.style.backgroundImage = `url(${customMarker})`;
        markerElement.style.backgroundSize = 'contain';
        markerElement.style.width = `${(event.orden_relevancia * 0.06) + 0.4}rem`;
        markerElement.style.height = `${(event.orden_relevancia * 0.06) + 0.4}rem`;

        markerElement.addEventListener('click', () => {
          setSelectedEvent(event);
        });

        const label = document.createElement('span');
        label.className = 'marker-label';
        label.innerText = event.nombre_corto;
        label.style.fontSize = `${(event.orden_relevancia * 0.03) + 1.2}rem`;
        label.style.fontWeight = `${Math.min(900, Math.max(100, (event.orden_relevancia * 100) + 200))}`;
        label.style.padding = `${Math.min(1, (event.orden_relevancia * 0.02) + 0.5)}rem`;
        markerElement.appendChild(label);

        // Almacena el marcador en el array de referencia
        markersRef.current.push(marker);
      }
    });
  };

  // Actualiza los marcadores cuando cambian los eventos o el nivel de zoom
  useEffect(() => {
    if (map.current) {
      updateMarkers();
    }
  }, [events, zoomLevel]);

  return (
    <div className="map-wrap">
      <div ref={mapContainer} className="map" />
      <EventPanel event={selectedEvent} onClose={() => setSelectedEvent(null)} />
    </div>
  );
}
