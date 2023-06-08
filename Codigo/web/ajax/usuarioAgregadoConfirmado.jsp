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

        // Actualizar el estado de la notificación a "aceptada"
        pstmt = conn.prepareStatement("UPDATE notificacion SET estado = 'aceptada' WHERE id_usuario = ? AND id_usuario_notificacion = ?");
        pstmt.setInt(1, idUsuarioSesion);
        pstmt.setInt(2, usuario);
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