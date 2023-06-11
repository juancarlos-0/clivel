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

        int id_FAQ = Integer.parseInt(request.getParameter("id_FAQ"));

        // Eliminar registros relacionados del usuario en la tabla "amigos"
        String deleteAmigosQuery = "DELETE FROM faq WHERE id_FAQ = ?";
        PreparedStatement deleteAmigosStatement = conexion.prepareStatement(deleteAmigosQuery);
        deleteAmigosStatement.setInt(1, id_FAQ);
        deleteAmigosStatement.executeUpdate();
        deleteAmigosStatement.close();

        // Agregar los datos de respuesta al mapa
        responseMap.put("success", true);
        responseMap.put("message", "FAQ eliminado correctamente.");
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Error al eliminar el FAQ.");
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
