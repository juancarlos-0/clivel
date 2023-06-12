<%-- 
    Document   : index
    Created on : 16 may 2023, 0:03:22
    Author     : Juancarlos
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Indice</title>
        <link rel="stylesheet" href="estilos/index.css"/>
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
                            <c:if test="${sessionScope.datosUsuario.getRol() == 'admin'}">
                            <li><a class="dropdown-item dropdown-item-icon" href="admin.jsp">Admin<i class="bi bi-incognito"></i></a></li>
                            </c:if>
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

        <div class="contenedorBienvenida">
            <h1 class="textoBienvenida">Bienvenido/a a Clivel</h1>
            <p class="texto2Bienvenida">La red social para los amantes de los videojuegos</p>
            <div>
                <c:if test="${empty sessionScope.datosUsuario}">
                    <button class="boton1" onclick="
                            window.location.href = 'login.jsp';
                            ">Iniciar sesión</button>
                    <button class="boton2" onclick="
                            window.location.href = 'registro.jsp';
                            ">Registrarse</button>
                </c:if>
            </div>            
        </div>

        <section class="acerca-de">
            <h2>¿Qué es Clivel?</h2>
            <p>Clivel es una red social creada para los amantes de los videojuegos. 
                Aquí podrás conectarte con otros jugadores, descubrir nuevos juegos y 
                participar en la comunidad de jugadores. También podrás valorar los videojuegos
                y descubrir las nuevas noticias de la actualidad del mundo de los 
                videojuegos.
            </p>
            <img src="img/samurai.png" class="samurai">
            <p class="texto-mini">"El lugar ideal para conocer más sobre videojuegos"</p>
        </section>

        <section class="comunidad py-5">
            <h2 style="font-size: 80px">Lo que encontrarás</h2>          
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 order-md-2">
                        <div class="img-comunidad">
                            <img src="img/imagen-arcoiris.png" alt="Sección de comunidad" class="img-fluid rounded shadow">
                        </div>
                    </div>
                    <div class="col-md-6 order-md-1">
                        <div class="comunidad-texto">
                            <h2>Amigos</h2>
                            <p>En Clivel hay una sección en la que podrás 
                                agregar a todos tus amigos y podrás hablar con ellos 
                                mediante un chat, además podrás agregarlos como favoritos y podrás filtrar tanto
                                por amigos favoritos como buscando su usuario.</p>

                            <c:if test="${not empty sessionScope.datosUsuario}">
                                <a href="Preparar_amigos" class="btn btn-primary">Ir a los amigos</a>
                            </c:if>
                            <c:if test="${empty sessionScope.datosUsuario}">
                                <a href="amigos.jsp" class="btn btn-primary">Ir a los amigos</a>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 order-md-2">
                        <div class="img-comunidad">
                            <img src="img/dos-espadas.png" alt="Sección de comunidad" class="img-fluid rounded shadow">
                        </div>
                    </div>
                    <div class="col-md-6 order-md-1">
                        <div class="comunidad-texto">
                            <h2>Juegos</h2>
                            <p>Podrás ver todos los juegos y filtrarlos para poder encontar tu juego favorito,
                                además podrás dar una valoración y ver la de los demas usuarios. En las valoraciones podrás dar like
                                a las demás valoraciones.</p>
                            <a href="juegos.jsp" class="btn btn-primary">Ver los juegos</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 order-md-2">
                        <div class="img-comunidad">
                            <img src="img/mujer-en-parada-autobus.png" alt="Sección de comunidad" class="img-fluid rounded shadow">
                        </div>
                    </div>
                    <div class="col-md-6 order-md-1">
                        <div class="comunidad-texto">
                            <h2>Comunidades</h2>
                            <p>EN DESARROLLO. En nuestra sección de comunidad, podrás compartir tus experiencias, hacer nuevos amigos y discutir tus juegos favoritos. Actualmente podrás ver un concepto de lo que será la página</p>
                            <a href="comunidades.jsp" class="btn btn-primary">Ir a comunidades</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 order-md-2">
                        <div class="img-comunidad">
                            <img src="img/arcoiris-animales.png" alt="Sección de comunidad" class="img-fluid rounded shadow">
                        </div>
                    </div>
                    <div class="col-md-6 order-md-1">
                        <div class="comunidad-texto">
                            <h2>Noticias</h2>
                            <p>PRÓXIMAMENTE. En clivel queremos que puedas estar al día de todas las noticias del mundo de los videojuegos, es por ello que 
                                estamos desarrollando esta sección para poder traerla lo antes posible.</p>
                            <a href="#" class="btn btn-primary">Ver las noticias</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer>
            <p><a href="faq">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
            <p>© 2023 Clivel - Todos los derechos reservados</p>
        </footer>





        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>

</html>