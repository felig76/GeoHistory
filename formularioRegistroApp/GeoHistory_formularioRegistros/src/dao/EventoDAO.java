package dao;

import modelo.Evento;
import util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EventoDAO {
    public void guardarEvento(Evento evento) throws SQLException {
        String sql = "INSERT INTO eventos (nombre_corto, nombre_completo, fecha, orden_relevancia, coordenadas, descripcion, link) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = Conexion.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, evento.getNombreCorto());
            statement.setString(2, evento.getNombre());
            statement.setString(3, evento.getFecha());
            statement.setInt(4, evento.getOrdenRelevancia());
            statement.setString(5, evento.getCoordenadas());
            statement.setString(6, evento.getDescripcion());
            statement.setString(7, evento.getLinkWiki());

            statement.executeUpdate();
        }
    }
}

