import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Formulario extends JFrame {
    private JTextField nombreCortoField;
    private JTextField nombreField;
    private JTextField fechaInicioField;
    private JTextField fechaFinField;
    private JTextField descripcionField;
    private JTextField ordenRelevanciaField;
    private JTextField coordenadasField;
    private JTextField linkWikiField;

    public Formulario() {
        setTitle("Formulario de Evento");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new GridLayout(9, 2));

        // Crear campos de texto
        nombreCortoField = new JTextField();
        nombreField = new JTextField();
        fechaInicioField = new JTextField();
        fechaFinField = new JTextField();
        descripcionField = new JTextField();
        ordenRelevanciaField = new JTextField();
        coordenadasField = new JTextField();
        linkWikiField = new JTextField();

        // Botón de guardar
        JButton guardarButton = new JButton("Guardar");
        guardarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                guardarEvento();
            }
        });

        // Agregar componentes al marco
        add(new JLabel("Nombre Corto:"));
        add(nombreCortoField);
        add(new JLabel("Nombre:"));
        add(nombreField);
        add(new JLabel("Fecha Inicio:"));
        add(fechaInicioField);
        add(new JLabel("Fecha Fin:"));
        add(fechaFinField);
        add(new JLabel("Descripción:"));
        add(descripcionField);
        add(new JLabel("Orden de Relevancia:"));
        add(ordenRelevanciaField);
        add(new JLabel("Coordenadas:"));
        add(coordenadasField);
        add(new JLabel("Link de Wiki:"));
        add(linkWikiField);
        add(guardarButton);

        setVisible(true);
    }

    private void guardarEvento() {
        String nombreCorto = nombreCortoField.getText();
        String nombre = nombreField.getText();
        String fechaInicio = fechaInicioField.getText();
        String fechaFin = fechaFinField.getText();
        String descripcion = descripcionField.getText();
        String ordenRelevancia = ordenRelevanciaField.getText();
        String coordenadas = coordenadasField.getText();
        String linkWiki = linkWikiField.getText();

        try (Connection connection = Conexion.getConnection()) {
            String sql = "INSERT INTO eventos (nombre_corto, nombre, fecha_inicio, fecha_fin, descripcion, orden_relevancia, coordenadas, link_wiki) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, nombreCorto);
            statement.setString(2, nombre);
            statement.setString(3, fechaInicio);
            statement.setString(4, fechaFin);
            statement.setString(5, descripcion);
            statement.setInt(6, Integer.parseInt(ordenRelevancia));
            statement.setString(7, coordenadas);
            statement.setString(8, linkWiki);
            statement.executeUpdate();
            JOptionPane.showMessageDialog(this, "Evento guardado correctamente.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error al guardar el evento: " + ex.getMessage());
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Orden de relevancia debe ser un número.");
        }
    }

    public static void main(String[] args) {
        new Formulario();
    }
}
