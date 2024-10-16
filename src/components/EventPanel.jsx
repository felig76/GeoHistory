// EventPanel.js
import React from 'react';
import './EventPanel.css';

const EventPanel = ({ event, onClose }) => {
  if (!event) return null;

  return (
    <div className="info-panel">
      <button onClick={onClose}>X</button>
      <main>
        <h2>{event.name}</h2>
        <p>{event.description}</p>
      </main>
    </div>
  );
};

export default EventPanel;