/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Conexion;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
public class AmigoModeloDAO {

    private Connection conexion;

    //Abrir la conexión
    public AmigoModeloDAO() {
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

    //Método para agregar un amigo pasando los ids
    public boolean agregarAmigo(int id1, int id2) {

        try {
            // Preparar una consulta para insertar la liga
            PreparedStatement preSta = conexion.prepareStatement(
                    "INSERT INTO amigos (id_usuario, "
                    + "id_usuario_amigo) "
                    + "VALUES (?, ?) ");
            preSta.setInt(1, id1);
            preSta.setInt(2, id2);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que comprueba si son amigos
    public boolean compruebaAmistad(int id1, int id2) {

        try {
            // Preparar una consulta para insertar la liga
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT * FROM amigos WHERE id_usuario = ? AND id_usuario_amigo = ?");
            preSta.setInt(1, id1);
            preSta.setInt(2, id2);

            ResultSet rs = preSta.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método para eliminar amistad
    public boolean eliminarAmistad(int id1, int id2) {
        try {
            // Preparar una consulta para eliminar la amistad
            PreparedStatement preSta = conexion.prepareStatement(
                    "DELETE FROM amigos WHERE (id_usuario = ? AND id_usuario_amigo"
                    + " = ?) OR (id_usuario = ? AND id_usuario_amigo = ?)");
            preSta.setInt(1, id1);
            preSta.setInt(2, id2);
            preSta.setInt(3, id2);
            preSta.setInt(4, id1);

            int filasEliminadas = preSta.executeUpdate();
            return filasEliminadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que devuelve una lista de amigos
    public List<Usuario> listaAmigos(int id_usuario) {
        List<Usuario> usuariosEncontrados = new ArrayList<>();
        List<Integer> listaDeID = new ArrayList<>();

        //Primero obtengo todos los id de los amigos
        try {
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT id_usuario_amigo FROM amigos WHERE id_usuario = ?");
            preSta.setInt(1, id_usuario);
            ResultSet rs = preSta.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario_amigo"));

                listaDeID.add(usuario.getId_usuario());
            }
        } catch (SQLException e) {

        }

        //Luego obtengo la informacion de los amigos
        try {
            for (int id_amigo : listaDeID) {
                PreparedStatement preSta = conexion.prepareStatement(
                        "SELECT * FROM usuario WHERE id_usuario = ?");
                preSta.setInt(1, id_amigo);
                ResultSet rs = preSta.executeQuery();

                while (rs.next()) {
                    Usuario amigo = new Usuario();
                    amigo.setId_usuario(rs.getInt("id_usuario"));
                    amigo.setUsuario(rs.getString("usuario"));
                    amigo.setContrasenia(rs.getString("contrasenia"));
                    amigo.setNombre(rs.getString("nombre"));
                    amigo.setApellidos(rs.getString("apellidos"));
                    amigo.setCorreo(rs.getString("correo"));
                    amigo.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                    amigo.setFoto(rs.getBytes("foto"));
                    amigo.setDescripcion(rs.getString("descripcion"));
                    amigo.setRol(rs.getString("rol"));
                    amigo.setExperto(rs.getBoolean("experto"));
                    amigo.setEstado(rs.getString("estado"));
                    amigo.setUsuario_cambiado(rs.getBoolean("usuario_cambiado"));

                    usuariosEncontrados.add(amigo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuariosEncontrados;
    }

}
