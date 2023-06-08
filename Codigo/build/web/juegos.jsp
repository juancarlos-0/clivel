<%-- 
    Document   : juegos
    Created on : 20 may 2023, 11:59:25
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Juegos</title>
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="estilos/juegos.css"/>
        <script src="script/jquery-3.7.0.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css" />
        <script src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>

    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark navbarPrincipal">
            <div class="container-fluid">
                <div class="dropdown">
                    <c:if test="${not empty sessionScope.datosUsuario}">
                        <div class="dropdown">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="${sessionScope.datosUsuario.getFoto() != null ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="50px" height="46px" class="rounded-circle"/>
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

                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <li><a class="dropdown-item dropdown-item-icon" href="Cerrar_sesion">Cerrar sesión<i class="bi bi-box-arrow-right"></i></a></li>
                    </ul>
                </div>
                
                <!-- Contenido en el centro (buscador) -->
                <div class="d-flex flex-grow-1 justify-content-center">
                    <form class="formularioBusqueda w-75">
                        <i class="bi bi-search"></i>
                        <input type="text" id="busqueda" placeholder="Buscar..." class="buscador" autocomplete="offb">
                    </form>
                </div>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="index.jsp">Home</a>
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
                            <a class="nav-link active" href="juegos.jsp">Juegos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Noticias</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <h1>Videojuegos</h1>
            <div class="contenedorBuscar">
                <div>
                    <select id="desplegable1">
                        <option value="" selected="selected" style="display: none">
                        <span class="default-text">Ordenado por: </span>
                        </option>
                        <option value="popularidad">Popularidad</option>
                        <option value="valoracion">Valoración (De mejor a peor)</option>
                        <option value="valoracionMala">Valoración (De peor a mejor)</option>
                    </select>
                    <select id="desplegable2">
                        <option value="Xbox">Xbox</option>
                        <option value="Playstation">Playstation</option>
                        <option value="Nintendo">Nintendo</option>
                        <option value="Pc">Pc</option>
                        <option value="Ios">iOS</option>
                        <option value="Android">Android</option>
                        <option value="" selected="selected" style="display: none">Plataforma</option>
                    </select>
                </div>
            </div>
            <div id="contenedorJuegos" class="row justify-content-around"></div>
            <div id="paginacion" class="paginacion"></div>
        </div>



        <script src="script/juegos.js"></script>
        <script src="script/selectJuegos.js"></script>

        <footer>
            <p><a href="#">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
            <p>© 2023 Clivel - Todos los derechos reservados</p>
        </footer>


        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
