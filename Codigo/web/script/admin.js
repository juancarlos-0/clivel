$(document).ready(function () {
    var tablaUsuarios;

    // Evento clic en el botón "Usuarios"
    $('#usuariosOpciones').click(function () {
        // Si la tabla ya se ha inicializado, ocultarla y destruir la instancia
        if (tablaUsuarios) {
            $('#tablaUsuarios').hide();
            tablaUsuarios.destroy();
            tablaUsuarios = null;
            return;
        }

        // Realizar petición AJAX para obtener los datos
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
                        {data: 'correo', title: 'Email'}
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

                // Evento clic en una fila principal
                $('#tablaUsuarios tbody').on('click', 'tr', function () {
                    var fila = tablaUsuarios.row(this);
                    var rowData = fila.data();

                    if (fila.child.isShown()) {
                        // La fila de detalle ya está visible, ocultarla
                        fila.child.hide();
                        $(this).removeClass('shown');
                    } else {
                        // La fila de detalle no está visible, mostrarla
                        fila.child(obtenerDetalleUsuario(rowData)).show();
                        $(this).addClass('shown');
                    }
                });
            },
            error: function (xhr, status, error) {
                // Manejar el error de la petición AJAX
                console.error('Error al obtener los datos de usuarios:', error);
            }
        });
    });

    // Función para obtener el contenido de la fila de detalle
    function obtenerDetalleUsuario(data) {
        // Verificar si las URL de la foto y el fondo están vacías y asignar una URL predeterminada si es así
        var fotoURL = data.foto ? data.foto : 'img/usuario.png';
        var fondoHTML = data.fondo ? '<img src="' + data.fondo + '" style="width: 200px; height: 150px;">' : 'Sin fondo';

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
                '<p><strong>Descripción:</strong> ' + data.descripcion + '</p>' +
                '<p><strong>Rol:</strong> ' + data.rol + '</p>' +
                '</div>' +
                '</div>' +
                '</td>' +
                '</tr>';



        return detalleHTML;
    }

});
