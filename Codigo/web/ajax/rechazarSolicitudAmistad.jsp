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
    int usuario = Integer.parseInt(request.getParameter("usuario"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Cuando rechaza el usuario la petición se borra de notificaciones en ambos lados
        pstmt = conn.prepareStatement("DELETE FROM notificacion WHERE (id_usuario = ? AND id_usuario_notificacion = ?) OR (id_usuario = ? AND id_usuario_notificacion = ?)");
        pstmt.setInt(1, usuario);
        pstmt.setInt(2, idUsuarioSesion);
        pstmt.setInt(3, idUsuarioSesion);
        pstmt.setInt(4, usuario);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.print("correcto");
        } else {
            out.print("incorrecto");
        }

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