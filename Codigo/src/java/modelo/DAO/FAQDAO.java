/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import modelo.Conexion;

/**
 *
 * @author Juancarlos
 */
public class FAQDAO {

    private Connection conexion;

    //Abrir la conexión
    public FAQDAO() {
        this.conexion = new Conexion().getConexion();
    }

    //Cerrar la conexión
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método que obtiene un mapa con los datos de pregunta y respuesta de la tabla faq
    public Map<String, String> obtenerPreguntasRespuestas() {
        Map<String, String> faqMap = new HashMap<>();

        try {
            Statement statement = conexion.createStatement();
            String query = "SELECT pregunta, respuesta FROM faq";
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                String pregunta = resultSet.getString("pregunta");
                String respuesta = resultSet.getString("respuesta");
                faqMap.put(pregunta, respuesta);
            }

            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return faqMap;
    }

}
