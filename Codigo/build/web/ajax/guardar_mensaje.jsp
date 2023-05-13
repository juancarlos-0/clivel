<%-- 
    Document   : guardar_mensaje
    Created on : 13 may 2023, 12:56:16
    Author     : Juancarlos
--%>

<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Obtener el mensaje enviado desde el cliente
    String message = request.getParameter("message");

    // Obtener el usuario actualmente autenticado
    Usuario usuario = (Usuario) session.getAttribute("datosUsuario");
    
    //Obtener el usuario al que se le envia el mensaje
    int id_usuario_envio = Integer.parseInt(request.getParameter("id_usuario_envio_mensaje"));

    // Crear una conexión a la base de datos
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

    // Insertar el mensaje en la base de datos
    PreparedStatement stmt = conn.prepareStatement("INSERT INTO mensaje "
            + "(id_usuario_emisor, id_usuario_receptor, tipo, mensaje_texto, "
            + "mensaje_binario, fecha_envio, enviado, visto) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    stmt.setInt(1, usuario.getId_usuario());
    stmt.setInt(2, id_usuario_envio);
    stmt.setString(3, "texto");
    stmt.setString(4, message);
    stmt.setString(5, null);
    stmt.setDate(6, new java.sql.Date(Calendar.getInstance().getTime().getTime()));
    stmt.setBoolean(7, false);
    stmt.setBoolean(8, false);
    stmt.executeUpdate();

    // Cerrar la conexión a la base de datos
    conn.close();

%>
