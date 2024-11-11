import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

public class Formulario extends JFrame {
    private JTextField nombreCortoField;
    private JTextField nombreField;
    private JTextField fechaField;
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
        fechaField = new JTextField();
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
        add(new JLabel("Fecha:"));
        add(fechaField);
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
        String fecha = fechaField.getText();
        String descripcion = descripcionField.getText();
        String ordenRelevancia = ordenRelevanciaField.getText();
        String coordenadas = coordenadasField.getText();
        String linkWiki = linkWikiField.getText();

        try (Connection connection = Conexion.getConnection()) {
            String sql = "INSERT INTO eventos (nombre_corto, nombre_completo, fecha, orden_relevancia, coordenadas, descripcion, link) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, nombreCorto);
            statement.setString(2, nombre);
            statement.setString(3, fecha);
            statement.setInt(4, Integer.parseInt(ordenRelevancia));
            statement.setString(5, coordenadas);
            statement.setString(6, descripcion);
            statement.setString(7, linkWiki);
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
