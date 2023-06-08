<%@page import="modelo.Usuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String nombreAmigo = request.getParameter("nombreAmigo");
    String usuarioSesion = request.getParameter("usuarioSesion").trim();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");
        // Obtener el ID del usuario de sesión
        int idUsuarioSesion = 0;
        pstmt = conn.prepareStatement("SELECT id_usuario FROM usuario WHERE usuario = ?");
        pstmt.setString(1, usuarioSesion);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            idUsuarioSesion = rs.getInt("id_usuario");
        }

        // Consulta para obtener los usuarios que son amigos
        pstmt = conn.prepareStatement("SELECT * FROM usuario u JOIN amigos a ON u.id_usuario = a.id_usuario_amigo WHERE (a.id_usuario = ? OR a.id_usuario_amigo = ?) AND u.usuario LIKE ?");
        pstmt.setInt(1, idUsuarioSesion);
        pstmt.setInt(2, idUsuarioSesion);
        pstmt.setString(3, "%" + nombreAmigo + "%");
        rs = pstmt.executeQuery();

        List<Usuario> usuarios = new ArrayList<>();
        while (rs.next() && !nombreAmigo.isBlank()) {
            if (!rs.getString("usuario").trim().equals(usuarioSesion)) {
                Usuario usuario = new Usuario();
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setFoto(rs.getString("foto"));
                usuario.setApellidos(rs.getString("apellidos"));
                usuario.setDescripcion(rs.getString("descripcion"));
                usuarios.add(usuario);
            }
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