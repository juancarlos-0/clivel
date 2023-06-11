<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Juego" %>
<%
    // Establecer la conexión con la base de datos
    Connection conexion = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Preparar la consulta para obtener los juegos con los comentarios sumados
        String consulta = "SELECT j.id_juego, j.nombre, j.fechaLanzamiento, "
                + "(SELECT COUNT(*) FROM valoracion v WHERE v.id_juego = j.id_juego) AS comentarios "
                + "FROM juego j";
        PreparedStatement statement = conexion.prepareStatement(consulta);

        // Ejecutar la consulta
        ResultSet resultSet = statement.executeQuery();

        // Recorrer los resultados y construir la lista de juegos
        List<Juego> juegos = new ArrayList<>();
        while (resultSet.next()) {
            int idJuego = resultSet.getInt("id_juego");
            String nombre = resultSet.getString("nombre");
            String fechaLanzamiento = resultSet.getString("fechaLanzamiento");
            int comentarios = resultSet.getInt("comentarios");

            juegos.add(new Juego(idJuego, nombre, fechaLanzamiento, comentarios));
        }
        // Generar la respuesta JSON
        String json = new com.google.gson.Gson().toJson(juegos);

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
