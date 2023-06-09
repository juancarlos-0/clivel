<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%
    // Establecer la conexión con la base de datos
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para obtener los usuarios
        String consulta = "SELECT * FROM usuario";
        PreparedStatement statement = conexion.prepareStatement(consulta);

        // Ejecutar la consulta
        ResultSet resultSet = statement.executeQuery();

        // Recorrer los resultados y construir la lista de usuarios
        List<Usuario> usuarios = new ArrayList<>();
        while (resultSet.next()) {
            int idUsuario = resultSet.getInt("id_usuario");
            String usuario = resultSet.getString("usuario");
            String contrasenia = resultSet.getString("contrasenia");
            String nombre = resultSet.getString("nombre");
            String apellidos = resultSet.getString("apellidos");
            String correo = resultSet.getString("correo");
            Date fechaNacimiento = resultSet.getDate("fecha_nacimiento");
            String foto = resultSet.getString("foto");
            String fondo = resultSet.getString("fondo");
            String descripcion = resultSet.getString("descripcion");
            String rol = resultSet.getString("rol");
            boolean experto = resultSet.getBoolean("experto");
            String estado = resultSet.getString("estado");
            boolean usuarioCambiado = resultSet.getBoolean("usuario_cambiado");

            usuarios.add(new Usuario(idUsuario, usuario, contrasenia, nombre, apellidos, correo, fechaNacimiento, foto, fondo, descripcion, rol, experto, estado, usuarioCambiado));
        }
        // Generar la respuesta JSON
        String json = new com.google.gson.Gson().toJson(usuarios);

        // Escribir la respuesta JSON en la salida
        out.print(json);
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
%>
