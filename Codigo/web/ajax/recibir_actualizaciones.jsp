<%-- 
    Document   : recibir_actualizaciones
    Created on : 13 may 2023, 12:56:32
    Author     : Juancarlos
--%>

<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Obtener el usuario actualmente autenticado
    int usuarioEmisor = Integer.parseInt(request.getParameter("id_usuario_envio_mensaje"));

    // Obtener el usuario actualmente autenticado
    Usuario usuario = (Usuario) session.getAttribute("datosUsuario");

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

        stmt.setInt(1, usuarioEmisor);
        stmt.setInt(2, usuario.getId_usuario());
        rs = stmt.executeQuery();

        // Construir el HTML de los mensajes no vistos y marcarlos como vistos
        StringBuilder sb = new StringBuilder();
        while (rs.next()) {
            sb.append("<div class=\"bocadillo bocadillo-derecha\">").append("<p class='card-text text-end textoDerecha'>").append(rs.getString("mensaje_texto")).append("</p>").append("</div>");
        }

        stmt2 = conn.prepareStatement("UPDATE mensaje SET enviado = 1 WHERE id_usuario_emisor = ? AND id_usuario_receptor = ? AND enviado = 0");
        stmt2.setInt(1, usuarioEmisor);
        stmt2.setInt(2, usuario.getId_usuario());
        stmt2.executeUpdate();

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
