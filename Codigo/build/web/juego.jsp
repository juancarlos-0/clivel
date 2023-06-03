<%-- 
    Document   : juego
    Created on : 27 may 2023, 0:22:08
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="estilos/juego.css"/>
        <script src="script/jquery-3.7.0.min.js"></script>
        <script src="script/juego.js"></script>
        <title>Juego</title>
    </head>
    <body>

        <div class="imagenDeFondo">
            <img src="${juego.getImagenPrincipal()}" alt="fondo">
        </div>


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
                        <input class="buscador" type="text" placeholder="Buscar" name="buscar" id="buscar" autocomplete="off">
                    </form>
                </div>




                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>



                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
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

        <div class="contenedorCentral">
            <div class="contenedorIzquierda">
                <div class="plataformasYTiempo">
                    <c:if test="${juego.getFechaLanzamiento() != ''}">
                        <span class="fechaLanzamiento">${juego.getFechaLanzamiento()}</span>
                    </c:if>
                    <c:forEach items="${juego.getPlataformas()}" var="plataforma">
                        <c:choose>
                            <c:when test="${fn:toLowerCase(plataforma) == 'xbox'}">
                                <a href="https://www.xbox.com" target="_blank" class="icon-link">
                                    <i class="bi bi-xbox"></i>
                                </a>
                            </c:when>
                            <c:when test="${fn:toLowerCase(plataforma) == 'playstation'}">
                                <a href="https://www.playstation.com" target="_blank" class="icon-link">
                                    <i class="bi bi-playstation"></i>
                                </a>
                            </c:when>
                            <c:when test="${fn:toLowerCase(plataforma) == 'nintendo'}">
                                <a href="https://www.nintendo.com" target="_blank" class="icon-link">
                                    <i class="bi bi-nintendo-switch"></i>
                                </a>
                            </c:when>
                            <c:when test="${fn:toLowerCase(plataforma) == 'pc'}">
                                <a href="https://www.pccomponentes.com" target="_blank" class="icon-link">
                                    <i class="bi bi-pc"></i>
                                </a>
                            </c:when>
                            <c:when test="${fn:toLowerCase(plataforma) == 'ios'}">
                                <a href="https://www.ios.com" target="_blank" class="icon-link">
                                    <i class="bi bi-phone"></i>
                                </a>
                            </c:when>
                            <c:when test="${fn:toLowerCase(plataforma) == 'android'}">
                                <a href="https://www.android.com" target="_blank" class="icon-link">
                                    <i class="bi bi-phone"></i>
                                </a>

                            </c:when>
                        </c:choose>

                    </c:forEach>
                    <c:if test="${juego.getTiempoPromedioDejuego() != ''}">
                        <span class="tiempoDeJuego">Tiempo promedio de juego: ${juego.getTiempoPromedioDejuego()} horas</span>
                    </c:if>

                </div>
                <c:if test="${juego.getNombre() != ''}">
                    <h1>${juego.getNombre()}</h1>
                    <p class="descripcion">Descripción</p>
                    ${juego.getDescripcion()}
                </c:if>

                <c:if test="${juego.getEdadRecomendada() != '-1'}">
                    <p class="edadRecomendada colorGris">Edad recomendada</p>
                    <p class="numeroEdadRecomendada">+${juego.getEdadRecomendada()}</p>
                </c:if>

                <c:if test="${juego.desarrolladores != ''}">
                    <p class="colorGris">Desarrolladores</p>
                    <p class="desarrolladores">
                        <c:forEach items="${juego.desarrolladores}" var="desarrollador" varStatus="status">
                            <c:if test="${status.index > 0}">, </c:if>
                            ${desarrollador}
                        </c:forEach>
                    </p>
                </c:if>

                <c:if test="${juego.getGenero() != ''}">
                    <p class="colorGris">Género</p>
                    <p class="genero">
                        <c:forEach items="${juego.getGenero()}" var="genero" varStatus="status">
                            <c:if test="${status.index > 0}">, </c:if>
                            ${genero}
                        </c:forEach>
                    </p>
                </c:if>

                <c:if test="${juego.getMetacritic() != '-1'}">
                    <p class="colorGris">Valoración de metacritic</p>
                    <p>${juego.getMetacritic()}</p>
                </c:if>

            </div>

            <div class="contenedorDerecha">
                <div class="juego_capturas">
                    <div class="juego_capturas_inner">
                        <div class="juego_movie">
                            <div class="juego_carta_video empezar">
                                <c:choose>
                                    <c:when test="${not empty juego.trailer}">
                                        <video src="${juego.getTrailer().get(0)}" autoplay loop muted controls="false"></video>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${juego.imagenPrincipal != null}">
                                            <img src="${juego.imagenPrincipal}" alt="Imagen principal" class="imagenPricipal">
                                        </c:if>

                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="juego_capturas_lista">
                            <c:forEach var="captura" items="${juego.imagenesAdicionales}" varStatus="status">
                                <div class="juego_captura">
                                    <c:if test="${captura != null}">
                                        <img src="${captura}" alt="Captura ${status.index + 1}">
                                    </c:if>

                                </div>

                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="contendorPalabraComprar">
                    <div class="palabraComprar">
                        <p>Dónde comprar</p>
                    </div>
                </div>

                <div class="contenedorEnlaces">
                    <div class="contenedorEnlacesCompra">
                        <c:forEach var="entry" items="${juego.getUrlCompraJuego()}">
                            <c:set var="storeName" value="${entry.key}"/>
                            <c:set var="storeUrl" value="${entry.value}"/>
                            <div class="enlaceCompra" onclick="window.location.href = '${storeUrl}'">
                                <span>${storeName}</span>
                                <i class="bi ${fn:containsIgnoreCase(fn:toLowerCase(storeName), 'xbox') ? 'bi bi-xbox' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'playstation') ? 'bi bi-playstation' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'google') ? 'bi bi-google-play' :
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'steam') ? 'bi bi-steam' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'epic') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'gog') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'origin') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'uplay') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'itch.io') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'humble') ? 'bi bi-shop-window' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'amazon') ? 'bi bi-box-seam' : 
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'bestbuy') ? 'bi bi-shop-window' :
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'nintendo') ? 'bi bi-nintendo-switch' :
                                               fn:containsIgnoreCase(fn:toLowerCase(storeName), 'app') ? 'bi bi-apple' : ''}">
                                </i>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>

        </div>

        <!-- Contenedor de los comentarios -->
        <div class="contenedorComentarios">
            <div class="comentarios">
                <p class="parrafoPrincipalComentarios">${juego.getNombre()} - <span class="naranja">Comentarios</span></p>

                <c:if test="${not empty sessionScope.datosUsuario}">
                    <c:if test="${existeValoracion}">
                        <div class="contenedorBotonFormulario" onclick="abrirExisteComentario()">
                            <div class="iconoMas">
                                <p>+</p>
                            </div>
                            <div class="divPalabraComentar">
                                <p>Escribir un comentario</p>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${!existeValoracion}">
                        <div class="contenedorBotonFormulario" onclick="abrirModal()">
                            <div class="iconoMas">
                                <p>+</p>
                            </div>
                            <div class="divPalabraComentar">
                                <p>Escribir un comentario</p>
                            </div>
                        </div>
                    </c:if>
                </c:if>
                <c:if test="${empty sessionScope.datosUsuario}">
                    <div class="contenedorBotonFormulario" onclick="abrirModalFallo()">
                        <div class="iconoMas">
                            <p>+</p>
                        </div>
                        <div class="divPalabraComentar">
                            <p>Escribir un comentario</p>
                        </div>
                    </div>
                </c:if>

                <!-- Comentarios individuales -->
                <div class="listaComentariosIndividual">
                    <!-- Desplegable ordenar -->
                    <div class="contendorDesplegableOrden">
                        <div id="idJuegoComentario2" data-juego-id="${juego.getIdJuego()}" style="display: none;"></div>
                        <div class="desplegableOrden">
                            <button class="botonOrden" onclick="desplegableComentarios()">
                                <div class="contenidoSeleccionado">
                                    <div class="tituloSeleccionado" id="opcionSeleccionada">Más recientes</div>
                                    <i class="iconoSeleccionado bi bi-caret-down-fill"></i>
                                </div>
                            </button>
                            <ul class="listaOpciones" id="listaDesplegable">
                                <li class="liGris">Ordenar por</li>
                                <li onclick="seleccionarOpcion(this)">Más recientes</li>
                                <li onclick="seleccionarOpcion(this)">Más antiguos</li>
                                <li onclick="seleccionarOpcion(this)">Más gustados</li>
                            </ul>
                        </div>
                    </div>

                    <!-- Ver las valoraciones -->
                    <div class="contenedorComentarioIndividual" id="contenedorComentarioIndividual" data-id-usuario="${sessionScope.datosUsuario != null ? sessionScope.datosUsuario.getId_usuario() : 0}">
                    </div>
                    <!-- Botón comentario individual -->
                    <div class="contenedorBotonVerMasComentario" id="contenedorBotonVerMasComentario">

                    </div>

                </div>

            </div>
        </div>


        <!-- Ventana modal -->
        <div id="miModal" class="modal" style="display: none;">
            <div class="modalContenido">
                <!-- Aquí va el contenido de la ventana modal -->
                <span class="modalCerrar" onclick="cerrarModal()"><i class="bi bi-x-lg"></i></span>
                <h2 class="h2Modal"><span class="naranja">Escribe un comentario sobre </span>${juego.getNombre()}</h2>
                <form>
                    <p class="estiloPValoracion" id="valoracionPalabra">Valoración</p>
                    <div class="valoracion">
                        <label class="valoracion-label">
                            <input type="radio" name="valoracion" value="Excelente">
                            Excelente <i class="bi bi-heart-fill"></i>
                        </label>

                        <label class="valoracion-label">
                            <input type="radio" name="valoracion" value="Bueno">
                            Bueno <i class="bi bi-fire"></i>
                        </label>

                        <label class="valoracion-label">
                            <input type="radio" name="valoracion" value="Aceptable">
                            Aceptable <i class="bi bi-emoji-sunglasses-fill"></i>
                        </label>

                        <label class="valoracion-label">
                            <input type="radio" name="valoracion" value="Pasar">
                            Pasar <i class="bi bi-bandaid-fill"></i>
                        </label>
                    </div>
                    <p class="estiloPValoracion" id="comentarioPalabra">Comentario</p>
                    <textarea id="textareaValoracion" class="textareaValoracion" name="comentario" maxlength="400" rows="5" cols="30" style="resize: none;" placeholder="Escribe un comentario..."></textarea>
                    <input type="number" id="idJuegoComentario" value="${juego.getIdJuego()}" style="display: none;">
                    <c:if test="${not empty sessionScope.datosUsuario}">
                        <input type="hidden" id="idUsuarioComentario" value="${sessionScope.datosUsuario.getId_usuario()}">
                    </c:if>  
                    <input type="submit" name="enviarComentario" class="enviarComentario" id="enviarComentario" value="Publicar">
                </form>
            </div>
        </div>

        <!-- Ventana modal fallo-->
        <div id="modal" class="modal">
            <div class="modal-content">
                <p>Debes iniciar sesión para poder escribir un comentario.</p>
                <button onclick="cerrarModalFallo()" class="modalBotonCerrarFallo">Cerrar</button>
            </div>
        </div>

        <!-- Ventana modal existeComentario -->
        <div id="modalExisteComentario" class="modal">
            <div class="modal-content">
                <p>No puede escribir más de un comentario</p>
                <button onclick="cerrarExisteComentario()" class="modalBotonCerrarFallo">Cerrar</button>
            </div>
        </div>


        <div id="resultadosBusqueda" style="display: none"></div>
        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
