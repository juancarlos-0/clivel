<%-- 
    Document   : admin
    Created on : 8 jun 2023, 19:25:53
    Author     : Juancarlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <!-- bootstrap5 -->
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <!-- mis estilos -->
        <link rel="stylesheet" href="estilos/admin.css"/>
        <script src="script/jquery-3.7.0.min.js"></script>
        <script src="script/admin.js"></script>
        <!-- datatables -->
        <link rel="stylesheet" href="datatables/datatables.min.css"/>
        <title>Admin</title>
    </head>
    <body>
        <div class="navPrincipal">
            <div>
                <img src="${sessionScope.datosUsuario.getFoto() != null ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="50px" height="46px" class="rounded-circle" />
            </div>
            <div>
                <span>PANEL ADMINISTRADOR</span>
            </div>
            <div>
                <ul>
                    <li class="">
                        <a class="" href="index.jsp">
                            <i class="bi bi-house"></i><span class="palabraIcono">Home</span>
                        </a>
                    </li>
                    <li class="">
                        <a class="" href="Cerrar_sesion">
                            <i class="bi bi-box-arrow-right"></i><span class="palabraIcono">Cerrar sesión</span>
                        </a>
                    </li>
                </ul>

            </div>
        </div>

        <div class="navSecundario">
            <button class="navButton" id="usuariosOpciones">
                <i class="bi bi-person-fill"></i>
                <span>Usuarios</span>
            </button>

            <button class="navButton" id="comentariosOpciones">
                <i class="bi bi-envelope-fill"></i>
                <span>Comentarios</span>
            </button>

            <button class="navButton" id="preguntasFrecuentesOpciones">
                <i class="bi bi-question-circle"></i>
                <span>FAQ</span>
            </button>
        </div>

        <div style="width: 90%; margin: 40px auto;">
            <table id="tablaUsuarios" class="table table-striped" style="width: 100%;">

            </table>
            <button type="button" class="btn btn-primary dark-modal" id="abrirModalAdiadirAdmin">Añadir admin</button>

            <table id="tablaJuegos" class="table table-striped" style="width: 100%;">

            </table>

            <table id="tablaComentarios" class="table table-striped" style="width: 100%;">

            </table>

            <table id="tablaPreguntasFrecuentes" class="table table-striped" style="width: 100%;">

            </table>
            <button type="button" class="btn btn-primary dark-modal" id="aniadirFAQBtn">Añadir FAQ</button>
        </div>

        <!-- Datos del usuario -->

        <div id="divUsuario" data-usuario="${sessionScope.datosUsuario.getUsuario()}"></div>


        <!-- Modal para editar el usuario -->
        <div class="modal fade dark-modal" id="editarUsuarioModal" tabindex="-1" aria-labelledby="editarUsuarioModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editarUsuarioModalLabel">Editar Usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editarUsuarioID" class="form-label">ID</label>
                            <input type="text" class="form-control" id="editarUsuarioID" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioUsuario" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="editarUsuarioUsuario">
                            <p id="errorUsuario" class="error-message text-danger"></p>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioNombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="editarUsuarioNombre">
                            <p id="errorNombre" class="error-message text-danger"></p>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioApellidos" class="form-label">Apellidos</label>
                            <input type="text" class="form-control" id="editarUsuarioApellidos">
                            <p id="errorApellidos" class="error-message text-danger"></p>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioCorreo" class="form-label">Email</label>
                            <input type="email" class="form-control" id="editarUsuarioCorreo">
                            <p id="errorCorreo" class="error-message text-danger"></p>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioFoto" class="form-label">Foto</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="editarUsuarioFoto" readonly>
                                <button class="btn btn-outline-danger" type="button" onclick="borrarContenido('editarUsuarioFoto')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="editarUsuarioFondo" class="form-label">Fondo</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="editarUsuarioFondo" readonly>
                                <button class="btn btn-outline-danger" type="button" onclick="borrarContenido('editarUsuarioFondo')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="editarUsuarioDescripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="editarUsuarioDescripcion"></textarea>
                            <p id="errorDescripcion" class="error-message text-danger"></p>
                        </div>
                        <div class="mb-3">
                            <label for="editarUsuarioRol" class="form-label">Rol</label>
                            <select class="form-select" id="editarUsuarioRol">
                                <option value="normal">normal</option>
                                <option value="admin">admin</option>
                            </select>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editarUsuarioBtn" class="btn btn-primary">Editar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para editar los comentarios -->

        <!-- Modal de Edición de Comentario de Juego -->
        <div class="modal fade dark-modal" id="modalEditarComentarioJuego" tabindex="-1" aria-labelledby="modalEditarComentarioJuegoLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalEditarComentarioJuegoLabel">Editar Comentario de Juego</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="idValoracion">ID de Valoración</label>
                            <input type="text" class="form-control" id="idValoracion" readonly>
                        </div>
                        <div class="form-group">
                            <label for="nombreJuego">Nombre del Juego</label>
                            <input type="text" class="form-control" id="nombreJuego" readonly>
                        </div>
                        <div class="form-group">
                            <label for="nombreUsuario">Nombre de Usuario</label>
                            <input type="text" class="form-control" id="nombreUsuario" readonly>
                        </div>
                        <div class="form-group">
                            <label for="comentario">Comentario</label>
                            <textarea class="form-control" id="comentario" rows="4" maxlength="250"></textarea>
                            <p id="errorComentario" class="error-message text-danger"></p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editarComentariosJuego" class="btn btn-primary">Guardar Cambios</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Edición de FAQ -->
        <div class="modal fade dark-modal" id="modalEditarPregunta" tabindex="-1" aria-labelledby="modalEditarPreguntaLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalEditarPreguntaLabel">Editar FAQ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="id_FAQ">ID</label>
                            <input type="text" class="form-control" id="id_FAQ" readonly>
                        </div>
                        <div class="form-group">
                            <label for="pregunta">Pregunta</label>
                            <textarea class="form-control" id="pregunta" rows="4" maxlength="150"></textarea>
                        </div>
                        <p id="errorPregunta" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="respuesta">Respuesta</label>
                            <textarea class="form-control" id="respuesta" rows="4" maxlength="600"></textarea>
                        </div>
                        <p id="errorRespuesta" class="error-message text-danger"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editarPreguntaBtn" class="btn btn-primary">Guardar Cambios</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de añadir una FAQ -->
        <div class="modal fade dark-modal" id="modalAniadirFAQ" tabindex="-1" aria-labelledby="modalAniadirFAQLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalAniadirFAQLabel">Añadir FAQ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="pregunta">Pregunta</label>
                            <textarea class="form-control" id="preguntaAniadir" rows="4" maxlength="150"></textarea>
                        </div>
                        <p id="errorPreguntaAniadir" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="respuesta">Respuesta</label>
                            <textarea class="form-control" id="respuestaAniadir" rows="4" maxlength="600"></textarea>
                        </div>
                        <p id="errorRespuestaAniadir" class="error-message text-danger"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="agregarFAQBtn" class="btn btn-primary">Agregar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de añadir admin -->
        <div class="modal fade dark-modal" id="modalAniadirAdmin" tabindex="-1" aria-labelledby="modalAniadirAdminLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalAniadirAdminLabel">Añadir admin</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="usuarioAdmin">Usuario</label>
                            <input type="text" class="form-control" id="usuarioAdmin">
                        </div>
                        <p id="errorUsuarioAdmin" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="contraAdmin">Contraseña</label>
                            <input type="text" class="form-control" id="contraAdmin">
                        </div>
                        <p id="errorContraAdmin" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="nombreAdmin">Nombre</label>
                            <input type="text" class="form-control" id="nombreAdmin">
                        </div>
                        <p id="errorNombreAdmin" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="apellidosAdmin">Apellidos</label>
                            <input type="text" class="form-control" id="apellidosAdmin">
                        </div>
                        <p id="errorApellidosAdmin" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="correoAdmin">Email</label>
                            <input type="text" class="form-control" id="correoAdmin">
                        </div>
                        <p id="errorCorreoAdmin" class="error-message text-danger"></p>
                        <div class="form-group">
                            <label for="fechaNacimientoAdmin" class="form-label">Fecha de nacimiento</label>
                            <input type="date" class="form-control" 
                                   id="fechaNacimiento" name="fechaNacimientoAdmin" min="1940-01-01" max="2008-12-31">
                        </div>
                        <p id="errorFechaNacimientoAdmin" class="error-message text-danger"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="aniadirNuevoAdmin" class="btn btn-primary">Añadir</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal de confirmacion de eliminar un usuario -->
        <div class="modal fade dark-modal" id="eliminarUsuarioModal" tabindex="-1" aria-labelledby="eliminarUsuarioModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarUsuarioModalLabel">Confirmar eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Desea eliminar al usuario <span id="usuarioEliminar"></span>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="eliminarUsuarioBtn">Eliminar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de confirmacion de eliminar un comentario -->

        <div class="modal fade dark-modal" id="eliminarComentarioModal" tabindex="-1" aria-labelledby="eliminarComentarioModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarComentarioModalLabel">Confirmar eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que quieres borrar este comentario?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="eliminarComentarioBtn">Eliminar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de confirmacion de eliminar todos los comentarios -->

        <div class="modal fade dark-modal" id="eliminarTodosLosComentarios" tabindex="-1" aria-labelledby="eliminarTodosLosComentariosLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarTodosLosComentariosLabel">Confirmar eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que quieres borrar todos los comentarios de este juego?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="eliminarTodosLosComentariosBtn">Eliminar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de confirmacion de eliminar un FQA -->

        <div class="modal fade dark-modal" id="eliminarFAQ" tabindex="-1" aria-labelledby="eliminarFAQLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarFAQLabel">Confirmar eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que desea borrar la FAQ?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="eliminarFAQBtn">Eliminar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- bootstrap5 -->
        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
        <!-- DATATABLES -->
        <script src="datatables/datatables.min.js"></script>  
    </body>
</html>
