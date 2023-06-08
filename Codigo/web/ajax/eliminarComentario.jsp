<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        int idValoracionModal = Integer.parseInt(request.getParameter("idValoracionModal"));

        // Eliminar de la tabla "like"
        String deleteLikeQuery = "DELETE FROM like_ WHERE id_valoracion = ?";
        PreparedStatement deleteLikeStatement = conexion.prepareStatement(deleteLikeQuery);
        deleteLikeStatement.setInt(1, idValoracionModal);
        deleteLikeStatement.executeUpdate();
        deleteLikeStatement.close();

        // Eliminar de la otra tabla
        String deleteValoracionQuery = "DELETE FROM valoracion WHERE id_valoracion = ?";
        PreparedStatement deleteValoracionStatement = conexion.prepareStatement(deleteValoracionQuery);
        deleteValoracionStatement.setInt(1, idValoracionModal);
        deleteValoracionStatement.executeUpdate();
        deleteValoracionStatement.close();

    } catch (Exception e) {
        e.printStackTrace();
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
    String jsonResponse = new com.google.gson.Gson().toJson("ComentarioEliminado");

    // Escribir la respuesta JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonResponse);
%>
