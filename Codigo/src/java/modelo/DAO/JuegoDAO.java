/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.Conexion;

/**
 *
 * @author Juancarlos
 */
public class JuegoDAO {

    private Connection conexion;

    //Abrir la conexión
    public JuegoDAO() {
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

    // Método para comprobar si el id existe en la tabla
    public boolean compruebaID(int id) {
        try {
            // Preparar una consulta para comprobar si el ID existe en la tabla juego
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT COUNT(*) FROM juego WHERE id_juego = ?");
            preSta.setInt(1, id);
            ResultSet resultado = preSta.executeQuery();

            // Verificar el resultado de la consulta
            if (resultado.next()) {
                int count = resultado.getInt(1);
                return count > 0;
            }

            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Método para añadir un id
    public boolean agregarID(int id, String nombre, String fechaLanzamiento) {
        try {
            // Preparar una consulta para insertar el ID en la tabla juego
            PreparedStatement preSta = conexion.prepareStatement(
                    "INSERT INTO juego (id_juego, nombre, fechaLanzamiento) VALUES (?, ?, ?)");
            preSta.setInt(1, id);
            preSta.setString(2, nombre);
            preSta.setString(3, fechaLanzamiento);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
