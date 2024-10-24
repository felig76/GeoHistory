// EventPanel.js
import React from 'react';
import './EventPanel.css';

const EventPanel = ({ event, onClose }) => {
  if (!event) return null;

  return (
    <div className="info-panel">
      <button onClick={onClose}>X</button>
      <main>
        <h2>{event.nombre_completo} </h2>
        <h3>{event.fecha_inicio} - {event.fecha_fin}</h3>
        <p>{event.descripcion}</p>
        <p id='linkEvento'>{event.link}</p>
      </main>
    </div>
  );
};

export default EventPanel;