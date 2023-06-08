/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.DAO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import javax.servlet.http.Part;
import modelo.Conexion;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
public class UsuarioModeloDAO {

    private Connection conexion;

    //Abrir la conexión
    public UsuarioModeloDAO() {
        this.conexion = new Conexion().getConexion();
    }

    //Método para registrar a un usuario
    public boolean registrarUsuario(Usuario usuario) {

        try {
            // Preparar una consulta para insertar la liga
            PreparedStatement preSta = conexion.prepareStatement(
                    "INSERT INTO usuario (usuario, contrasenia, nombre, "
                    + "apellidos, correo, fecha_nacimiento, foto, "
                    + " descripcion, rol, experto, estado, usuario_cambiado) "
                    + "VALUES (?, ?, ?, ?, ?, ?, null, '', 'normal', false, 'conectado', false)");
            preSta.setString(1, usuario.getUsuario());
            preSta.setString(2, usuario.getContrasenia());
            preSta.setString(3, usuario.getNombre());
            preSta.setString(4, usuario.getApellidos());
            preSta.setString(5, usuario.getCorreo());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String fechaString = dateFormat.format(usuario.getFecha_nacimiento());
            preSta.setString(6, fechaString);
            preSta.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método para comprobar que existe el correo para un usuario
    public boolean existeCorreo(Usuario usuario) {
        try {
            // Preparar una consulta para buscar el correo en la tabla usuario
            PreparedStatement preSta = conexion.prepareStatement("SELECT COUNT(*) FROM usuario WHERE correo = ?");
            preSta.setString(1, usuario.getCorreo());

            ResultSet resultSet = preSta.executeQuery();
            resultSet.next();

            int count = resultSet.getInt(1);

            // Si count es mayor que cero, significa que el correo ya existe
            return count > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método para comprobar que coincide usuario y contraseña
    public boolean contraUsuarioCoincide(Usuario usuario) {
        try {
            // Preparar una consulta para buscar el usuario y la contraseña en la tabla usuario
            PreparedStatement preSta = conexion.prepareStatement("SELECT COUNT(*) FROM usuario WHERE usuario = ? AND contrasenia = ?");
            preSta.setString(1, usuario.getUsuario());
            preSta.setString(2, usuario.getContrasenia());

            ResultSet resultSet = preSta.executeQuery();
            resultSet.next();

            int count = resultSet.getInt(1);

            // Si count es igual a uno, significa que coincide el usuario y la contraseña
            return count == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que devuelve los datos del usuario
    public Usuario devolverDatos(String usuario) {
        Usuario usuarioDatos = new Usuario();
        try {
            // Preparar una consulta para obtener los datos del usuario
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT * FROM usuario WHERE usuario = ?");
            preSta.setString(1, usuario);

            ResultSet resultSet = preSta.executeQuery();
            if (resultSet.next()) {
                usuarioDatos.setId_usuario(resultSet.getInt("id_usuario"));
                usuarioDatos.setUsuario(resultSet.getString("usuario"));
                usuarioDatos.setContrasenia(resultSet.getString("contrasenia"));
                usuarioDatos.setNombre(resultSet.getString("nombre"));
                usuarioDatos.setApellidos(resultSet.getString("apellidos"));
                usuarioDatos.setCorreo(resultSet.getString("correo"));
                usuarioDatos.setFecha_nacimiento(resultSet.getDate("fecha_nacimiento"));
                usuarioDatos.setFoto(resultSet.getString("foto"));
                usuarioDatos.setFondo(resultSet.getString("fondo"));
                usuarioDatos.setDescripcion(resultSet.getString("descripcion"));
                usuarioDatos.setRol(resultSet.getString("rol"));
                usuarioDatos.setExperto(resultSet.getBoolean("experto"));
                usuarioDatos.setEstado(resultSet.getString("estado"));
                usuarioDatos.setUsuario_cambiado(resultSet.getBoolean("usuario_cambiado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarioDatos;
    }

    //Método que actualiza los datos del perfil
    public boolean actualizaDatos(Usuario usuario) {
        try {
            // Preparar una consulta para actualizar los datos del usuario
            PreparedStatement preSta = conexion.prepareStatement(
                    "UPDATE usuario SET apellidos = ?, contrasenia = ?, nombre = ?, "
                    + "fecha_nacimiento = ?, descripcion = ? WHERE id_usuario = ?");

            preSta.setString(1, usuario.getApellidos());
            preSta.setString(2, usuario.getContrasenia());
            preSta.setString(3, usuario.getNombre());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String fechaString = dateFormat.format(usuario.getFecha_nacimiento());
            preSta.setString(4, fechaString);
            preSta.setString(5, usuario.getDescripcion());
            preSta.setInt(6, usuario.getId_usuario());

            int rowCount = preSta.executeUpdate();

            return rowCount > 0; // Retorna true si se actualizó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método que actualiza los datos con el usuario incluido y además añade que
    //el usuario no se pueda actualizar otra vez
    public boolean actualizaDatosUsuario(Usuario usuario) {
        try {
            // Preparar una consulta para actualizar los datos del usuario
            PreparedStatement preSta = conexion.prepareStatement(
                    "UPDATE usuario SET apellidos = ?, contrasenia = ?, nombre = ?, "
                    + "fecha_nacimiento = ?, descripcion = ?, usuario = ?, usuario_cambiado = 1 WHERE id_usuario = ?");

            preSta.setString(1, usuario.getApellidos());
            preSta.setString(2, usuario.getContrasenia());
            preSta.setString(3, usuario.getNombre());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String fechaString = dateFormat.format(usuario.getFecha_nacimiento());
            preSta.setString(4, fechaString);
            preSta.setString(5, usuario.getDescripcion());
            preSta.setString(6, usuario.getUsuario());
            preSta.setInt(7, usuario.getId_usuario());

            int rowCount = preSta.executeUpdate();

            return rowCount > 0; // Retorna true si se actualizó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Método para obtener el ID del usuario
    public int idUsuario(String usuario) {
        int id = 0;

        try {
            // Preparar una consulta para obtener el ID del usuario
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT id_usuario FROM usuario WHERE usuario = ?");
            preSta.setString(1, usuario);

            ResultSet resultSet = preSta.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt("id_usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return id;
    }

    //Método para subir una foto para el perfil del usuario
    public boolean subirFoto(int idUsuario, String rutaFoto) {
        try {
            // Preparar la sentencia SQL para actualizar la foto del usuario
            String sql = "UPDATE usuario SET foto = ? WHERE id_usuario = ?";
            PreparedStatement statement = conexion.prepareStatement(sql);

            // Establecer los parámetros de la sentencia SQL
            statement.setString(1, rutaFoto);
            statement.setInt(2, idUsuario);

            // Ejecutar la sentencia SQL
            int filasActualizadas = statement.executeUpdate();

            return filasActualizadas > 0; // Indicar si la foto se actualizó correctamente
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //Método para subir un fondo
    public boolean subirFondo(int idUsuario, String rutaFondo) {
        try {
            // Preparar la sentencia SQL para actualizar la foto del usuario
            String sql = "UPDATE usuario SET fondo = ? WHERE id_usuario = ?";
            PreparedStatement statement = conexion.prepareStatement(sql);

            // Establecer los parámetros de la sentencia SQL
            statement.setString(1, rutaFondo);
            statement.setInt(2, idUsuario);

            // Ejecutar la sentencia SQL
            int filasActualizadas = statement.executeUpdate();

            return filasActualizadas > 0; // Indicar si la foto se actualizó correctamente
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Metodo que devuelve una lista de usuarios
    public List<Usuario> buscarUsuarios(String nombreBusqueda) {
        List<Usuario> usuariosEncontrados = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM usuarios WHERE nombre LIKE ?";
            PreparedStatement statement = conexion.prepareStatement(sql);
            stmt.setString(1, "%" + nombreBusqueda + "%");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellidos(rs.getString("apellido"));

                usuariosEncontrados.add(usuario);
            }
        } catch (SQLException e) {

        }

        return usuariosEncontrados;
    }

    //Cerrar la conexión
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Método que comprueba si existe un usuario
    public boolean existeUsuario(Usuario usuario) {
        try {
            // Preparar una consulta para buscar el usuario
            PreparedStatement preSta = conexion.prepareStatement("SELECT * FROM usuario WHERE usuario = ?");
            preSta.setString(1, usuario.getUsuario());
            ResultSet res = preSta.executeQuery();

            // Si se encontró un resultado, el usuario existe
            return res.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Obtener nombre de usuarios mediante una lista
    public List<Usuario> listaDeUsuariosMedianteId(List<Integer> listaDeId) {

        List<Usuario> listaDeUsuarios = new ArrayList<>();

        // Devolver lista vacía si la lista de usuarios está vacía
        if (listaDeId.isEmpty()) {
            return listaDeUsuarios; 
        }

        try {
            // Preparar una consulta para obtener los usuarios
            PreparedStatement preSta = conexion.prepareStatement(
                    "SELECT * FROM usuario WHERE id_usuario IN (" + String.join(",", Collections.nCopies(listaDeId.size(), "?")) + ")"
            );

            for (int i = 0; i < listaDeId.size(); i++) {
                preSta.setInt(i + 1, listaDeId.get(i));
            }

            // Ejecutar la consulta SQL y recuperar los resultados
            ResultSet result = preSta.executeQuery();
            while (result.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(result.getInt("id_usuario"));
                usuario.setUsuario(result.getString("usuario"));
                listaDeUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Devolver la lista de usuarios
        return listaDeUsuarios;
    }
}
