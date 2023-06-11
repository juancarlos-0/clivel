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
        String usuario = request.getParameter("usuario");
        String contrasenia = request.getParameter("contrasenia");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String correo = request.getParameter("correo");
        String fechaNacimiento = request.getParameter("fechaNacimiento");

        // Insertar el nuevo usuario en la base de datos
        String insertQuery = "INSERT INTO usuario (usuario, contrasenia, nombre, apellidos, correo, rol, experto, estado, fecha_nacimiento, usuario_cambiado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement insertStatement = conexion.prepareStatement(insertQuery);
        insertStatement.setString(1, usuario);
        insertStatement.setString(2, contrasenia);
        insertStatement.setString(3, nombre);
        insertStatement.setString(4, apellidos);
        insertStatement.setString(5, correo);
        insertStatement.setString(6, "admin");
        insertStatement.setBoolean(7, true);
        insertStatement.setString(8, "desconectado");
        insertStatement.setString(9, fechaNacimiento);
        insertStatement.setBoolean(10, false);
        insertStatement.executeUpdate();

        responseMap.put("success", true);
        responseMap.put("message", "El usuario ha sido agregado correctamente.");
    } catch (Exception e) {
        e.printStackTrace();
        responseMap.put("success", false);
        responseMap.put("message", "Ocurrió un error al agregar el usuario.");
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
