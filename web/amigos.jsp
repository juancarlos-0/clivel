<%-- 
    Document   : amigos
    Created on : 30 abr 2023, 22:44:57
    Author     : Juancarlos
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="estilos/amigos.css"/>
        <title>amigos</title>
    </head>
    <body>
        
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a href="perfil.jsp">
                    <img src="${sessionScope.datosUsuario.getFoto() 
                                != null ? sessionScope.datosUsuario.getFoto() 
                                : 'img/usuario.png'}" 
                         alt="Imagen de perfil" width="50px" 
                         height="46px" class="rounded-circle"/>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="amigos.jsp">Amigos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="comunidades.jsp">Comunidad</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Juegos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Noticias</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
                         
        <!-- Contenido principal -->
        <main class="container">
            <div class="row">
                <!-- Columna de amigos -->
                <div class="col-md-4">
                    <h2>Lista de amigos</h2>
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 1" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 1</span>
                            </div>
                            <span class="badge bg-secondary rounded-pill">Desconectado</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 2" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 2</span>
                            </div>
                            <span class="badge bg-secondary rounded-pill">Desconectado</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 3" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 3</span>
                            </div>
                            <span class="badge bg-success rounded-pill">Ausente</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 4" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 4</span>
                            </div>
                            <span class="badge bg-success rounded-pill">Ausente</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 5" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 5</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 6" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 6</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 7" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 7</span>
                            </div>
                            <span class="badge bg-secondary rounded-pill">Desconectado</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 8" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 8</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 10" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 9</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 11" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 11</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="img/usuario.png" alt="Imagen amigo 12" class="rounded-circle me-2" width="30"
                                     height="30">
                                <span>Amigo 12</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">En línea</span>
                        </li>
                    </ul>
                    <!-- Agregar amigos -->
                    <form>
                        <div class="mb-3 mt-3">
                            <label for="friendName" class="form-label">Agregar amigo</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="friendName" name="friendName"
                                       placeholder="Nombre del amigo">
                                <button type="submit" class="btn btn-primary">Agregar</button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Columna de chat -->
                <div class="col-md-8">
                    <h2>Chat</h2>
                    <div class="chat-container">
                        <div class="message left-message">
                            <p>Hola, ¿cómo estás?</p>
                        </div>
                        <div class="message right-message">
                            <p>¡Hola! Estoy bien, ¿y tú?</p>
                        </div>
                        <div class="message left-message">
                            <p>Sí, todo bien. ¿Quieres jugar un juego más tarde?</p>
                        </div>
                        <div class="message right-message">
                            <p>¡Sí, por supuesto! ¿A qué hora?</p>
                        </div>
                        <div class="message left-message">
                            <p>Quedamos a las 18:00</p>
                        </div>
                        <div class="message right-message">
                            <p>Me viene bien esa hora luego hablamos</p>
                        </div>
                        <!-- Añade más mensajes aquí -->
                    </div>
                    <form>
                        <div class="mb-3 mt-3">
                            <label for="message" class="form-label">Enviar mensaje</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="message" name="message"
                                       placeholder="Escribe tu mensaje...">
                                <button type="submit" class="btn btn-primary">Enviar</button>
                            </div>
                        </div>
                    </form>
                </div>


            </div>
        </main>
        <footer>
            <p><a href="#">Preguntas frecuentes</a> | <a href="#">Términos y condiciones</a> | <a href="#">Contáctanos</a></p>
            <p>© 2023 Clivel - Todos los derechos reservados</p>
        </footer>


        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
