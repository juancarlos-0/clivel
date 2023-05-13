<%-- 
    Document   : cargar_mensajes_anteriores
    Created on : 13 may 2023, 13:56:37
    Author     : Juancarlos
--%>

<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Obtener el usuario actualmente autenticado
    Usuario usuario = (Usuario) session.getAttribute("datosUsuario");
    
    // Obtener el id del otro usuario
    int id_otro_usuario = Integer.parseInt(request.getParameter("id_usuario_envio_mensaje"));

    // Crear una conexión a la base de datos
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Obtener todos los mensajes del chat entre los dos usuarios, ordenados por fecha de envío
        stmt = conn.prepareStatement("SELECT * FROM mensaje WHERE ((id_usuario_emisor = ? AND id_usuario_receptor = ?) OR (id_usuario_emisor = ? AND id_usuario_receptor = ?)) ORDER BY fecha_envio ASC");
        stmt.setInt(1, usuario.getId_usuario());
        stmt.setInt(2, id_otro_usuario);
        stmt.setInt(3, id_otro_usuario);
        stmt.setInt(4, usuario.getId_usuario());
        rs = stmt.executeQuery();
        
        // Construir el HTML de los mensajes
        StringBuilder sb = new StringBuilder();
        while (rs.next()) {
            int id_emisor = rs.getInt("id_usuario_emisor");
            String mensaje = rs.getString("mensaje_texto");

            // Identificar si el mensaje es enviado o recibido y aplicar el estilo correspondiente
            if (id_emisor == usuario.getId_usuario()) {
                // Mensaje enviado
                sb.append("<div class=\"bocadillo bocadillo-izquierda\">\n");
                sb.append("<p class=\"card-text textoIzquierda\">");
                sb.append(mensaje);
                sb.append("</p>\n");
                sb.append("</div>\n");
            } else {
                // Mensaje recibido
                sb.append("<div class=\"bocadillo bocadillo-derecha\">\n");
                sb.append("<p class=\"card-text text-end textoDerecha\">");
                sb.append(mensaje);
                sb.append("</p>\n");
                sb.append("</div>\n");
            }
        }
        
        // Actualizar el campo 'enviado' a 'true' en todos los mensajes devueltos por la consulta
        stmt = conn.prepareStatement("UPDATE mensaje SET enviado = true WHERE "
        + "(id_usuario_emisor = ? AND id_usuario_receptor = ?) OR "
        + "(id_usuario_receptor = ? AND id_usuario_emisor = ?)");
        stmt.setInt(1, id_otro_usuario);
        stmt.setInt(2, usuario.getId_usuario());
        stmt.setInt(3, id_otro_usuario);
        stmt.setInt(4, usuario.getId_usuario());
        stmt.executeUpdate();

        // Devolver el HTML de los mensajes para actualizar la vista del chat
        out.print(sb.toString());
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar los objetos de la base de datos
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

%>
