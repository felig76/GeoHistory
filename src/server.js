const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Configuración de la conexión a MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'eventos_historicos'
});

db.connect(err => {
  if (err) {
    console.error('Error al conectarse a la base de datos:', err);
    return;
  }
  console.log('Conexión a la base de datos MySQL exitosa');
});

// Ruta para obtener los eventos
app.get('/api/eventos', (req, res) => {
  const query = 'SELECT * FROM eventos';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    const formattedResults = results.map(event => ({
      ...event,
      coordenadas: event.coordenadas.split(',').map(Number) // Convertir las coordenadas a array de números
    }));
    res.json(formattedResults);
  });
});

// Iniciar el servidor
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en el puerto ${PORT}`);
});