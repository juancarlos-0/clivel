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

        // Si son amigos controlar el mensaje
        if (sonAmigos) {
            // Son amigos, enviar mensaje personalizado
            out.print("sonAmigos");
        } else {
            // Verificar la existencia del ID de usuarioInput
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM usuario WHERE id_usuario = ?");
            pstmt.setInt(1, idUsuarioInput);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");

                if (count > 0) {
                    // Verificar si ya se ha enviado una solicitud de amistad
                    pstmt = conn.prepareStatement("SELECT * FROM notificacion WHERE id_usuario = ? AND id_usuario_notificacion = ? AND estado = 'solicitud'");
                    pstmt.setInt(1, idUsuarioSesion);
                    pstmt.setInt(2, idUsuarioInput);
                    rs = pstmt.executeQuery();

                    boolean solicitudEnviada = rs.next();

                    if (solicitudEnviada) {
                        out.print("yaExisteSolicitud");
                    } else {
                        // Insertar en la tabla amigos en ambas direcciones
                        pstmt = conn.prepareStatement("INSERT INTO notificacion (id_usuario, id_usuario_notificacion, estado) VALUES (?, ?, 'solicitud')");
                        pstmt.setInt(1, idUsuarioSesion);
                        pstmt.setInt(2, idUsuarioInput);
                        int filasInsertadas1 = pstmt.executeUpdate();

                        if (filasInsertadas1 > 0) {
                            out.print("Solicitud enviada");
                        } else {
                            out.print("Error");
                        }
                    }

                } else {
                    // El ID de usuarioInput no existe
                    out.print("noExiste");
                }
            }

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