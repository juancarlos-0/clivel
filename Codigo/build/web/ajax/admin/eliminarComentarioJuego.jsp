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

        // Obtener el id de la valoración
        int idValoracion = Integer.parseInt(request.getParameter("id_valoracion"));

        // Eliminar los registros de la tabla `like_` relacionados con la valoración
        String eliminarLikesQuery = "DELETE FROM like_ WHERE id_valoracion = ?";
        PreparedStatement eliminarLikesStatement = conexion.prepareStatement(eliminarLikesQuery);
        eliminarLikesStatement.setInt(1, idValoracion);
        eliminarLikesStatement.executeUpdate();

        // Eliminar la valoración de la tabla `valoracion`
        String eliminarValoracionQuery = "DELETE FROM valoracion WHERE id_valoracion = ?";
        PreparedStatement eliminarValoracionStatement = conexion.prepareStatement(eliminarValoracionQuery);
        eliminarValoracionStatement.setInt(1, idValoracion);
        eliminarValoracionStatement.executeUpdate();

        // Agregar los datos de respuesta al mapa
        responseMap.put("success", true);
        responseMap.put("message", "Comentario eliminado correctamente.");
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Error al eliminar el comentario.");
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
