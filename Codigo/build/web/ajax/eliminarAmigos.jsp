<%@page import="modelo.Usuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usuarioInput = request.getParameter("usuarioInput");
    int idUsuarioSesion = Integer.parseInt(request.getParameter("idUsuarioSesion"));
    int idUsuarioInput = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Obtener el ID del usuarioInput
        pstmt = conn.prepareStatement("SELECT id_usuario FROM usuario WHERE usuario = ?");
        pstmt.setString(1, usuarioInput);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            idUsuarioInput = rs.getInt("id_usuario");
        }

        // Verificar relación de amistad en la tabla amigos
        pstmt = conn.prepareStatement("SELECT * FROM amigos WHERE (id_usuario = ? AND id_usuario_amigo = ?) OR (id_usuario = ? AND id_usuario_amigo = ?)");
        pstmt.setInt(1, idUsuarioSesion);
        pstmt.setInt(2, idUsuarioInput);
        pstmt.setInt(3, idUsuarioInput);
        pstmt.setInt(4, idUsuarioSesion);
        rs = pstmt.executeQuery();

        boolean sonAmigos = rs.next();

        // Si son amigos borrarlo
        if (sonAmigos) {
            // Eliminar amigos
            pstmt = conn.prepareStatement("DELETE FROM amigos WHERE (id_usuario = ? AND id_usuario_amigo = ?) OR (id_usuario = ? AND id_usuario_amigo = ?)");
            pstmt.setInt(1, idUsuarioSesion);
            pstmt.setInt(2, idUsuarioInput);
            pstmt.setInt(3, idUsuarioInput);
            pstmt.setInt(4, idUsuarioSesion);
            pstmt.executeUpdate();

            // Eliminar notificacion permitiendo que se puedan volver a agregar
            pstmt = conn.prepareStatement("DELETE FROM notificacion WHERE (id_usuario = ? AND id_usuario_notificacion = ?) OR (id_usuario_notificacion = ? AND id_usuario = ?)");
            pstmt.setInt(1, idUsuarioSesion);
            pstmt.setInt(2, idUsuarioInput);
            pstmt.setInt(3, idUsuarioInput);
            pstmt.setInt(4, idUsuarioSesion);
            pstmt.executeUpdate();

            out.print("eliminadoConExito");
        } else {
            out.print("noRegistradoComoAmigo");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>