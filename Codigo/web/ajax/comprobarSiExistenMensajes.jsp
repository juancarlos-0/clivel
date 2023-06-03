<%-- 
    Document   : comprobarSiExistenMensajes
    Created on : 15 may 2023, 2:47:24
    Author     : Juancarlos
--%>


<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Obtener el ID de usuario actual del parámetro de solicitud
    int idUsuarioActual = Integer.parseInt(request.getParameter("idUsuarioActual"));

    // Obtener el ID de usuario con el que habla
    int idUsuarioChat = Integer.parseInt(request.getParameter("idUsuarioChat"));

    // Crear una conexión a la base de datos
    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement stmt2 = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Obtener los mensajes no vistos del usuario autenticado
        stmt = conn.prepareStatement("SELECT * FROM mensaje WHERE "
                + "id_usuario_emisor = ? AND id_usuario_receptor = ? AND enviado = 0");

        stmt.setInt(1, idUsuarioChat);
        stmt.setInt(2, idUsuarioActual);
        rs = stmt.executeQuery();

        // Construir el HTML de los mensajes no vistos y marcarlos como vistos
        StringBuilder sb = new StringBuilder();
        // Verificar si hay mensajes no vistos y mostrar el icono de mensaje en consecuencia
        if (rs.next()) {
            sb.append("<i class='bi bi-chat'></i>");
        }

        // Devolver el HTML de los mensajes no vistos para actualizar la vista del chat
        out.print(sb.toString());
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar los objetos de la base de datos
        if (rs != null) {
            rs.close();
        }
        if (stmt2 != null) {
            stmt2.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
