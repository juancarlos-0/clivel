<%@ page contentType="application/json" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.FAQ" %>
<%@ page import="com.google.gson.Gson" %>

<%
    // Establecer la conexión con la base de datos
    Connection conexion = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");

        // Realizar la consulta para obtener las preguntas frecuentes
        String consulta = "SELECT id_FAQ, pregunta, respuesta FROM FAQ";
        statement = conexion.createStatement();
        resultSet = statement.executeQuery(consulta);

        // Crear una lista para almacenar las preguntas frecuentes
        List<FAQ> preguntasFrecuentes = new ArrayList<>();

        // Recorrer los resultados de la consulta
        while (resultSet.next()) {
            int id_FAQ = resultSet.getInt("id_FAQ");
            String pregunta = resultSet.getString("pregunta");
            String respuesta = resultSet.getString("respuesta");

            // Crear un objeto PreguntaFrecuente y agregarlo a la lista
            FAQ preguntaFrecuente = new FAQ(id_FAQ, pregunta, respuesta);
            preguntasFrecuentes.add(preguntaFrecuente);
        }

        // Generar la respuesta JSON
        String json = new Gson().toJson(preguntasFrecuentes);

        // Escribir la respuesta JSON en la salida
        out.print(json);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerrar los recursos y la conexión
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
