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
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Consulta para verificar si el usuario tiene una solicitud pendiente
        pstmt = conn.prepareStatement("SELECT * FROM notificacion WHERE id_usuario_notificacion = ? AND estado = 'solicitud' OR (id_usuario = ? AND estado = 'recienAceptada')");
        pstmt.setInt(1, idUsuarioSesion);
        pstmt.setInt(2, idUsuarioSesion);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // El usuario tiene una solicitud pendiente
            out.print("solicitudPendiente");
        } else {
            // El usuario no tiene ninguna solicitud pendiente
            out.print("sinSolicitudPendiente");
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