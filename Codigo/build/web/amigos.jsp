<%-- 
    Document   : amigos
    Created on : 11 may 2023, 23:47:43
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Amigos</title>
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="estilos/estiloAmigos.css"/>
        <script src="script/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.datosUsuario}">      
                <!--
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container-fluid">
                        <div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="${sessionScope.datosUsuario.getFoto() != null ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="49px" height="49px" class="rounded-circle"/>
                            </a>

                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <li><a class="dropdown-item dropdown-item-icon" href="perfil.jsp">Editar usuario<i class="bi bi-person-circle"></i></a></li>
                                <li><a class="dropdown-item dropdown-item-icon" href="Cerrar_sesion">Cerrar sesión<i class="bi bi-box-arrow-right"></i></a></li>
                            </ul>
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
                    <a class="nav-link" href="juegos.jsp">Juegos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Noticias</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex">
                    <button type="button" class="btn btn-sm btn-primary me-2"
                            title="Añadir amigo" data-bs-toggle="modal" 
                            data-bs-target="#agregarAmigoModal">
                        <i class="bi bi-plus-circle"></i>
                    </button>

                    
                <c:if test="${not empty mensajeError}">
                    <script>
                        $(document).ready(function () {
                            $("#agregarAmigoModal").modal("show");
                        });
                    </script>

                </c:if>
                <c:if test="${not empty correcto}">
                    <script>
                        Swal.fire({
                            title: 'Petición de amistad enviada',
                            showClass: {
                                popup: 'animate__animated animate__fadeInDown'
                            },
                            hideClass: {
                                popup: 'animate__animated animate__fadeOutUp'
                            }
                        });
                    </script>

                </c:if>
                <div class="modal fade" id="agregarAmigoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="Controlador_amigos">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Agregar amigo</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <label for="nombre-amigo" class="form-label">Nombre del amigo:</label>
                                    <input type="text" class="form-control" 
                                           id="nombre-amigo" placeholder="Introduce el nombre del amigo"
                                           autocomplete="off" name="nombre-amigo">
                                    <div id="resultados-amigos" class="dropdown-menu"></div>
                <c:if test="${not empty mensajeError}">
                    <p class="estiloMensajeError">${mensajeError}</p>
                </c:if>
            </div>
            <div class="modal-footer">
                <input type="submit" 
                       class="btn btn-success" 
                       value="Agregar" id="botonAgregarAmigo"
                       name="botonAgregarAmigo">
            </div>
        </form>
    </div>
</div>
</div>

                <c:if test="${not empty eliminarAmigoFallo}">
                    <script>
                        $(document).ready(function () {
                            $("#eliminarAmigoModal").modal("show");
                        });
                    </script>

                </c:if>

                <button type="button" class="btn btn-sm btn-danger me-2"
                        title="Eliminar amigo" data-bs-toggle="modal" 
                        data-bs-target="#eliminarAmigoModal">
                    <i class="bi bi-dash-lg"></i>
                </button>

                
                <div class="modal fade" id="eliminarAmigoModal" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="Controlador_amigos">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel2">Eliminar amigo</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <label for="nombre-amigo" class="form-label">Nombre del amigo:</label>
                                    <input type="text" class="form-control" id="nombre-amigo-eliminar" 
                                           placeholder="Introduce el nombre del amigo"
                                           autocomplete="off" name="nombre-amigo-eliminar">
                                    <div id="resultados-amigos-eliminar" class="dropdown-menu"></div>
                <c:if test="${not empty eliminarAmigoFallo}">
                    <p class="estiloMensajeError">${eliminarAmigoFallo}</p>
                </c:if>
            </div>
            <div class="modal-footer">
                <input type="submit" class="btn btn-danger" 
                       value="Eliminar" id="botonEliminarAmigo"
                       name="botonEliminarAmigo">
            </div>
        </form>
    </div>
</div>
</div>

<button type="button" class="btn btn-sm btn-secondary"
    title="Notificaciones"data-bs-toggle="modal" 
    data-bs-target="#notificacionesVentana">
<i class="bi bi-bell"></i>
</button>


