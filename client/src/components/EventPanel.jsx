// EventPanel.js
import React from 'react';
import './EventPanel.css';

const EventPanel = ({ event, onClose }) => {
  if (!event) return null;

  const truncateLink = (link) => {
    if (link.length > 35) {
      return link.slice(0, 35) + '...';
    }
    return link;
  };

  return (
    <div className="info-panel">
      <button onClick={onClose}>X</button>
      <main>
        <h2>{event.nombre_completo}</h2>
        <h3>
          {event.fecha}
        </h3>
        <p>{event.descripcion}</p>
        <a 
          id='linkEvento' 
          href={event.link} 
          target="_blank" 
          rel="noopener noreferrer"
        >
          {truncateLink(event.link)}
        </a>
      </main>
    </div>
  );
};

export default EventPanel;
