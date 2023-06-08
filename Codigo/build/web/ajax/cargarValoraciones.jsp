<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Valoracion" %>
<%
    // Establecer la conexión con la base de datos
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Obtener el parámetro de la consulta
        int idJuego = Integer.parseInt(request.getParameter("idJuego"));

        //Obtener el id del usuario de la sesión
        int idUsuarioSesion = Integer.parseInt(request.getParameter("idUsuarioSesion"));

        // Preparar la consulta parametrizada
        // Preparar la consulta parametrizada
        String consulta = "SELECT v.id_valoracion, v.id_juego, v.id_usuario, v.comentario, v.opinion, v.fecha_valoracion, u.foto, u.usuario, "
                + "(SELECT COUNT(*) FROM like_ WHERE id_valoracion = v.id_valoracion AND opinion = 'like') AS likes, "
                + "(SELECT COUNT(*) FROM like_ WHERE id_valoracion = v.id_valoracion AND opinion = 'dislike') AS dislikes, "
                + "l.id_like, "
                + "(SELECT COALESCE(opinion, '') FROM like_ WHERE id_valoracion = v.id_valoracion AND id_usuario = ?) AS opinionsesion "
                + "FROM valoracion v INNER JOIN usuario u ON v.id_usuario = u.id_usuario "
                + "LEFT JOIN like_ l ON v.id_valoracion = l.id_valoracion "
                + "WHERE v.id_juego = ? "
                + "GROUP BY v.id_valoracion";

        PreparedStatement statement = conexion.prepareStatement(consulta);
        statement.setObject(1, idUsuarioSesion != 0 ? idUsuarioSesion : null); // Maneja el caso cuando idUsuarioSesion es 0 o nulo
        statement.setInt(2, idJuego);

        // Ejecutar la consulta
        ResultSet resultSet = statement.executeQuery();

        // Recorrer los resultados y construir la lista de valoraciones
        List<Valoracion> valoraciones = new ArrayList<>();
        while (resultSet.next()) {
            int idValoracion = resultSet.getInt("id_valoracion");
            int idUsuario = resultSet.getInt("id_usuario");
            String comentario = resultSet.getString("comentario");
            String opinion = resultSet.getString("opinion");
            Date fechaValoracion = resultSet.getDate("fecha_valoracion");
            String imagenUsuario = resultSet.getString("foto");
            String nombreUsuario = resultSet.getString("usuario");
            int likes = resultSet.getInt("likes");
            int dislikes = resultSet.getInt("dislikes");
            int id_like = resultSet.getInt("id_like");
            String opinionsesion = resultSet.getString("opinionsesion");
            if (opinionsesion == null || opinionsesion == "") {
                opinionsesion = "";
            }

            valoraciones.add(new Valoracion(idValoracion, idJuego, idUsuario, comentario, opinion, fechaValoracion, imagenUsuario, nombreUsuario, likes, dislikes, id_like, opinionsesion));
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
