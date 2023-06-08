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

        // Verificar si existe una valoración para el usuario y juego especificados
        PreparedStatement selectStatement = conn.prepareStatement("SELECT id_valoracion FROM valoracion WHERE id_usuario = ? AND id_juego = ?");
        selectStatement.setString(1, idUsuarioComentario);
        selectStatement.setString(2, idJuegoComentario);
        ResultSet resultSet = selectStatement.executeQuery();

        if (resultSet.next()) {
            // Ya existe una valoración, realizar la actualización
            int idValoracion = resultSet.getInt("id_valoracion");

            PreparedStatement updateStatement = conn.prepareStatement("UPDATE valoracion SET comentario = ?, opinion = ? WHERE id_valoracion = ?");
            updateStatement.setString(1, comentario);
            updateStatement.setString(2, valoracion);
            updateStatement.setInt(3, idValoracion);
            int rowsUpdated = updateStatement.executeUpdate();

            updateStatement.close();
        } else {
            // No existe una valoración, realizar la inserción
            PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO valoracion (comentario, opinion, id_usuario, id_juego, fecha_valoracion) VALUES (?, ?, ?, ?, ?)");
            insertStatement.setString(1, comentario);
            insertStatement.setString(2, valoracion);
            insertStatement.setString(3, idUsuarioComentario);
            insertStatement.setString(4, idJuegoComentario);
            insertStatement.setDate(5, fechaValoracion);
            int rowsInserted = insertStatement.executeUpdate();

            insertStatement.close();
        }

        resultSet.close();
        selectStatement.close();

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

