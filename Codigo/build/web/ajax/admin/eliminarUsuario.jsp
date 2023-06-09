<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // Crear un mapa para almacenar los datos de respuesta
    Map<String, Object> responseMap = new HashMap<>();

    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

        // Eliminar registros relacionados del usuario en la tabla "amigos"
        String deleteAmigosQuery = "DELETE FROM amigos WHERE id_usuario = ? OR id_usuario_amigo = ?";
        PreparedStatement deleteAmigosStatement = conexion.prepareStatement(deleteAmigosQuery);
        deleteAmigosStatement.setInt(1, idUsuario);
        deleteAmigosStatement.setInt(2, idUsuario);
        deleteAmigosStatement.executeUpdate();
        deleteAmigosStatement.close();

        // Eliminar mensajes enviados por el usuario de la tabla "mensaje"
        String deleteMensajeQuery = "DELETE FROM mensaje WHERE id_usuario_emisor = ? OR id_usuario_receptor = ?";
        PreparedStatement deleteMensajeStatement = conexion.prepareStatement(deleteMensajeQuery);
        deleteMensajeStatement.setInt(1, idUsuario);
        deleteMensajeStatement.setInt(2, idUsuario);
        deleteMensajeStatement.executeUpdate();
        deleteMensajeStatement.close();

        // Eliminar registros de "like_" asociados al usuario
        String deleteLikeQuery = "DELETE FROM like_ WHERE id_usuario = ?";
        PreparedStatement deleteLikeStatement = conexion.prepareStatement(deleteLikeQuery);
        deleteLikeStatement.setInt(1, idUsuario);
        deleteLikeStatement.executeUpdate();
        deleteLikeStatement.close();

        // Eliminar notificaciones relacionadas con el usuario de la tabla "notificacion"
        String deleteNotificacionQuery = "DELETE FROM notificacion WHERE id_usuario = ? OR id_usuario_notificacion = ?";
        PreparedStatement deleteNotificacionStatement = conexion.prepareStatement(deleteNotificacionQuery);
        deleteNotificacionStatement.setInt(1, idUsuario);
        deleteNotificacionStatement.setInt(2, idUsuario);
        deleteNotificacionStatement.executeUpdate();
        deleteNotificacionStatement.close();

        // Eliminar valoraciones asociadas al usuario
        String deleteValoracionQuery = "DELETE FROM valoracion WHERE id_usuario = ?";
        PreparedStatement deleteValoracionStatement = conexion.prepareStatement(deleteValoracionQuery);
        deleteValoracionStatement.setInt(1, idUsuario);
        deleteValoracionStatement.executeUpdate();
        deleteValoracionStatement.close();

        // Eliminar usuario de la tabla "usuario"
        String deleteUsuarioQuery = "DELETE FROM usuario WHERE id_usuario = ?";
        PreparedStatement deleteUsuarioStatement = conexion.prepareStatement(deleteUsuarioQuery);
        deleteUsuarioStatement.setInt(1, idUsuario);
        deleteUsuarioStatement.executeUpdate();
        deleteUsuarioStatement.close();

        // Agregar los datos de respuesta al mapa
        responseMap.put("success", true);
        responseMap.put("message", "Usuario eliminado correctamente.");
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Error al eliminar el usuario.");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        // Cerrar la conexión
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Convertir el mapa de respuesta a formato JSON
    String jsonResponse = new com.google.gson.Gson().toJson(responseMap);

    // Escribir la respuesta JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonResponse);
%>
