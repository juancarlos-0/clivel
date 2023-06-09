$(document).ready(function () {
    var tablaUsuarios;

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

                // Evento clic en el botón "Más"
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
                    var descripcion = rowData.descripcion;
                    var rol = rowData.rol;

                    // Obtener los campos del modal
                    var editarUsuarioID = $('#editarUsuarioID');
                    var editarUsuarioUsuario = $('#editarUsuarioUsuario');
                    var editarUsuarioNombre = $('#editarUsuarioNombre');
                    var editarUsuarioApellidos = $('#editarUsuarioApellidos');
                    var editarUsuarioCorreo = $('#editarUsuarioCorreo');
                    var editarUsuarioFoto = $('#editarUsuarioFoto');
                    var editarUsuarioDescripcion = $('#editarUsuarioDescripcion');
                    var editarUsuarioRol = $('#editarUsuarioRol');

                    // Asignar los valores a los campos del modal
                    editarUsuarioID.val(idUsuario);
                    editarUsuarioUsuario.val(usuario);
                    editarUsuarioNombre.val(nombre);
                    editarUsuarioApellidos.val(apellidos);
                    editarUsuarioCorreo.val(correo);
                    editarUsuarioFoto.val(foto);
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

                // Función para mostrar un mensaje emergente
                function mostrarMensaje(mensaje, error = false) {
                    var mensajeElemento = $('<div>').addClass('mensaje').text(mensaje);

                    if (error) {
                        mensajeElemento.addClass('error');
                    } else {
                        mensajeElemento.addClass('success');
                    }

                    // Agregar el mensaje al cuerpo del documento
                    $('body').prepend(mensajeElemento);

                    // Establecer estilos CSS para posicionar el mensaje en la esquina superior derecha
                    mensajeElemento.css({
                        position: 'fixed',
                        top: '20px',
                        right: '20px',
                        background: '#4CAF50',
                        color: '#FFF',
                        padding: '10px',
                        borderRadius: '5px'
                    });

                    // Animación para mostrar y ocultar el mensaje
                    mensajeElemento.fadeIn(500).delay(3000).fadeOut(500, function () {
                        $(this).remove();
                    });
                }



            },
            error: function (xhr, status, error) {
                // Manejar el error de la petición AJAX
                console.error('Error al obtener los datos de usuarios:', error);
            }
        });
    }

    // Evento clic en el botón "Usuarios"
    $('#usuariosOpciones').click(function () {
        // Si la tabla ya se ha inicializado, ocultarla y destruir la instancia
        if (tablaUsuarios) {
            $('#tablaUsuarios').hide();
            tablaUsuarios.destroy();
            tablaUsuarios = null;
            return;
        }

        // Obtener los datos de usuarios y crear la tabla
        obtenerDatosUsuarios();
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
                '<p class="detalle-titulo">Detalles del usuario:</p>' +
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
