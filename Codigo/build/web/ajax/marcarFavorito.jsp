<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Usuario" %>
<%
    // Obtener los parámetros de la solicitud
    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
    int idSesion = Integer.parseInt(request.getParameter("idSesion"));

    // Establecer la conexión con la base de datos
    Connection conexion = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Consultar si el usuario es favorito o no
        pstmt = conexion.prepareStatement("SELECT COUNT(*) AS es_favorito FROM amigos WHERE id_usuario = ? AND id_usuario_amigo = ? AND favorito = 1");
        pstmt.setInt(1, idSesion);
        pstmt.setInt(2, idUsuario);
        rs = pstmt.executeQuery();

        boolean esFavorito = false;
        if (rs.next()) {
            int count = rs.getInt("es_favorito");
            esFavorito = (count > 0);
        }

        // Actualizar la tabla de amigos según el estado del favorito
        pstmt = conexion.prepareStatement("UPDATE amigos SET favorito = ? WHERE id_usuario = ? AND id_usuario_amigo = ?");
        pstmt.setBoolean(1, !esFavorito);
        pstmt.setInt(2, idSesion);
        pstmt.setInt(3, idUsuario);
        pstmt.executeUpdate();

        // Crear el objeto JSON con la respuesta
        String json = new com.google.gson.Gson().toJson(!esFavorito);

        // Escribir la respuesta JSON en la salida
        out.print(json);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerrar la conexión
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
