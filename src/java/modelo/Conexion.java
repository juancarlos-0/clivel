/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Juancarlos
 */
public class Conexion {

    private Connection conexion;

    //Establecer conexion en el constructor
    public Conexion() {
        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        } catch (SQLException e) {
            System.err.println("Error al establecer la conexión: " + e.getMessage());
        }
    }

    public Connection getConexion() {
        return conexion;
    }

    //Método para cerrar la conexión
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
