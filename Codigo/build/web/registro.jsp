<%-- 
    Document   : registro
    Created on : 24 abr 2023, 0:01:18
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link rel="stylesheet" href="estilos/registro.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <script src="script/registro.js"></script>
    </head>
    <body>
        <h1>REGISTRO</h1>
        <form method="POST" action="Comprobar_registro_de_usuario">
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" id="usuario" name="usuario" placeholder="Introduce tu nombre de usuario" value="${usuario}">
            </div>
            <c:if test="${not empty usuarioFallo}">
                <p style="color: red;">${usuarioFallo}</p>
            </c:if>
            <div class="form-group">
                <label for="contrasenia">Contraseña</label>
                <input type="text" id="contrasenia" name="contrasenia" placeholder="Introduce tu contraseña" value="${contra}">
            </div>
            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" placeholder="Introduce tu nombre" value="${nombre}">
            </div>
            <div class="form-group">
                <label for="apellidos">Apellidos</label>
                <input type="text" id="apellidos" name="apellidos" placeholder="Introduce tus apellidos" value="${apellidos}">
            </div>
            <div class="form-group">
                <label for="fecha-nacimiento">Fecha de nacimiento</label>
                <input type="date" id="fecha-nacimiento" name="fecha-nacimiento" min="1940-01-01" max="2008-12-31" value="${fecha}">
            </div>
            <div class="form-group">
                <label for="correo">Correo electrónico</label>
                <input type="email" id="correo" name="correo" placeholder="Introduce tu correo electrónico" value="${correo}">
            </div>
            <c:if test="${not empty correoFallo}">
                <p style="color: red;">${correoFallo}</p>
            </c:if>
            <button type="submit" id="enviar" name="enviar">Registrarse</button>
        </form>

    </body>
</html>
