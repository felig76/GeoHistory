const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');

const server = express();

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

server.use(cors({
    origin: 'http://localhost:5173'
}));

server.get('/api/eventos', (req, res) => {
    const query = 'SELECT * FROM eventos';
    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        // Formatear las coordenadas como un array de números
        const formattedResults = results.map(event => ({
            ...event,
            coordenadas: event.coordenadas.split(',').map(Number) // Convierte las coordenadas a un array de números
        }));
        res.json(formattedResults);
    });
});

// Iniciar el servidor
server.listen(3000, () => {
    console.log(`El servidor está corriendo en el puerto 3000`);
});