<div class="modal fade" id="notificacionesVentana" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">

        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel3">Notificaciones</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
                <c:if test="${not empty listaUsuariosSolicitantes}">
                    <c:forEach items="${listaUsuariosSolicitantes}" var="usuario">
                        <form action="Controlador_amigos">
                            <div class="modal-body">
                                <div class="d-flex align-items-baseline">
                                    <p>Solicitud de amistad de: ${usuario.getUsuario()}</p>
                                    <div class="ms-auto">
                                        <input type="text" style="display: none" value="${usuario.getId_usuario()}" name="id_usuario">
                                        <input type="submit" class="btn btn-success" name="aceptarAmigo" value="Aceptar">
                                        <input type="submit" class="btn btn-danger" name="rechazarAmigo" value="Denegar">
                                    </div>
                                </div>
                            </div>
                        </form>     
                    </c:forEach>
                </c:if>               
            </div>
        </div>
    </div>
</div>
</div>
<div class="list-group chat-friends">

                <c:choose>
                    <c:when test="${not empty listaUsuariosAmigos}">
                        <c:forEach items="${listaUsuariosAmigos}" var="usuario">
                            <form action="Controlador_amigos">
                                <button type="submit" class="list-group-item list-group-item-action border-0 bg-transparent p-0" name="botonIrAChat">
                                    <input type="text" style="display: none" value="${usuario.getUsuario()}" name="nombre_usuario_chat">
                                    <li class="list-group-item d-flex justify-content-between align-items-center" id="listaUsuarios"
                                        style="<c:if test='${not empty usuario_chat}'>
                                <c:if test='${usuario_chat.getUsuario() == usuario.getUsuario()}'>
                                    background-color: #98FB98;
                                    border: 1px solid black;
                                </c:if>
                            </c:if>
                            ">
                            <div class="d-flex align-items-center">
                                <div id="contenedorImgUsuario">
                                    <img src="${usuario.getFoto() != null ? usuario.getFoto() : 'img/usuario.png'}"  
                                         alt="imagen de usuario" 
                                         class="rounded-circle me-2 tooltipUsuario" width="30"
                                         height="30">
                                    <div class="tooltip">
                                        <div class="tooltip-header">
                                            <img src="${usuario.getFoto() != null ? usuario.getFoto() : 'img/usuario.png'}" 
                                                 alt="imagen de usuario" 
                                                 class="rounded-circle me-2" width="50"
                                                 height="50">
                                        </div>
                                        <div class="tooltip-content">
                                            <p><strong>Nombre:</strong> ${usuario.getNombre()}</p>
                                            <p><strong>Apellidos:</strong> ${usuario.getApellidos()}</p>
                                            <p><strong>Descripcion: </strong>${usuario.getDescripcion()}</p>
                                        </div>
                                    </div>
                                </div>
                                <span>${usuario.getUsuario()}</span>
                            </div>
                        </li>
                    </button>
                </form>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card chat-box">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">
                <c:if test="${not empty usuario_chat}">
                    ${usuario_chat.getUsuario()}
                </c:if>
                <c:if test="${empty usuario_chat}">
                    Comienzar un nuevo chat seleccionando amigos
                </c:if>
            </h5>
            <small></small>
        </div>
        <div class="card-body" id="chat-body">

        </div>

        <div class="card-footer">
            <form id="chat-form">
                <div class="input-group">

                    <input type="text" name="id_usuario_envio_mensaje" 
                           value="${usuario_chat.getId_usuario()}"
                           style="display: none">
                <c:if test="${empty usuario_chat}">
                    <input type="text" class="form-control" placeholder="Escribe un mensaje..."
                           name="chat-input" disabled="disabled">
                    <button class="btn btn-outline-primary" type="submit" name="enviar_mensaje" disabled="disabled">
                        <i class="bi bi-arrow-right"></i>
                    </button>
                </c:if>
                <c:if test="${not empty usuario_chat}">
                    <input type="text" class="form-control" placeholder="Escribe un mensaje..."
                           name="chat-input" id="inputEnvioMensaje">
                    <button class="btn btn-outline-primary" type="submit" name="enviar_mensaje" id="flechaEnvioMensaje">
                        <i class="bi bi-arrow-right"></i>
                    </button>
                </c:if>

            </div>
        </form>
    </div>
</div>
</div>

</div>
</div>


