<%-- 
    Document   : aniadirComentario
    Created on : 30 may 2023, 14:08:03
    Author     : Juancarlos
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String comentario = request.getParameter("comentario");
    String valoracion = request.getParameter("valoracion");
    String idUsuarioComentario = request.getParameter("idUsuarioComentario");
    String idJuegoComentario = request.getParameter("idJuegoComentario");

    String output = ""; // Variable para almacenar la respuesta de la solicitud AJAX

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Obtener la fecha actual
        java.util.Date fechaActual = new java.util.Date();

        // Convertir la fecha actual a un objeto java.sql.Date
        java.sql.Date fechaValoracion = new java.sql.Date(fechaActual.getTime());

        // Insertar el comentario en la base de datos
        pstmt = conn.prepareStatement("INSERT INTO valoracion (comentario, opinion, id_usuario, id_juego, fecha_valoracion) VALUES (?, ?, ?, ?, ?)");
        pstmt.setString(1, comentario);
        pstmt.setString(2, valoracion);
        pstmt.setString(3, idUsuarioComentario);
        pstmt.setString(4, idJuegoComentario);
        pstmt.setDate(5, fechaValoracion);
        int rowsAffected = pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    out.print(output);
%>

