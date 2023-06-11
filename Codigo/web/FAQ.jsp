<%-- 
    Document   : FAQ
    Created on : 11 jun 2023, 22:20:54
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>FAQ</title>
        <link rel="stylesheet" href="estilos/faq.css"/>
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <script src="script/jquery-3.7.0.min.js"></script>
        <script src="script/faq.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <c:if test="${not empty sessionScope.datosUsuario}">
                    <link rel="stylesheet" href="estilos/estiloIconosImagen.css"/>
                    <div class="dropdown">
                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="${sessionScope.datosUsuario.getFoto() != null && sessionScope.datosUsuario.getFoto() != '' ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="49px" height="49px" class="rounded-circle"/>
                        </a>

                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <li><a class="dropdown-item dropdown-item-icon" href="perfil.jsp">Editar usuario<i class="bi bi-person-circle"></i></a></li>
                            <li><a class="dropdown-item dropdown-item-icon" href="Cerrar_sesion">Cerrar sesión<i class="bi bi-box-arrow-right"></i></a></li>
                        </ul>

                    </div>

                </c:if>
                <c:if test="${empty sessionScope.datosUsuario}">
                    <a class="navbar-brand" href="#">
                        CLIVEL
                    </a>
                </c:if>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                        </li>
                        <c:if test="${not empty sessionScope.datosUsuario}">
                            <li class="nav-item">
                                <a class="nav-link" href="Preparar_amigos">Amigos</a>
                            </li>
                        </c:if>
                        <c:if test="${empty sessionScope.datosUsuario}">
                            <li class="nav-item">
                                <a class="nav-link" href="amigos.jsp">Amigos</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="comunidades.jsp">Comunidad</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="juegos.jsp">Juegos</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <h1 class="text-center mt-5">Preguntas frecuentes</h1>

        <div id="preguntasYRespuestas" class="mt-4">
            <%-- Utiliza un loop para recorrer el mapa de preguntas y respuestas --%>
            <c:forEach var="entry" items="${faqMap}">
                <h3 class="pregunta">${entry.key}</h3>
                <p class="respuesta">${entry.value}</p>
            </c:forEach>
        </div>

        <footer>
            <p><a href="faq">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
            <p>© 2023 Clivel - Todos los derechos reservados</p>
        </footer>

        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