<footer>
<p><a href="#">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
<p>© 2023 Clivel - Todos los derechos reservados</p>
</footer>
                -->

                <div class="contenedorDeTodo">
                    <div class="contenedorIzquierda">
                        <div class="parteDeArriba">
                            <div class="pda_izquierda" <c:if test="${sessionScope.datosUsuario.getFondo() != null}">style="background-image: url(${sessionScope.datosUsuario.getFondo()}); background-size: cover;"</c:if>>
                                    <div class="imgYNombre">
                                        <img src="${sessionScope.datosUsuario.getFoto() != null && sessionScope.datosUsuario.getFoto() != '' ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="49px" height="49px" class="rounded-circle"/>
                                </div>
                            </div>
                            <div class="pda_derecha">
                                <div class="pda_derechaArriba">
                                    <button type="button" class="btnIcono"
                                            title="Opciones" onclick="abrirOpciones()">
                                        <i class="bi bi-list"></i>
                                        <ul class="listaOpciones" id="listaDesplegable">
                                            <li><a href="index.jsp">Home</a></li>
                                            <li><a href="comunidades.jsp">Comunidad</a></li>
                                            <li><a href="juegos.jsp">Juegos</a></li>
                                                <c:if test="${sessionScope.datosUsuario.getRol() == 'admin'}">
                                                <li><a href="admin.jsp">Admin</a></li>
                                                </c:if>
                                            <li><a href="perfil.jsp">Editar perfil</a></li>
                                            <li><a href="Cerrar_sesion">Cerrar sesión</a></li>
                                        </ul>
                                    </button>
                                </div>
                                <div class="pda_derechaAbajo">
                                    <div class="iconosContenedorA">
                                        <button type="button" class="btnIcono"
                                                onclick="abrirAgregarAmigos()">
                                            <i class="bi bi-plus-circle"></i>
                                        </button>
                                    </div>
                                    <div class="iconosContenedorB">
                                        <button type="button" class="btnIcono"
                                                title="Eliminar amigo"
                                                onclick="abrirEliminarAmigos()">
                                            <i class="bi bi-dash-lg"></i>
                                        </button>
                                    </div>
                                    <div class="iconosContenedorC">
                                        <button type="button" class="btnIcono"
                                                title="Notificaciones" 
                                                onclick="compruebaNotificacion()">
                                            <i class="bi bi-bell"></i>
                                        </button>
                                    </div>
                                    <div class="iconosContenedorD">
                                        <button type="button" class="btnIcono"
                                                title="Filtrar favoritos" id="filtraFavoritos">
                                            <i class="bi bi-star"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="parteDeAbajo">
                            <div class="contenedorBuscador">
                                <div class="d-flex flex-grow-1 justify-content-center">
                                    <i class="bi bi-search"></i>
                                    <input class="buscador" type="text" placeholder="Buscar" name="buscar" id="buscar" autocomplete="off">
                                </div>
                            </div>
                            <div class="contenedorListaAmigos" id="contenedorListaAmigos">

                            </div>
                        </div>
                    </div>
                    <div class="contenedorDerecha">
                        <div class="contenedorInfoAmigoSeleccionado">

                        </div>
                        <div class="contenedorMensajes">
                            <div class="card-body" id="chat-body">

                            </div>
                        </div>
                        <div class="contenedorEnvioMensajes">
                            <div class="card-footer">
                                <form id="chat-form">
                                    <div class="input-group">
                                        <input type="text" name="id_usuario_envio_mensaje" 
                                               value="${usuario_chat.getId_usuario()}"
                                               style="display: none">
                                        <input type="text" class="form-control" placeholder="Escribe un mensaje..."
                                               name="chat-input" id="inputEnvioMensaje" disabled="disabled">
                                        <button class="btn btn-outline-primary" type="submit" name="enviar_mensaje" id="flechaEnvioMensaje" disabled="disabled">
                                            <i class="bi bi-arrow-right"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="script/amigos.js"></script> 

                <c:if test="${not empty usuario_chat}">
                    <script src="script/chat.js"></script>
                </c:if>

                <!-- MODALES -->

                <!-- Ventana modal para añadir amigos -->
                <div id="modalAgregarAmigo" class="modal">
                    <div class="modal-content">
                        <div class="cuerpo">
                            <i class="bi bi-plus-circle"></i>
                            <p class="agregarP">Enviar solicitud de amistad</p>
                        </div>
                        <div class="input-container">
                            <input type="text" class="text-center" placeholder="Escriba aquí el usuario..." id="nombre-amigo"
                                   autocomplete="off" name="nombre-amigo">
                            <p class="errorAgregarAmigos text-center" style="color: red; font-size: 14px; line-height: 0; margin-top: 15px; display: none"></p>
                            <div id="resultados-amigos" class="listaResultados"></div>
                        </div>
                        <div class="divModalEliminarComentario">
                            <button onclick="agregarAmigoAccion()" class="botonAgregarAmigoModal" id="botonAgregarAmigo"
                                    name="botonAgregarAmigo">Agregar</button>
                            <button onclick="cerrarAgregarAmigos()" class="botonCerrarComentarioModal">Cerrar</button>
                        </div>
                    </div>
                </div>

                <!-- Ventana modal para eliminar amigos -->
                <div id="modalEliminarAmigo" class="modal">
                    <div class="modal-content">
                        <div class="cuerpo">
                            <i class="bi bi-dash-lg"></i>
                            <p class="agregarP">Seleccione el usuario a eliminar</p>
                        </div>
                        <div class="input-container">
                            <input type="text" class="text-center" placeholder="Escriba aquí el usuario..." id="nombre-amigo-eliminar"
                                   autocomplete="off" name="nombre-amigo-eliminar">
                            <p class="errorEliminarAmigos text-center" style="color: red; font-size: 14px; line-height: 0; margin-top: 15px; display: none"></p>
                            <div id="resultados-amigos-eliminar" class="listaResultados"></div>
                        </div>
                        <div class="divModalEliminarComentario">
                            <button onclick="eliminarAmigoAccion()" class="botonAgregarAmigoModal" id="botonEliminarAmigo"
                                    name="botonEliminarAmigo">Eliminar</button>
                            <button onclick="cerrarEliminarAmigos()" class="botonCerrarComentarioModal">Cerrar</button>
                        </div>
                    </div>
                </div>

                <!-- Ventana modal para las notificaciones -->
                <div id="modalNotificaciones" class="modalNotificaciones">
                    <div class="modal-content-notificaciones" id="modal-content-notificaciones">
                        <div class="cuerpoNotificaciones">
                            <div>
                                <i class="bi bi-bell"></i>
                                <p class="agregarPNotificaciones">Notificaciones</p>
                            </div>
                            <button onclick="cerrarNotificaciones()" class="botonModalNotificaciones">X</button>
                        </div>
                        <div class="opcionesNotificaciones">
                            <span>Fitrar por: </span>
                            <button onclick="abrirSolicitudesNotificacion()">Solicitudes</button>
                            <span> | </span>
                            <button onclick="abrirAceptadasNotificacion()">Aceptadas</button>
                        </div>

                    </div>
                </div>

                <div id="modoConcentracion" class="modoConcentracion"></div>
                <!-- Div que contiene el nombre del usuario -->
                <div id="nombreUsuarioSesion" data-usuario-nombre="${sessionScope.datosUsuario.getUsuario()}" style="display: none;"></div>
                <!-- Div que contiene el id del usuario -->
                <div id="idUsuarioSesion" data-usuario-id="${sessionScope.datosUsuario.getId_usuario()}" style="display: none;"></div>

                <!-- Ventana modal confirma el agregar amigo -->
                <div id="modalConfirmaSolicitudAmigo" class="modal modalTemporal">
                    <div class="modal-content">
                        <i class="bi bi-check-circle"></i>
                        <p class="text-center">Solicitud enviada con éxito</p>
                    </div>
                </div>

                <!-- Ventana modal confirma el amigo eliminado -->
                <div id="modalConfirmaAmigoEliminado" class="modal modalTemporal">
                    <div class="modal-content">
                        <i class="bi bi-check-circle"></i>
                        <p class="text-center">Usuario eliminado con éxito</p>
                    </div>
                </div>

                <!-- Ventana modal que muestra que no hay notificaciones -->
                <div id="modalNoHayNotificaciones" class="modal modalTemporal">
                    <div class="modal-content">
                        <i class="bi bi-bell"></i>
                        <p class="text-center">No hay notificaciones</p>
                    </div>
                </div>

            </c:when>

            <c:otherwise>
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">
                            <p class="tituloClivel">Clivel</p>
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="index.jsp">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="amigos.jsp">Amigos</a>
                                </li>
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

                <div class="container text-center">
                    <img src="img/pato.png" alt="imagen" class="img-fluid" id="imagenNoSesion">
                    <p class="mt-4">Regístrate para comenzar un chat o inicia sesión si ya tienes una cuenta</p>
                    <a href="registro.jsp" class="btn btn-primary">Registrarse</a>
                    <a href="login.jsp" class="btn btn-secondary">Iniciar sesión</a>
                </div>
            </c:otherwise>
        </c:choose>
        <link rel ="stylesheet" href ="estilos/estiloIconosImagen.css"/>
        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
