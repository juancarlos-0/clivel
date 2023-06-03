<%-- 
    Document   : login
    Created on : 23 abr 2023, 23:32:27
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="author" content="Juan Carlos Núñez Rodríguez">
        <link rel="stylesheet" href="estilos/login.css">
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <script src="script/login.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <title>Login</title>
    </head>

    <body>
        <div class="section login-page container-fluid">
            <div class="row align-item-center">
                <div class="col-sm-3 p-0 cambiar">
                    <div class="login-form">
                        <div class="logo">
                            <a href="index.html" class="">
                                <img src="img/logo/logo_blanco_negro.jpg" alt="Logo" class="img-fluid">
                            </a>
                        </div>
                        <div class="page-heading">
                            <h2>Inicia sesión en tu cuenta</h2>
                        </div>
                        <form action="Controlador_login" method="POST">
                            <div class="login-form-items">
                                <div class="items">
                                    <label for="">Usuario 
                                        <c:if test="${not empty usuarioFallo}">
                                            <script>
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'Datos incorrectos'
                                                })
                                            </script>
                                        </c:if>
                                    </label>
                                    <div class="input">
                                        <input type="text" placeholder="Introduce tu usuario" id="usuario" name="usuario" value="${usuario}">
                                        <i class="bi bi-person-circle"></i>
                                    </div>
                                </div>
                                <div class="items">
                                    <label for="">Contraseña 
                                        <c:if test="${not empty contraFallo}">
                                            <script>
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'Datos incorrectos'
                                                })
                                            </script>
                                        </c:if>
                                    </label>
                                    <div class="input">
                                        <input type="text" placeholder="Introduce tu contraseña" id="contrasenia" name="contrasenia" value="${contrasenia}">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                                <div class="text-end forgot-password">
                                    <a href="">¿Olvidaste la contraseña?</a>
                                </div>
                                <div class="form-signin">
                                    <button class="btn" id="inicia" name="inicia">Iniciar sesión</button>
                                </div>
                                <div class="or-option">
                                    <p>O</p>
                                </div>
                                <div class="form-signup">
                                    <button class="btn" id="registro" name="registro">Registrate ahora</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-sm-9 imagen" style="background-color: #c5b5e6;">
                    <div class="login-extra">
                        <img src="img/mando.jpg" alt="logo" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>

</html>