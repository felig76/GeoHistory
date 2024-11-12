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
    const query = 'CALL consultar_eventos()'; // Cambia a tu stored procedure
    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        // Acceder a results[0] para obtener los datos reales
        const formattedResults = results[0].map(event => ({
            ...event,
            coordenadas: event.coordenadas ? event.coordenadas.split(',').map(Number) : [] // Maneja casos de coordenadas nulas
        }));
        res.json(formattedResults);
    });
});

// Iniciar el servidor
server.listen(3000, () => {
    console.log(`El servidor está corriendo en el puerto 3000`);
});
