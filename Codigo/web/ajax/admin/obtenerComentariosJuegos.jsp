<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Valoracion" %>
<%
    // Obtener el parámetro de ID del juego
    String idJuego = request.getParameter("id_juego");

    // Establecer la conexión con la base de datos
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para obtener las valoraciones del juego con la cantidad de "Me gusta" y "No me gusta"
        String consulta = "SELECT v.id_valoracion, j.nombre AS nombre_juego, u.usuario AS nombre_usuario, v.comentario, v.opinion, v.fecha_valoracion, "
                + "(SELECT COUNT(*) FROM `like_` WHERE id_valoracion = v.id_valoracion AND opinion = 'like') AS likes, "
                + "(SELECT COUNT(*) FROM `like_` WHERE id_valoracion = v.id_valoracion AND opinion = 'dislike') AS dislikes "
                + "FROM valoracion v "
                + "JOIN juego j ON v.id_juego = j.id_juego "
                + "JOIN usuario u ON v.id_usuario = u.id_usuario "
                + "WHERE v.id_juego = ?";
        PreparedStatement statement = conexion.prepareStatement(consulta);
        statement.setString(1, idJuego);

        // Ejecutar la consulta
        ResultSet resultSet = statement.executeQuery();

        // Recorrer los resultados y construir la lista de valoraciones
        List<Valoracion> valoraciones = new ArrayList<>();
        while (resultSet.next()) {
            int idValoracion = resultSet.getInt("id_valoracion");
            String nombreJuego = resultSet.getString("nombre_juego");
            String nombreUsuario = resultSet.getString("nombre_usuario");
            String comentario = resultSet.getString("comentario");
            String opinion = resultSet.getString("opinion");
            Date fechaValoracion = resultSet.getDate("fecha_valoracion");
            int meGusta = resultSet.getInt("likes");
            int noMeGusta = resultSet.getInt("dislikes");

            Valoracion valoracion = new Valoracion();
            valoracion.setId_valoracion(idValoracion);
            valoracion.setNombre_juego(nombreJuego);
            valoracion.setNombre_usuario(nombreUsuario);
            valoracion.setComentario(comentario);
            valoracion.setOpinion(opinion);
            valoracion.setFecha_valoracion(fechaValoracion);
            valoracion.setLikes(meGusta);
            valoracion.setDislikes(noMeGusta);

            valoraciones.add(valoracion);
        }

        // Generar la respuesta JSON
        String json = new com.google.gson.Gson().toJson(valoraciones);

        // Escribir la respuesta JSON en la salida
        out.print(json);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerrar la conexión
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
