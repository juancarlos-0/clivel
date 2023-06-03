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
public class ValoracionDAO {

    private Connection conexion;

    //Abrir la conexión
    public ValoracionDAO() {
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

    // Función que comprueba si existe una valoración para un usuario y un juego específicos
    public boolean existeValoracion(int id_usuario, int id_juego) {
        boolean existe = false;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String query = "SELECT * FROM valoracion WHERE id_usuario = ? AND id_juego = ?";
            pstmt = conexion.prepareStatement(query);
            pstmt.setInt(1, id_usuario);
            pstmt.setInt(2, id_juego);
            rs = pstmt.executeQuery();

            // Verificar si existe una valoración para el usuario y el juego
            if (rs.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existe;
    }

}
