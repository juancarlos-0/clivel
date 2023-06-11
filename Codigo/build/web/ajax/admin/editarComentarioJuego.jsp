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

        // Obtener los par�metros enviados desde el cliente
        int idValoracion = Integer.parseInt(request.getParameter("id_valoracion"));
        String nuevoComentario = request.getParameter("nuevo_comentario");

        // Actualizar el comentario en la tabla valoraci�n
        String actualizarComentarioQuery = "UPDATE valoracion SET comentario = ? WHERE id_valoracion = ?";
        PreparedStatement actualizarComentarioStatement = conexion.prepareStatement(actualizarComentarioQuery);
        actualizarComentarioStatement.setString(1, nuevoComentario);
        actualizarComentarioStatement.setInt(2, idValoracion);
        int filasAfectadas = actualizarComentarioStatement.executeUpdate();

        if (filasAfectadas > 0) {
            // El comentario se actualiz� correctamente
            responseMap.put("success", true);
            responseMap.put("message", "Comentario actualizado correctamente.");
        } else {
            // No se encontr� la valoraci�n o no se pudo actualizar el comentario
            responseMap.put("success", false);
            responseMap.put("message", "No se encontr� la valoraci�n o no se pudo actualizar el comentario.");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Error al actualizar el comentario.");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        // Cerrar la conexi�n
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
