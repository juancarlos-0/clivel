<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>


<%
    // Crear un mapa para almacenar los datos de respuesta
    Map<String, Object> responseMap = new HashMap<>();

    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        int idValoracion = Integer.parseInt(request.getParameter("idValoracion"));
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

        String updateQuery = "UPDATE like_ SET opinion = 'like' "
                + "WHERE id_valoracion = ? AND id_usuario = ?";

        PreparedStatement updateStatement = conexion.prepareStatement(updateQuery);
        updateStatement.setInt(1, idValoracion);
        updateStatement.setInt(2, idUsuario);

        int rowsUpdated = updateStatement.executeUpdate();
        updateStatement.close();

        if (rowsUpdated == 0) {
            // No se encontró ninguna fila para actualizar, realiza la inserción
            String insertQuery = "INSERT INTO like_ (id_valoracion, id_usuario, opinion) VALUES (?, ?, 'like')";

            PreparedStatement insertStatement = conexion.prepareStatement(insertQuery);
            insertStatement.setInt(1, idValoracion);
            insertStatement.setInt(2, idUsuario);

            insertStatement.executeUpdate();
            insertStatement.close();
        }

        // Agregar los datos de respuesta al mapa
        responseMap.put("idValoracion", idValoracion);
        // Valor no utilizado
        responseMap.put("likesCount", 10);
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
    String jsonResponse = new com.google.gson.Gson().toJson(responseMap);

    // Escribir la respuesta JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonResponse);
%>
