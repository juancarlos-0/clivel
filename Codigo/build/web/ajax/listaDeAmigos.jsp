<%@page import="modelo.Usuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int idSesion = Integer.parseInt(request.getParameter("idSesion"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Consulta para obtener los usuarios que son amigos del usuario de sesión
        pstmt = conn.prepareStatement("SELECT u.* FROM usuario u JOIN amigos a ON u.id_usuario = a.id_usuario_amigo WHERE a.id_usuario = ?");
        pstmt.setInt(1, idSesion);
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