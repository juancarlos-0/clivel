<%-- 
    Document   : buscarAmigos
    Created on : 12 may 2023, 22:50:15
    Author     : Juancarlos
--%>

<%@page import="modelo.Usuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String nombreUsuario = request.getParameter("nombreAmigo");
    String usuarioSesion = request.getParameter("usuarioNombre");
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

        // Consulta principal para obtener los usuarios
        pstmt = conn.prepareStatement("SELECT * FROM usuario WHERE usuario LIKE ? AND id_usuario NOT IN (SELECT id_usuario_amigo FROM amigos WHERE id_usuario = ?) AND id_usuario NOT IN (SELECT id_usuario FROM amigos WHERE id_usuario_amigo = ?) AND rol != 'admin'");
        pstmt.setString(1, "%" + nombreUsuario + "%");
        pstmt.setInt(2, idUsuarioSesion);
        pstmt.setInt(3, idUsuarioSesion);
        rs = pstmt.executeQuery();

        List<Usuario> usuarios = new ArrayList<>();
        while (rs.next() && !nombreUsuario.isBlank()) {
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

