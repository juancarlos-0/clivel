<%-- 
    Document   : perfil
    Created on : 26 abr 2023, 18:46:12
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil</title>
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="estilos/perfil.css"/>
        <script src="script/perfil.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <div class="dropdown">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="${sessionScope.datosUsuario.getFoto() != null && sessionScope.datosUsuario.getFoto() != '' ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="49px" height="49px" class="rounded-circle"/>
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <c:if test="${sessionScope.datosUsuario.getRol() == 'admin'}">
                            <li><a class="dropdown-item dropdown-item-icon" href="admin.jsp">Admin<i class="bi bi-incognito"></i></a></li>
                        </c:if>
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
                        <li class="nav-item">
                            <a class="nav-link" href="Preparar_amigos">Amigos</a>
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

        <!-- Contenedor de modificar el usuario -->
        <div class="container modificacion">
            <div class="row">
                <!-- Parte para cambiar la foto de perfil -->
                <!-- Parte para editar la info -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Editar información de perfil</h5>
                            <form action="Controlador_perfil" method="POST">
                                <div class="mb-3">
                                    <label for="profile-name" class="form-label">Usuario
                                        <c:if test="${!sessionScope.datosUsuario.isUsuario_cambiado()}">
                                            (Un cambio disponible)
                                        </c:if>
                                        <c:if test="${sessionScope.datosUsuario.isUsuario_cambiado()}">
                                            (Sin cambios disponibles)
                                        </c:if>
                                    </label>
                                    <c:if test="${sessionScope.datosUsuario.isUsuario_cambiado()}">
                                        <input type="text" class="form-control" 
                                               id="usuario" name="usuario" 
                                               value="${sessionScope.datosUsuario.getUsuario()}" disabled="disabled">
                                        <input type="text" id="usuario" name="usuario" value="${sessionScope.datosUsuario.getUsuario()}" style="display: none">
                                    </c:if>
                                    <c:if test="${!sessionScope.datosUsuario.isUsuario_cambiado()}">
                                        <input type="text" class="form-control" 
                                               id="usuario" name="usuario" 
                                               value="${sessionScope.datosUsuario.getUsuario()}">
                                    </c:if>

                                </div>
                                <div class="mb-3">
                                    <label for="profile-name" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" 
                                           id="contrasenia" name="contrasenia"
                                           value="${sessionScope.datosUsuario.getContrasenia()}">
                                </div>
                                <div class="mb-3">
                                    <label for="profile-name" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" 
                                           id="nombre" name="nombre"
                                           value="${sessionScope.datosUsuario.getNombre()}">
                                </div>
                                <div class="mb-3">
                                    <label for="profile-name" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" 
                                           id="apellidos" name="apellidos"
                                           value="${sessionScope.datosUsuario.getApellidos()}">
                                </div>
                                <div class="mb-3">
                                    <label for="profile-description" class="form-label">Descripción (200 carácteres máximo)</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3" maxlength="200">${sessionScope.datosUsuario.getDescripcion()}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="fechaNacimiento" class="form-label">Fecha de nacimiento</label>
                                    <input type="date" class="form-control" 
                                           id="fechaNacimiento" name="fechaNacimiento"
                                           value="${sessionScope.datosUsuario.getFecha_nacimiento()}"
                                           min="1940-01-01" max="2008-12-31">
                                </div>
                                <div class="mb-3">
                                    <label for="correo" class="form-label">Correo</label>
                                    <input type="text" class="form-control" disabled="disabled" 
                                           id="correo" name="correo"
                                           value="${sessionScope.datosUsuario.getCorreo()}">
                                </div>
                                <input type="number" name="id" id="id" 
                                       value="${sessionScope.datosUsuario.getId_usuario()}"
                                       style="display: none"
                                       >
                                <input type="text" name="usuarioOriginal" id="usuarioOriginal" 
                                       value="${sessionScope.datosUsuario.getUsuario()}"
                                       style="display: none"
                                       >
                                <button type="submit" class="btn btn-primary"
                                        id="cambiarDatos" name="cambiarDatos"
                                        >Actualizar información</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">Cambiar foto de perfil</h5>
                            <img src="${sessionScope.datosUsuario.getFoto() 
                                        != null ? sessionScope.datosUsuario.getFoto() 
                                        : 'img/usuario.png'}" 
                                 class="card-img-top" alt="Imagen de perfil">
                            <p class="card-text">Haz clic en el botón de abajo para subir una nueva foto de perfil.</p>
                            <form method="POST" action="Controlador_perfil" enctype="multipart/form-data"> 
                                <div class="mb-3">
                                    <input type="file" class="form-control" 
                                           id="foto-perfil" name="foto-perfil">
                                </div>
                                <input type="number" name="id" id="id"
                                       value="${sessionScope.datosUsuario.getId_usuario()}"
                                       style="display: none">
                                <button type="submit" class="btn btn-primary"
                                        id="cambiarFoto" name="cambiarFoto"
                                        >Subir foto
                                </button>
                            </form>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title">Cambiar fondo</h5>
                            <img src="${sessionScope.datosUsuario.getFondo() 
                                        != null ? sessionScope.datosUsuario.getFondo()
                                        : 'img/usuario.png'}" 
                                 class="card-img-top" alt="Imagen de perfil">
                            <p class="card-text">Haz clic en el botón de abajo para subir un nuevo fondo.</p>
                            <form method="POST" action="Controlador_perfil" enctype="multipart/form-data"> 
                                <div class="mb-3">
                                    <input type="file" class="form-control" 
                                           id="fondo-perfil" name="fondo-perfil">
                                </div>
                                <input type="number" name="id" id="id"
                                       value="${sessionScope.datosUsuario.getId_usuario()}"
                                       style="display: none">
                                <button type="submit" class="btn btn-primary"
                                        id="cambiarFondo" name="cambiarFondo"
                                        >Subir foto
                                </button>
                            </form>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <footer>
            <p><a href="faq">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
            <p>© 2023 Clivel - Todos los derechos reservados</p>
        </footer>


        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
