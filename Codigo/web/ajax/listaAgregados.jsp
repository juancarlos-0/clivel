<%@page import="modelo.Usuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int idUsuarioSesion = Integer.parseInt(request.getParameter("idUsuarioSesion"));
    String solicitud = request.getParameter("solicitud");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Consulta para verificar si el usuario tiene una solicitud pendiente
        pstmt = conn.prepareStatement("SELECT u.* FROM usuario u JOIN notificacion n ON u.id_usuario = n.id_usuario_notificacion WHERE n.id_usuario = ? AND n.estado = ?");
        pstmt.setInt(1, idUsuarioSesion);
        pstmt.setString(2, solicitud);
        rs = pstmt.executeQuery();

        List<Usuario> usuarios = new ArrayList<>();
        while (rs.next()) {
            Usuario usuario = new Usuario();
            usuario.setUsuario(rs.getString("usuario"));
            usuario.setId_usuario(rs.getInt("id_usuario"));
            usuario.setNombre(rs.getString("nombre"));
            usuario.setFoto(rs.getString("foto"));
            usuario.setApellidos(rs.getString("apellidos"));
            usuario.setDescripcion(rs.getString("descripcion"));
            usuarios.add(usuario);
        }

        out.print(new Gson().toJson(usuarios));
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }


%>