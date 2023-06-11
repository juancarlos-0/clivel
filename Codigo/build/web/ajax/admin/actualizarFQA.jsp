<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Usuario" %>
<%
    // Obtener los datos enviados por la llamada Ajax
    int id_FAQ = Integer.parseInt(request.getParameter("id_FAQ"));
    String pregunta = request.getParameter("pregunta");
    String respuesta = request.getParameter("respuesta");

    // Realizar la actualización en la base de datos
    Connection conexion = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para actualizar el usuario
        String consulta = "UPDATE FAQ SET pregunta=?, respuesta=? WHERE id_FAQ=?";
        statement = conexion.prepareStatement(consulta);
        statement.setString(1, pregunta);
        statement.setString(2, respuesta);
        statement.setInt(3, id_FAQ);

        // Ejecutar la consulta de actualización
        int filasActualizadas = statement.executeUpdate();

        // Verificar si se actualizó correctamente
        if (filasActualizadas > 0) {
            // La actualización fue exitosa
            out.println("Actualización exitosa");
        } else {
            // No se encontró el FQA o no se pudo realizar la actualización
            out.println("Error al actualizar FQA");
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
