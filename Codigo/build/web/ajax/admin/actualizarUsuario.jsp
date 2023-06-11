<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Usuario" %>
<%
    // Obtener los datos enviados por la llamada Ajax
    String idUsuario = request.getParameter("idUsuario");
    String usuario = request.getParameter("usuario");
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String correo = request.getParameter("correo");
    String foto = request.getParameter("foto");
    String fondo = request.getParameter("fondo");
    String descripcion = request.getParameter("descripcion");
    String rol = request.getParameter("rol");

    // Realizar la actualización en la base de datos
    Connection conexion = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para actualizar el usuario
        String consulta = "UPDATE usuario SET usuario=?, nombre=?, apellidos=?, correo=?, foto=?, fondo=?, descripcion=?, rol=? WHERE id_usuario=?";
        statement = conexion.prepareStatement(consulta);
        statement.setString(1, usuario);
        statement.setString(2, nombre);
        statement.setString(3, apellidos);
        statement.setString(4, correo);
        statement.setString(5, foto);
        statement.setString(6, fondo);
        statement.setString(7, descripcion);
        statement.setString(8, rol);
        statement.setString(9, idUsuario);

        // Ejecutar la consulta de actualización
        int filasActualizadas = statement.executeUpdate();

        // Verificar si se actualizó correctamente
        if (filasActualizadas > 0) {
            // La actualización fue exitosa
            out.println("Actualización exitosa");
        } else {
            // No se encontró el usuario o no se pudo realizar la actualización
            out.println("Error al actualizar el usuario");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerrar la conexión y el statement
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
