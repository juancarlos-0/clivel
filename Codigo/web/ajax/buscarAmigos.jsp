<%-- 
    Document   : buscarAmigos
    Created on : 12 may 2023, 22:50:15
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
    String query = request.getParameter("query");
    String output = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clivel", "root", "");
        pstmt = conn.prepareStatement("SELECT * FROM usuario WHERE usuario LIKE ? AND rol NOT LIKE 'admin'");
        pstmt.setString(1, "%" + query + "%");
        rs = pstmt.executeQuery();
        List<Map<String, String>> usuarios = new ArrayList<>();
        while (rs.next() && !query.isBlank()) {
            Map<String, String> usuario = new HashMap<>();
            usuario.put("nombre", rs.getString("usuario"));
            usuarios.add(usuario);
        }
        out.print(new Gson().toJson(usuarios));
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
    out.print(output);
%>
