/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import modelo.Conexion;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
public class NotificacionModeloDAO {

    private Connection conexion;

    //Abrir la conexión
    public NotificacionModeloDAO() {
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

    //Método que manda una solicitud de amistad
    public boolean enviarSolicitudAmistad(int solicitud, int solicitado) {

        try {
            // Preparar una consulta 
            PreparedStatement preSta = conexion.prepareStatement(
                    "INSERT INTO notificacion (id_usuario, "
                    + "id_usuario_notificacion, estado) "
                    + "VALUES (?, ?, 'solicitud') ");
            preSta.setInt(1, solicitud);
            preSta.setInt(2, solicitado);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que acepta la solicitud de la notificacion
    public boolean aceptarSolicitud(int solicitud, int solicitado) {

        try {
            // Preparar una consulta 
            PreparedStatement preSta = conexion.prepareStatement(
                    "UPDATE notificacion SET estado = 'aceptada' "
                    + "WHERE id_usuario = ? AND id_usuario_notificacion = ? AND estado = 'solicitud'");
            preSta.setInt(1, solicitud);
            preSta.setInt(2, solicitado);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que comprueba si la solicitud está aceptada
    public boolean compruebaSolicitudAceptada(int solicitud, int solicitado) {

        try {
            // Preparar una consulta para ver si está acepada la solicitud
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT * FROM notificacion WHERE id_usuario = ? "
                    + "AND id_usuario_notificacion = ? AND estado = 'aceptada'"
            );
            preSta.setInt(1, solicitud);
            preSta.setInt(2, solicitado);
            ResultSet rs = preSta.executeQuery();

            // Comprobar si la consulta devuelve alguna fila
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Borrar peticion de amigo
    public boolean rechazarSolicitud(int solicitud, int solicitado) {

        try {
            // Preparar una consulta 
            PreparedStatement preSta = conexion.prepareStatement(
                    "DELETE FROM notificacion WHERE id_usuario = ? AND id_usuario_notificacion = ?");
            preSta.setInt(1, solicitud);
            preSta.setInt(2, solicitado);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que devuelve los id de los usuarios que han mandado solicitud
    public List<Integer> listaDeIdSolicitantes(Usuario usuarioSolicitado) {

        List<Integer> listaIdUsuarios = new ArrayList<>();

        try {
            // Preparar una consulta para seleccionar los id de los usuarios que han enviado una solicitud
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT id_usuario FROM notificacion WHERE id_usuario_notificacion = ? AND estado = 'solicitud'"
            );
            preSta.setInt(1, usuarioSolicitado.getId_usuario());

            // Ejecutar la consulta SQL y recuperar los resultados
            ResultSet result = preSta.executeQuery();
            while (result.next()) {
                listaIdUsuarios.add(result.getInt("id_usuario"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Devolver la lista de id de usuarios
        return listaIdUsuarios;
    }
}
