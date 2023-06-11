$(document).ready(function () {
    var tablaUsuarios;
    var tablaJuegos;
    var tablaComentarios;
    var datosDelJuego = "";

    // Realizar petición AJAX para obtener los datos
    function obtenerDatosUsuarios() {
        $.ajax({
            url: 'ajax/obtenerUsuarios.jsp',
            method: 'GET',
            dataType: 'json',
            success: function (usuarios) {
                // Inicializar DataTable con los datos de usuarios
                tablaUsuarios = $('#tablaUsuarios').DataTable({
                    data: usuarios,
                    columns: [
                        {data: 'id_usuario', title: 'ID'},
                        {data: 'usuario', title: 'Usuario'},
                        {data: 'nombre', title: 'Nombre'},
                        {data: 'apellidos', title: 'Apellidos'},
                        {data: 'correo', title: 'Email'},
                        {
                            data: null,
                            title: 'Acciones',
                            className: 'acciones',
                            defaultContent: '<button class="btn-accion editar"><i class="bi bi-pencil"></i></button><button class="btn-accion eliminar"><i class="bi bi-trash"></i></button><button class="btn-accion mas"><i class="bi bi-plus"></i></button>'
                        }
                    ], language: {
                        "sProcessing": "Procesando...",
                        "sLengthMenu": "Mostrar _MENU_ registros",
                        "sZeroRecords": "No se encontraron resultados",
                        "sEmptyTable": "Ningún dato disponible en la tabla usuarios",
                        "sInfo": "Mostrando usuarios del _START_ al _END_ de un total de _TOTAL_ usuarios",
                        "sInfoEmpty": "Mostrando usuarios del 0 al 0 de un total de 0 usuarios",
                        "sInfoFiltered": "(filtrado de un total de _MAX_ usuarios)",
                        "sInfoPostFix": "",
                        "sSearch": "Buscar:",
                        "sUrl": "",
                        "sInfoThousands": ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                        },
                        "buttons": {
                            "copy": "Copiar",
                            "colvis": "Visibilidad"
                        }
                    }
                });
                // Mostrar la tabla
                $('#tablaUsuarios').show();

                // Adjuntar evento clic al botón "Más"
                adjuntarEventoClickMas();

                // datos del modal al pulsar el boton de editar
                $('#tablaUsuarios tbody').on('click', '.editar', function () {
                    var fila = tablaUsuarios.row($(this).closest('tr'));
                    var rowData = fila.data();

                    // Obtener los datos del usuario seleccionado
                    var idUsuario = rowData.id_usuario;
                    var usuario = rowData.usuario;
                    var nombre = rowData.nombre;
                    var apellidos = rowData.apellidos;
                    var correo = rowData.correo;
                    var foto = rowData.foto;
                    var fondo = rowData.fondo;
                    var descripcion = rowData.descripcion;
                    var rol = rowData.rol;

                    // Obtener los campos del modal
                    var editarUsuarioID = $('#editarUsuarioID');
                    var editarUsuarioUsuario = $('#editarUsuarioUsuario');
                    var editarUsuarioNombre = $('#editarUsuarioNombre');
                    var editarUsuarioApellidos = $('#editarUsuarioApellidos');
                    var editarUsuarioCorreo = $('#editarUsuarioCorreo');
                    var editarUsuarioFoto = $('#editarUsuarioFoto');
                    var editarUsuarioFondo = $('#editarUsuarioFondo');
                    var editarUsuarioDescripcion = $('#editarUsuarioDescripcion');
                    var editarUsuarioRol = $('#editarUsuarioRol');

                    // Asignar los valores a los campos del modal
                    editarUsuarioID.val(idUsuario);
                    editarUsuarioUsuario.val(usuario);
                    editarUsuarioNombre.val(nombre);
                    editarUsuarioApellidos.val(apellidos);
                    editarUsuarioCorreo.val(correo);
                    editarUsuarioFoto.val(foto);
                    editarUsuarioFondo.val(fondo);
                    editarUsuarioDescripcion.val(descripcion);
                    editarUsuarioRol.val(rol);

                    // Mostrar el modal
                    $('#editarUsuarioModal').modal('show');
                });

                // Variable para el nombre del usuario
                var nUsuario = "";
                // Evento clic en el botón "Eliminar"
                $('#tablaUsuarios tbody').on('click', '.eliminar', function () {
                    var fila = $(this).closest('tr');
                    var idUsuario = tablaUsuarios.row(fila).data().id_usuario;
                    nUsuario = tablaUsuarios.row(fila).data().usuario;
                    $('#usuarioEliminar').text(nUsuario);
                    $('#eliminarUsuarioBtn').data('id', idUsuario);
                    $('#eliminarUsuarioModal').modal('show');
                });

                // Evento clic en el botón "Eliminar" del modal de confirmación
                $('#eliminarUsuarioBtn').on('click', function () {
                    // Obtener el ID de usuario a eliminar
                    var idUsuario = $(this).data('id');

                    // Realizar la solicitud AJAX
                    $.ajax({
                        url: 'ajax/admin/eliminarUsuario.jsp',
                        type: 'POST',
                        dataType: 'json',
                        data: {idUsuario: idUsuario},
                        success: function (response) {
                            if (response.success) {

                                // Mostrar mensaje de eliminación
                                mostrarMensaje('"' + nUsuario + '" ha sido eliminado correctamente.');

                                // Obtener el índice de la fila que cumple con el ID de usuario
                                var indiceFila = tablaUsuarios.rows().eq(0).filter(function (indice) {
                                    return tablaUsuarios.row(indice).data().id_usuario === idUsuario;
                                });

                                // Eliminar la fila correspondiente
                                tablaUsuarios.row(indiceFila).remove().draw();

                            } else {
                                alert('Error al eliminar el usuario.');
                            }
                        },
                        error: function (xhr, status, error) {
                            alert('Error en la solicitud AJAX.');
                        }
                    });
                    // Cerrar el modal de confirmación
                    $('#eliminarUsuarioModal').modal('hide');
                });

            },
            error: function (xhr, status, error) {
                // Manejar el error de la petición AJAX
                console.error('Error al obtener los datos de usuarios:', error);
            }


        });

    }

    // Función para adjuntar el evento clic al botón "Más"
    function adjuntarEventoClickMas() {
        console.log("Evento clic en el botón 'Más' adjuntado correctamente.");
        $('#tablaUsuarios tbody').on('click', '.btn-accion.mas', function () {
            var fila = $(this).closest('tr');
            var rowData = tablaUsuarios.row(fila).data();

            if (fila.hasClass('shown')) {
                // La fila de detalle ya está visible, ocultarla
                fila.next().remove();
                fila.removeClass('shown');
            } else {
                // La fila de detalle no está visible, mostrarla
                fila.after(obtenerDetalleUsuario(rowData));
                fila.addClass('shown');
            }
        });
    }

    // Realizar petición AJAX para obtener los comentarios de los juegos
    function obtenerComentarios() {
        $.ajax({
            url: 'ajax/admin/obtenerJuegos.jsp',
            method: 'GET',
            dataType: 'json',
            success: function (juegos) {
                // Inicializar DataTable con los datos de usuarios
                tablaJuegos = $('#tablaJuegos').DataTable({
                    data: juegos,
                    columns: [
                        {data: 'id_juego', title: 'ID'},
                        {data: 'nombre', title: 'Juego'},
                        {data: 'fechaLanzamiento', title: 'Fecha de lanzamiento'},
                        {data: 'numeroComentarios', title: 'Comentarios'},
                        {
                            data: null,
                            title: 'Acciones',
                            className: 'acciones',
                            defaultContent: '<button class="btn-accion ver-comentarios" title="Ver comentarios"><i class="bi bi-eye"></i></button><button class="btn-accion eliminar-comentarios" title="Eliminar todos los comentarios"><i class="bi bi-trash"></i></button>'
                        }
                    ], language: {
                        "sProcessing": "Procesando...",
                        "sLengthMenu": "Mostrar _MENU_ registros",
                        "sZeroRecords": "No se encontraron resultados",
                        "sEmptyTable": "Ningún dato disponible en la tabla comentarios",
                        "sInfo": "Mostrando comentarios del _START_ al _END_ de un total de _TOTAL_ comentarios",
                        "sInfoEmpty": "Mostrando comentarios del 0 al 0 de un total de 0 comentarios",
                        "sInfoFiltered": "(filtrado de un total de _MAX_ comentarios)",
                        "sInfoPostFix": "",
                        "sSearch": "Buscar:",
                        "sUrl": "",
                        "sInfoThousands": ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                        },
                        "buttons": {
                            "copy": "Copiar",
                            "colvis": "Visibilidad"
                        }
                    }
                });
                // Mostrar la tabla
                $('#tablaJuegos').show();

            },
            error: function (xhr, status, error) {
                // Manejar el error de la petición AJAX
                console.error('Error al obtener los datos de usuarios:', error);
            }
        });
    }

    // Evento click al botón para poder eliminar todos los comentarios de un juego
    $('#tablaJuegos').on('click', '.eliminar-comentarios', function () {
        var juego = tablaJuegos.row($(this).closest('tr')).data();
        var juegoId = juego.id_juego;
        var numeroComentarios = juego.numeroComentarios;

        // Si hay comentarios en el juego entonces permitir el eliminarlos
        if (numeroComentarios > 0) {
            // Mostrar modal de confirmación
            $('#eliminarTodosLosComentarios').modal('show');

            // Evento de clic en el botón de confirmación del modal
            $('#eliminarTodosLosComentarios').on('click', '#eliminarTodosLosComentariosBtn', function () {
                // Realizar solicitud AJAX para eliminar los comentarios del juego
                $.ajax({
                    url: 'ajax/admin/eliminarTodosLosComentariosDeUnJuego.jsp',
                    method: 'POST',
                    data: {juegoId: juegoId},
                    dataType: 'json',
                    success: function (response) {

                        // Buscar la fila correspondiente al id del juego
                        var fila = tablaJuegos.rows().eq(0).filter(function (rowIdx) {
                            var rowData = tablaJuegos.row(rowIdx).data();
                            return rowData.id_juego.toString() === juegoId.toString();
                        });

                        // Verificar si se encontró alguna fila
                        if (fila.length > 0) {
                            // Obtener el índice de la fila filtrada
                            var indiceFila = fila[0];

                            // Obtener la celda correspondiente al campo de comentarios en la fila encontrada
                            var celdaComentario = tablaJuegos.cell(indiceFila, 3);

                            // Actualizar el valor del campo de comentarios
                            celdaComentario.data("0");

                            // Volver a dibujar la tabla para reflejar los cambios
                            tablaJuegos.draw(false);
                        } else {
                            console.log("nNo se ha podido actualizar la fila");
                        }

                        // Mostrar mensaje de eliminación
                        mostrarMensaje('Todos los comentarios del juego han sido eliminado correctamente.');

                        // Ocultar el modal
                        $('#eliminarTodosLosComentarios').modal('hide');
                    },
                    error: function (xhr, status, error) {
                        console.error('Error al eliminar los comentarios:', error);
                    }
                });
            });
        } else {
            // Mostrar mensaje de eliminación
            mostrarMensaje('El juego seleccionado no tiene comentarios para borrar.', true);
        }

    });



    // Evento clic en el botón "Ver comentarios"
    $('#tablaJuegos').on('click', '.ver-comentarios', function () {
        // Obtener los datos de la fila seleccionada
        var datosDelJuego = tablaJuegos.row($(this).closest('tr')).data();

        if (datosDelJuego && datosDelJuego.id_juego) {
            // Cerrar la tabla de juegos
            $('#tablaJuegos').hide();
            tablaJuegos.destroy();
            tablaJuegos = null;

            // Obtener y mostrar los comentarios para el juego seleccionado
            obtenerComentariosJuego(datosDelJuego.id_juego);
        } else {
            console.error('No se pudo obtener los datos del juego.');
        }
    });

    // Función para obtener y mostrar los comentarios para un juego específico
    function obtenerComentariosJuego(idJuego) {
        $.ajax({
            url: 'ajax/admin/obtenerComentariosJuegos.jsp',
            method: 'GET',
            data: {id_juego: idJuego},
            dataType: 'json',
            success: function (comentarios) {
                // Inicializar DataTable con los datos de comentarios
                tablaComentarios = $('#tablaComentarios').DataTable({
                    data: comentarios,
                    columns: [
                        {data: 'id_valoracion', title: 'ID Valoración'},
                        {data: 'nombre_juego', title: 'Juego'},
                        {data: 'nombre_usuario', title: 'Usuario'},
                        {data: 'comentario', title: 'Comentario'},
                        {data: 'opinion', title: 'Opinión'},
                        {data: 'fecha_valoracion', title: 'Fecha de Valoración'},
                        {data: 'likes', title: 'Like'},
                        {data: 'dislikes', title: 'Dislike'},
                        {
                            title: 'Acciones',
                            className: 'acciones',
                            render: function (data, type, row) {
                                return '<button class="btn-accion editar-comentario-juego" title="Editar"><i class="bi bi-pencil"></i></button>' +
                                        '<button class="btn-accion borrar-comentario-juego" title="Borrar"><i class="bi bi-trash"></i></button>';
                            }
                        }
                    ],
                    language: {
                        "sProcessing": "Procesando...",
                        "sLengthMenu": "Mostrar _MENU_ registros",
                        "sZeroRecords": "No se encontraron resultados",
                        "sEmptyTable": "Ningún dato disponible en la tabla comentarios",
                        "sInfo": "Mostrando comentarios del _START_ al _END_ de un total de _TOTAL_ comentarios",
                        "sInfoEmpty": "Mostrando comentarios del 0 al 0 de un total de 0 comentarios",
                        "sInfoFiltered": "(filtrado de un total de _MAX_ comentarios)",
                        "sInfoPostFix": "",
                        "sSearch": "Buscar:",
                        "sUrl": "",
                        "sInfoThousands": ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                        },
                        "buttons": {
                            "copy": "Copiar",
                            "colvis": "Visibilidad"
                        }
                    }
                });

                // Mostrar la tabla de comentarios
                $('#tablaComentarios').show();

                // Evento clic en el botón "Borrar comentario" para poner eliminar el comentario específico de un juego
                $('#tablaComentarios').on('click', '.borrar-comentario-juego', function () {
                    // Obtener los datos de la fila seleccionada
                    var data = tablaComentarios.row($(this).closest('tr')).data();

                    // Guardar una referencia al elemento $(this)
                    var botonBorrar = $(this);

                    // Guardar una referencia al comentario que se va a eliminar
                    var comentarioEliminar = data.comentario;

                    // Mostrar el modal de confirmación
                    $('#eliminarComentarioModal').modal('show');

                    // Actualizar el texto dentro del modal con el comentario que se va a eliminar
                    $('#comentarioEliminar').text(comentarioEliminar);

                    // Evento clic en el botón "Eliminar" del modal de confirmación
                    $('#eliminarComentarioBtn').click(function () {
                        // Realizar la solicitud AJAX para eliminar el comentario
                        $.ajax({
                            url: 'ajax/admin/eliminarComentarioJuego.jsp',
                            method: 'POST',
                            data: {id_valoracion: data.id_valoracion},
                            success: function () {
                                // Eliminar la fila de la tabla utilizando la referencia guardada
                                tablaComentarios.row(botonBorrar.closest('tr')).remove().draw();

                                // Mostrar mensaje al usuario de que se ha borrado correctamente
                                mostrarMensaje('El comentario ha sido eliminado correctamente.');

                                // Cerrar el modal de confirmación
                                $('#eliminarComentarioModal').modal('hide');
                            },
                            error: function (xhr, status, error) {
                                // Manejar el error de la petición AJAX
                                console.error('Error al eliminar el comentario:', error);
                            }
                        });
                    });
                });


                // Función para mostrar el modal de editar los comentarios
                function mostrarModalEdicionComentario(idValoracion, nombreJuego, nombreUsuario, comentario) {
                    // Rellenar los campos del modal con los datos del comentario
                    $('#idValoracion').val(idValoracion);
                    $('#nombreJuego').val(nombreJuego).prop('readonly', true);
                    $('#nombreUsuario').val(nombreUsuario).prop('readonly', true);
                    $('#comentario').val(comentario);

                    // Abrir el modal para editar
                    $('#modalEditarComentarioJuego').modal('show');
                }

                // Evento clic en el botón "Editar" de un comentario de juego
                $('#tablaComentarios').on('click', '.editar-comentario-juego', function () {
                    // Obtener los datos de la fila seleccionada
                    var data = tablaComentarios.row($(this).closest('tr')).data();

                    // Obtener los valores de los campos del comentario
                    var idValoracion = data.id_valoracion;
                    var nombreJuego = data.nombre_juego;
                    var nombreUsuario = data.nombre_usuario;
                    var comentario = data.comentario;

                    // Mostrar el modal de edición de comentario con los datos
                    mostrarModalEdicionComentario(idValoracion, nombreJuego, nombreUsuario, comentario);
                });

                // Evento al hacer clic en el botón "Guardar Cambios" del editar comentario
                $('#editarComentariosJuego').click(function () {
                    // Obtener los valores actualizados del formulario
                    var idValoracion = $('#idValoracion').val();
                    var nuevoComentario = $('#comentario').val();

                    // Validar si el campo de comentario está vacío
                    if (nuevoComentario.trim() === '') {
                        $('#errorComentario').text('Si el comentario está vacío lo correcto sería borrarlo.');
                        return;
                    }

                    // Crear un objeto con los datos a enviar al servidor
                    var datos = {
                        id_valoracion: idValoracion,
                        nuevo_comentario: nuevoComentario
                    };

                    // Enviar la solicitud AJAX al servidor para guardar los cambios
                    $.ajax({
                        url: 'ajax/admin/editarComentarioJuego.jsp',
                        method: 'POST',
                        data: datos,
                        dataType: 'json',
                        success: function (respuesta) {
                            // La solicitud se ha completado correctamente
                            if (respuesta.success) {

                                // Cerrar el modal
                                $('#modalEditarComentarioJuego').modal('hide');

                                // Mostrar mensaje al usuario de que se ha editado correctamente
                                mostrarMensaje('El comentario ha sido editado correctamente.');

                                // Buscar la fila correspondiente al idValoracion
                                var fila = tablaComentarios.rows().eq(0).filter(function (rowIdx) {
                                    var rowData = tablaComentarios.row(rowIdx).data();
                                    return rowData.id_valoracion.toString() === idValoracion.toString();
                                });

                                // Verificar si se encontró alguna fila
                                if (fila.length > 0) {
                                    // Obtener el índice de la fila filtrada
                                    var indiceFila = fila[0];

                                    // Obtener la celda correspondiente al campo de comentarios en la fila encontrada
                                    var celdaComentario = tablaComentarios.cell(indiceFila, 3);

                                    // Actualizar el valor del campo de comentarios
                                    celdaComentario.data(nuevoComentario);

                                    // Volver a dibujar la tabla para reflejar los cambios
                                    tablaComentarios.draw(false);
                                } else {
                                    console.log("No se encontró la fila correspondiente a idValoracion: " + idValoracion);
                                }

                            } else {
                                console.log("Error al editar el comentario");
                            }
                        },
                        error: function () {
                            console.log("Error al editar el comentario");
                        }
                    });
                });

            },
            error: function (xhr, status, error) {
                // Manejar el error de la petición AJAX
                console.error('Error al obtener los comentarios del juego:', error);
            }
        });
    }

    // Función para comprobar que los campos del editar usuario sean correctos
    $('#editarUsuarioBtn').click(function () {
        // Obtener los valores de los campos
        var idUsuario = $('#editarUsuarioID').val();
        var usuario = $('#editarUsuarioUsuario').val();
        var nombre = $('#editarUsuarioNombre').val();
        var apellidos = $('#editarUsuarioApellidos').val();
        var correo = $('#editarUsuarioCorreo').val();
        var foto = $('#editarUsuarioFoto').val();
        var fondo = $('#editarUsuarioFondo').val();
        var descripcion = $('#editarUsuarioDescripcion').val();
        var rol = $('#editarUsuarioRol').val();

        // Obtener los campos de errores
        var errorUsuario = $('#errorUsuario');
        var errorNombre = $('#errorNombre');
        var errorApellidos = $('#errorApellidos');
        var errorCorreo = $('#errorCorreo');
        var errorDescripcion = $('#errorDescripcion');

        // Validar los campos utilizando expresiones regulares
        var regexUsuario = /^[a-zA-Z0-9]{3,20}$/;
        var regexNombre = /^[a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{2,20}$/;
        var regexApellidos = /^[a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{2,25}$/;
        var regexCorreo = /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;
        var regexDescripcion = /^[a-zA-Z0-9\s.(){}\[\]\-_=:,;]{1,250}$/;

        // Limpiar los campos de errores
        errorUsuario.text('');
        errorNombre.text('');
        errorApellidos.text('');
        errorCorreo.text('');
        errorDescripcion.text('');

        // Realizar la validación de cada campo
        var tieneErrores = false;

        // Validar campo 'Usuario'
        if (usuario.trim() === '') {
            errorUsuario.text("El campo 'Usuario' no puede estar vacío.");
            tieneErrores = true;
        } else if (usuario.length > 20) {
            errorUsuario.text("El campo 'Usuario' no puede superar los 20 caracteres.");
            tieneErrores = true;
        } else if (!regexUsuario.test(usuario)) {
            errorUsuario.text("El campo 'Usuario' deben ser letras y números.");
            tieneErrores = true;
        }

        // Validar campo 'Nombre'
        if (nombre.trim() === '') {
            errorNombre.text("El campo 'Nombre' no puede estar vacío.");
            tieneErrores = true;
        } else if (nombre.length > 20) {
            errorNombre.text("El campo 'Nombre' no puede superar los 20 caracteres.");
            tieneErrores = true;
        } else if (!regexNombre.test(nombre)) {
            errorNombre.text("El campo 'Nombre' deben ser letras.");
            tieneErrores = true;
        }

        // Validar campo 'Apellidos'
        if (apellidos.trim() === '') {
            errorApellidos.text("El campo 'Apellidos' no puede estar vacío.");
            tieneErrores = true;
        } else if (apellidos.length > 25) {
            errorApellidos.text("El campo 'Apellidos' no puede superar los 25 caracteres.");
            tieneErrores = true;
        } else if (!regexApellidos.test(apellidos)) {
            errorApellidos.text("El campo 'Apellidos' deben ser letras.");
            tieneErrores = true;
        }

        // Validar campo 'Email'
        if (correo.trim() === '') {
            errorCorreo.text("El campo 'Email' no puede estar vacío.");
            tieneErrores = true;
        } else if (correo.length > 50) {
            errorCorreo.text("El campo 'Email' no puede superar los 50 caracteres.");
            tieneErrores = true;
        } else if (!regexCorreo.test(correo)) {
            errorCorreo.text("El campo 'Email' no tiene la sintaxis correcta.");
            tieneErrores = true;
        }

        // Validar campo 'Descripción'
        if (descripcion.trim() !== '') {
            if (descripcion.length > 250) {
                errorDescripcion.text("El campo 'Descripción' no puede superar los 250 caracteres.");
                tieneErrores = true;
            } else if (!regexDescripcion.test(descripcion)) {
                errorDescripcion.text("El campo 'Descripción' no es válido.");
                tieneErrores = true;
            }
        }


        // Realizar la acción de edición si no hay errores
        if (!tieneErrores) {
            // Realizar la llamada Ajax para comprobar la existencia del usuario y el correo
            $.ajax({
                url: 'ajax/admin/validar_usuario_correo.jsp',
                type: 'POST',
                data: {
                    idUsuario: idUsuario,
                    usuario: usuario,
                    correo: correo
                },
                success: function (response) {
                    // Verificar la respuesta del servidor
                    if (response.usuarioExistente) {
                        errorUsuario.text('El usuario ya existe. Por favor, elige otro.');
                        tieneErrores = true;
                    }
                    if (response.correoExistente) {
                        errorCorreo.text('El correo ya está en uso. Por favor, utiliza otro.');
                        tieneErrores = true;
                    }

                    // si no tiene errores entonces actualizamos el usuario
                    if (!tieneErrores) {
                        // Realizar la llamada Ajax para actualizar los datos del usuario
                        $.ajax({
                            url: 'ajax/admin/actualizarUsuario.jsp',
                            type: 'POST',
                            data: {
                                idUsuario: idUsuario,
                                usuario: usuario,
                                nombre: nombre,
                                apellidos: apellidos,
                                correo: correo,
                                foto: foto,
                                fondo: fondo,
                                descripcion: descripcion,
                                rol: rol
                            },
                            success: function (response) {
                                // Cerrar el modal
                                $('#editarUsuarioModal').modal('hide');
                                // Verificar si la tabla ya está abierta
                                if (tablaUsuarios) {
                                    // Ocultar la tabla
                                    $('#tablaUsuarios').hide();

                                    // Destruir la tabla
                                    tablaUsuarios.destroy();
                                    tablaUsuarios = null;
                                }

                                // Obtener los datos y abrir nuevamente la tabla
                                obtenerDatosUsuarios();

                                // Mostrar mensaje de que se ha borrado
                                mostrarMensaje('"' + usuario + '" ha sido editado correctamente.');

                            },
                            error: function () {
                                // Manejar el error de la llamada Ajax
                                console.log('Error en la llamada Ajax');
                            }
                        });
                    }

                },
                error: function () {
                    // Manejar el error de la llamada Ajax
                    console.log('Error en la llamada Ajax');
                }
            });
        }

    });

    // Cuando se cierre la ventana modal de editar usuario quitar mensajes de error
    $('#editarUsuarioModal').on('hidden.bs.modal', function () {
        $('#errorUsuario').text('');
        $('#errorNombre').text('');
        $('#errorApellidos').text('');
        $('#errorCorreo').text('');
        $('#errorDescripcion').text('');
    });

    // Cuando se cierre la ventana modal de editar los mensajes quitar mensajes de error
    $('#modalEditarComentarioJuego').on('hidden.bs.modal', function () {
        $('#errorComentario').text('');
    });

    // Evento clic en el botón "Usuarios"
    $('#usuariosOpciones').click(function () {
        if (tablaUsuarios) {
            // Si la tabla usuarios está abierta, no hacer nada
            return;
        }

        if (tablaJuegos) {
            // Si la tabla juegos está abierta, cerrarla
            $('#tablaJuegos').hide();
            tablaJuegos.destroy();
            tablaJuegos = null;
        }

        if (tablaComentarios) {
            // Si la tabla comentarios está abierta, cerrarla
            $('#tablaComentarios').hide();
            tablaComentarios.destroy();
            tablaComentarios = null;
        }

        // Obtener los datos de usuarios y crear la tabla
        obtenerDatosUsuarios();
    });

    // Evento clic en el botón "Comentarios"
    $('#comentariosOpciones').click(function () {
        if (tablaJuegos) {
            // Si la tabla juegos está abierta, no hacer nada
            return;
        }

        if (tablaUsuarios) {
            // Si la tabla usuarios está abierta, cerrarla
            $('#tablaUsuarios').hide();
            tablaUsuarios.destroy();
            tablaUsuarios = null;
        }

        if (tablaComentarios) {
            // Si la tabla comentarios está abierta, cerrarla
            $('#tablaComentarios').hide();
            tablaComentarios.destroy();
            tablaComentarios = null;
        }

        // Obtener los datos de comentarios y crear la tabla
        obtenerComentarios();

        adjuntarEventoClickMas();

    });


    // Función para obtener el contenido de la fila de detalle
    function obtenerDetalleUsuario(data) {
        // Verificar si las URL de la foto y el fondo están vacías y asignar una URL predeterminada si es así
        var fotoURL = data.foto ? data.foto : 'img/usuario.png';
        var fondoHTML = data.fondo ? '<img src="' + data.fondo + '" style="width: 200px; height: 150px;">' : 'Sin fondo';

        // Verificar si hay descripción o no
        var descripcion = data.descripcion ? data.descripcion : 'Sin descripción';

        // Variable con el contenido en HTML que se mostrará como extra de cada fila
        var detalleHTML = '<tr class="detalle">' +
                '<td colspan="5">' +
                '<div class="detalle-container">' +
                '<p class="detalle-titulo"><strong>Detalles del usuario<strong/></p>' +
                '<div class="detalle-info">' +
                '<p><strong>ID:</strong> ' + data.id_usuario + '</p>' +
                '<p><strong>Usuario:</strong> ' + data.usuario + '</p>' +
                '<p><strong>Nombre:</strong> ' + data.nombre + '</p>' +
                '<p><strong>Apellidos:</strong> ' + data.apellidos + '</p>' +
                '<p><strong>Email:</strong> ' + data.correo + '</p>' +
                '<p><strong>Foto:</strong> <img src="' + fotoURL + '" style="width: 49px; height: 49px;"></p>' +
                '<p><strong>Fondo:</strong> ' + fondoHTML + '</p>' +
                '<p><strong>Descripción:</strong> ' + descripcion + '</p>' +
                '<p><strong>Rol:</strong> ' + data.rol + '</p>' +
                '</div>' +
                '</div>' +
                '</td>' +
                '</tr>';

        return detalleHTML;
    }

});

// Función para borrar el contenido que tiene el campo foto y fondo
function borrarContenido(idCampo) {
    document.getElementById(idCampo).value = '';
}

// Función para mostrar un mensaje emergente
function mostrarMensaje(mensaje, error = false) {
    var mensajeElemento = $('<div>').addClass('mensaje').text(mensaje);

    // Agregar el mensaje al cuerpo del documento
    $('body').prepend(mensajeElemento);

    // Agregar estilos de error y de verificación
    if (error) {
        mensajeElemento.css({
            position: 'fixed',
            top: '20px',
            right: '20px',
            background: '#FF5A5A',
            color: '#FFF',
            padding: '10px',
            borderRadius: '5px',
            zIndex: 999
        });
    } else {
        mensajeElemento.css({
            position: 'fixed',
            top: '20px',
            right: '20px',
            background: '#4CAF50',
            color: '#FFF',
            padding: '10px',
            borderRadius: '5px',
            zIndex: 999
        });
    }

    // Animación para mostrar y ocultar el mensaje
    mensajeElemento.fadeIn(500).delay(3000).fadeOut(500, function () {
        $(this).remove();
    });
}