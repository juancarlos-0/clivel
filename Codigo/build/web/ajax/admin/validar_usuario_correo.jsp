<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%
    // Obtener los valores enviados por la llamada Ajax
    String idUsuario = request.getParameter("idUsuario");
    String usuario = request.getParameter("usuario");
    String correo = request.getParameter("correo");

    // Lógica para comprobar la existencia del usuario y el correo en otras columnas
    boolean usuarioExistente = false;
    boolean correoExistente = false;

    // Establecer la conexión con la base de datos
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para comprobar la existencia del usuario
        String consultaUsuario = "SELECT COUNT(*) AS total FROM usuario WHERE usuario = ? AND id_usuario != ?";
        PreparedStatement statementUsuario = conexion.prepareStatement(consultaUsuario);
        statementUsuario.setString(1, usuario);
        statementUsuario.setString(2, idUsuario);

        // Ejecutar la consulta
        ResultSet resultSetUsuario = statementUsuario.executeQuery();
        if (resultSetUsuario.next()) {
            int totalUsuarios = resultSetUsuario.getInt("total");
            if (totalUsuarios > 0) {
                usuarioExistente = true;
            }
        }

        // Preparar la consulta para comprobar la existencia del correo
        String consultaCorreo = "SELECT COUNT(*) AS total FROM usuario WHERE correo = ? AND id_usuario != ?";
        PreparedStatement statementCorreo = conexion.prepareStatement(consultaCorreo);
        statementCorreo.setString(1, correo);
        statementCorreo.setString(2, idUsuario);

        // Ejecutar la consulta
        ResultSet resultSetCorreo = statementCorreo.executeQuery();
        if (resultSetCorreo.next()) {
            int totalCorreos = resultSetCorreo.getInt("total");
            if (totalCorreos > 0) {
                correoExistente = true;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
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

    // Preparar la respuesta en formato JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    String jsonResponse = "{\"usuarioExistente\": " + usuarioExistente + ", \"correoExistente\": " + correoExistente + "}";

    // Enviar la respuesta al cliente
    response.getWriter().write(jsonResponse);
%>
