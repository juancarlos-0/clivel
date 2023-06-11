<%-- 
    Document   : comunidades
    Created on : 30 abr 2023, 19:54:37
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="estilos/comunidades.css"/>
        <title>Comunidades</title>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <c:if test="${not empty sessionScope.datosUsuario}">
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
                            <a class="nav-link active" href="comunidades.jsp">Comunidad</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="juegos.jsp">Juegos</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <h1 class="text-center">Bienvenido/a a la comunidad de videojuegos</h1>

        <div class="contenedorSlider">
            <input type="radio" id="radio1" name="imagenSlide" hidden>
            <input type="radio" id="radio2" name="imagenSlide" hidden>
            <input type="radio" id="radio3" name="imagenSlide" hidden>
            <input type="radio" id="radio4" name="imagenSlide" hidden>

            <div class="slide">

                <div class="item-slide">
                    <img src="img/cyberpunkPaisaje.png" alt="imagen1" class="imagenSlider">
                </div>
                <div class="item-slide">
                    <img src="img/paisajeAnime2.png" alt="imagen2" class="imagenSlider">
                </div>
                <div class="item-slide">
                    <img src="img/ilustracionComic.png" alt="imagen3" class="imagenSlider">
                </div>
                <div class="item-slide">
                    <img src="img/paisajeCalle.png" alt="imagen4" class="imagenSlider">
                </div>

            </div>

            <div class="paginacion">

                <label class="paginationItem" for="radio1">
                    <img src="img1.jpg" alt="imagen1">
                </label>

                <label class="paginationItem" for="radio2">
                    <img src="img2.jpg" alt="imagen2">
                </label>

                <label class="paginationItem" for="radio3">
                    <img src="img3.jpg" alt="imagen3">
                </label>

                <label class="paginationItem" for="radio4">
                    <img src="img4.jpg" alt="imagen4">
                </label>

            </div>
        </div>

        <!-- Contenedor de la comunidad -->
        <div class="container comunidad">
            <!-- Lista de comunidades con mayor número de usuarios-->
            <h2 class="text-center mt-5">Comunidades con mayor número de usuarios</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mt-2">
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/fornite.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Fortnite</h5>
                            <p class="card-text">Discute tus estrategias favoritas de Fortnite con otros jugadores
                                apasionados.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/lol.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de League of Legends</h5>
                            <p class="card-text">Conéctate con otros jugadores de League of Legends y comparte tus trucos y
                                consejos.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/minecraft.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Minecraft</h5>
                            <p class="card-text">Conéctate con otros jugadores de Minecraft y comparte tus construcciones y
                                aventuras.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/valorant.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Valorant</h5>
                            <p class="card-text">Conéctate con otros jugadores de Valorant y comparte tus tácticas y
                                estrategias de juego.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/ow.webp" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Overwatch</h5>
                            <p class="card-text">Conéctate con otros jugadores de Overwatch y comparte tus estrategias y
                                jugadas épicas.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/wow.jpeg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de World of Warcraft</h5>
                            <p class="card-text">Conéctate con otros jugadores de World of Warcraft y comparte tus aventuras
                                y estrategias de juego.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Lista de comunidades creadas recientementes-->
            <h2 class="text-center mt-5">Comunidades creadas recientementes</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mt-2">
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/fornite.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Fortnite</h5>
                            <p class="card-text">Discute tus estrategias favoritas de Fortnite con otros jugadores
                                apasionados.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/lol.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de League of Legends</h5>
                            <p class="card-text">Conéctate con otros jugadores de League of Legends y comparte tus trucos y
                                consejos.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/minecraft.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Minecraft</h5>
                            <p class="card-text">Conéctate con otros jugadores de Minecraft y comparte tus construcciones y
                                aventuras.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/valorant.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Valorant</h5>
                            <p class="card-text">Conéctate con otros jugadores de Valorant y comparte tus tácticas y
                                estrategias de juego.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/ow.webp" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de Overwatch</h5>
                            <p class="card-text">Conéctate con otros jugadores de Overwatch y comparte tus estrategias y
                                jugadas épicas.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100">
                        <img src="../Imagenes/comunidad/wow.jpeg" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Comunidad de World of Warcraft</h5>
                            <p class="card-text">Conéctate con otros jugadores de World of Warcraft y comparte tus aventuras
                                y estrategias de juego.</p>
                            <a href="#" class="btn btn-primary">Unirse a la comunidad</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección crear comunidad -->
            <section class="py-5">
                <div class="container">
                    <h2 class="mb-4">¿Quieres crear una comunidad?</h2>
                    <p class="lead mb-5">Crea tu propia comunidad y comparte tus intereses con otros usuarios de todo el mundo.
                    </p>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">Conéctate con otros usuarios</h5>
                                    <p class="card-text">Encuentra personas que compartan tus intereses y expande tu red social.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">Comparte tus conocimientos</h5>
                                    <p class="card-text">Comparte tus gustos con otros usuarios y tus experiencias.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">Únete a la comunidad global</h5>
                                    <p class="card-text">Únete a una comunidad global y haz amigos de todo el mundo.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="#" class="btn btn-primary">Crear comunidad</a>
                </div>
            </section>
            <!-- Sección encuentra tu comunidad -->
            <section class="bg-light py-5">
                <div class="container">
                    <h2 class="text-center mb-4">Encuentra tu comunidad</h2>
                    <form>
                        <div class="form-group">
                            <label for="busqueda">Buscar comunidad:</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="busqueda"
                                       placeholder="Ingrese el nombre de la comunidad">
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="button" id="button-buscar">Buscar</button>
                                </div>
                                <div class="input-group-append">
                                    <button class="btn btn-secondary" type="button" id="button-filtros" data-bs-toggle="modal"
                                            data-bs-target="#filtroModal">Filtros</button>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Ventana modal de filtros -->
                    <div class="modal fade" id="filtroModal" tabindex="-1" aria-labelledby="filtroModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="filtroModalLabel">Filtros</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="filtro-fecha" class="form-label">Fecha de creación:</label>
                                        <input type="date" class="form-control" id="filtro-fecha">
                                    </div>
                                    <div class="mb-3">
                                        <label for="filtro-usuario" class="form-label">Usuario creador:</label>
                                        <input type="text" class="form-control" id="filtro-usuario">
                                    </div>
                                    <div class="mb-3">
                                        <label for="filtro-num-usuarios" class="form-label">Número de
                                            usuarios(Aproximados):</label>
                                        <input type="number" class="form-control" id="filtro-num-usuarios">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="button" class="btn btn-primary" id="aplicar-filtros"
                                            data-bs-dismiss="modal">Aplicar filtros</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
</html>

<footer>
    <p><a href="faq">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
    <p>© 2023 Clivel - Todos los derechos reservados</p>
</footer>


<script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
</body>
</html>
