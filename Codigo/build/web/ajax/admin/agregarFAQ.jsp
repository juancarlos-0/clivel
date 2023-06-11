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

        // Obtener los parámetros de la solicitud
        String pregunta = request.getParameter("pregunta");
        String respuesta = request.getParameter("respuesta");

        // Insertar la nueva FAQ en la base de datos
        String insertQuery = "INSERT INTO FAQ (pregunta, respuesta) VALUES (?, ?)";
        PreparedStatement insertStatement = conexion.prepareStatement(insertQuery);
        insertStatement.setString(1, pregunta);
        insertStatement.setString(2, respuesta);
        insertStatement.executeUpdate();

        responseMap.put("success", true);
        responseMap.put("message", "La FAQ ha sido agregada correctamente.");
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Ocurrió un error al agregar la FAQ.");
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
