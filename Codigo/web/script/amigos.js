/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

let idUsuarioChat = 0;
let listaAmigos = [];

$(document).ready(function () {

    // Variable de control para alternar entre favoritos y todos los usuarios
    var mostrarFavoritos = false;

    var resultados = [];

    $('#nombre-amigo').keyup(function () {
        let nombreAmigo = $('#nombre-amigo').val();
        let usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');

        $.ajax({
            url: 'ajax/buscarAmigos.jsp',
            type: 'POST',
            data: {nombreAmigo: nombreAmigo, usuarioNombre: usuarioNombre},
            success: function (data) {
                resultados = JSON.parse(data);
                mostrarResultados();
            }
        });
    });


    // Comprueba que el usuario haya escrito algo y luego dejado de escribir
    $('#nombre-amigo').on('input', function () {
        var input = $(this);
        var error = $('.errorAgregarAmigos');

        if (input.val() === '') {
            error.text('Campo vacío');
            error.css("display", "block");
            $('#resultados-amigos').scrollTop(0);
        } else {
            error.text('');
            error.css("display", "none");
        }
    });


    $('#resultados-amigos').on('click', 'li', function () {
        var nombre = $(this).text();
        $('#nombre-amigo').val(nombre);
        elegirResultado();
        $('#resultados-amigos').hide();
    });

    // muestra los resultados al agregar amigos en la ventana modal
    function mostrarResultados() {
        var contenedor = $('#resultados-amigos');
        contenedor.css('cursor', 'pointer');
        contenedor.empty();
        if (resultados.length > 0) {
            contenedor.show();
            for (var i = 0; i < resultados.length; i++) {
                var resultado = resultados[i];
                var li = $('<li>');
                var foto = $('<img>').addClass('foto-usuario');

                if (resultado.foto) {
                    foto.attr('src', resultado.foto);
                } else {
                    foto.attr('src', 'img/usuario.png'); // Ruta de imagen predeterminada
                }

                var usuario = $('<span>').text(resultado.usuario).addClass('nombre-usuario');
                li.append(foto, usuario);
                contenedor.append(li);
            }
        } else {
            contenedor.hide();
        }
    }



    function elegirResultado() {
        $('#resultados-amigos').on('click', 'li', function () {
            var nombre = $(this).text();
            $('#nombre-amigo').val(nombre);
            ocultarResultados();
            $('#nombre-amigo').focus();

        });
    }


    $('#nombre-amigo-eliminar').keyup(function () {
        let nombreAmigo = $('#nombre-amigo-eliminar').val();
        let usuarioSesion = $('#nombreUsuarioSesion').data('usuario-nombre');

        $.ajax({
            url: 'ajax/buscarAmigosEliminar.jsp',
            type: 'POST',
            data: {nombreAmigo: nombreAmigo, usuarioSesion: usuarioSesion},
            success: function (data) {
                resultados = JSON.parse(data);
                mostrarResultados2();
            }
        });
    });

    $('#resultados-amigos-eliminar').on('click', 'li', function () {
        var nombre = $(this).text();
        $('#nombre-amigo-eliminar').val(nombre);
        elegirResultado2();
        $('#resultados-amigos-eliminar').hide();
    });

    // Método para mostar los resultados en el eliminar amigo
    function mostrarResultados2() {
        var contenedor = $('#resultados-amigos-eliminar');
        contenedor.css('cursor', 'pointer');
        contenedor.empty();
        if (resultados.length > 0) {
            contenedor.show();
            for (var i = 0; i < resultados.length; i++) {
                var resultado = resultados[i];
                var li = $('<li>');
                var foto = $('<img>').addClass('foto-usuario');

                if (resultado.foto) {
                    foto.attr('src', resultado.foto);
                } else {
                    foto.attr('src', 'img/usuario.png'); // Ruta de imagen predeterminada
                }

                var usuario = $('<span>').text(resultado.usuario).addClass('nombre-usuario');
                li.append(foto, usuario);
                contenedor.append(li);
            }
        } else {
            contenedor.hide();
        }
    }

    // Metodo para elegiar el resultado en el input en el eliminar amigos
    function elegirResultado2() {
        $('#resultados-amigos-eliminar').on('click', 'li', function () {
            var nombre = $(this).text();
            $('#nombre-amigo-eliminar').val(nombre);
            ocultarResultados();
            $('#nombre-amigo-eliminar').focus();

        });
    }

    // Obtener contenedor donde irá la lista de amigos
    var contenedorListaAmigos = document.getElementById("contenedorListaAmigos");
    var idSesion = $('#idUsuarioSesion').data('usuario-id');

    // Función para agregar un nuevo amigo a la lista
    function agregarAmigo(usuario) {
        var button = document.createElement("button");
        button.type = "submit";
        button.classList.add("list-group-item", "list-group-item-action", "border-0", "bg-transparent", "p-0");
        button.name = "botonIrAChat";
        button.id = usuario.usuario;

        var inputUsuario = document.createElement("input");
        inputUsuario.type = "text";
        inputUsuario.style.display = "none";
        inputUsuario.value = usuario.usuario;
        inputUsuario.name = "nombre_usuario_chat";

        var listItem = document.createElement("li");
        listItem.classList.add("list-group-item", "d-flex", "justify-content-between", "align-items-center");
        listItem.id = "listaUsuarios";

        var contenedorUsuario = document.createElement("div"); // Contenedor para la imagen y el span
        contenedorUsuario.classList.add("d-flex", "align-items-center");

        var imgUsuario = document.createElement("img");
        imgUsuario.src = usuario.foto != null ? usuario.foto : "img/usuario.png";
        imgUsuario.alt = "imagen de usuario";
        imgUsuario.classList.add("rounded-circle", "me-2", "tooltipUsuario");
        imgUsuario.width = 49;
        imgUsuario.height = 49;

        var spanUsuario = document.createElement("span");
        spanUsuario.textContent = usuario.usuario;

        var spanEstrella = document.createElement("span");

        if (usuario.favorito) {
            spanEstrella.classList.add("estrella", "bi", "bi-star-fill");
        } else {
            spanEstrella.classList.add("estrella", "bi", "bi-star");
        }

        contenedorUsuario.appendChild(imgUsuario);
        contenedorUsuario.appendChild(spanUsuario);

        listItem.appendChild(contenedorUsuario);
        listItem.appendChild(spanEstrella);
        button.appendChild(inputUsuario);
        button.appendChild(listItem);
        contenedorListaAmigos.appendChild(button);

        // Evento para la estrella
        spanEstrella.addEventListener("click", function (event) {
            event.stopPropagation();
            // Verificar si el usuario es favorito o no
            var esFavorito = usuario.favorito;

            // Realizar la solicitud AJAX para marcar/desmarcar como favorito
            $.ajax({
                url: "ajax/marcarFavorito.jsp",
                method: "POST",
                data: {
                    idUsuario: usuario.id_usuario,
                    idSesion: idSesion,
                    favorito: !esFavorito // Invertir el estado de favorito
                },
                success: function (response) {
                    // Actualizar el estado de la estrella
                    usuario.favorito = !esFavorito;
                    spanEstrella.classList.toggle("bi-star-fill");
                    spanEstrella.classList.toggle("bi-star");
                },
                error: function (error) {
                    console.error("Error al marcar/desmarcar como favorito:", error);
                }
            });
        });

        // Evento que mostrará el chat de ese amigo
        button.addEventListener("click", function () {
            //Poner la img y nombre del usuario
            var contenedorInfoAmigoSeleccionado = $(".contenedorInfoAmigoSeleccionado");
            contenedorInfoAmigoSeleccionado.empty();

            var imgUsuarioChat = $("<img>").attr("src", usuario.foto != null ? usuario.foto : "img/usuario.png")
                    .attr("alt", "imagen de usuario")
                    .addClass("rounded-circle me-2 tooltipUsuario")
                    .attr("width", 49)
                    .attr("height", 49);

            var spanUsuarioChat = $("<span>").text(usuario.usuario);

            contenedorInfoAmigoSeleccionado.append(imgUsuarioChat);
            contenedorInfoAmigoSeleccionado.append(spanUsuarioChat);
            idUsuarioChat = usuario.id_usuario;
            limpiarChat();
            $("#inputEnvioMensaje").prop("disabled", false);
            $("#flechaEnvioMensaje").prop("disabled", false);
            verificarNuevosMensajes();
            cargarMensajesAnteriores();

            // Llamar a la función verificarNuevosMensajes cada 5 segundos
            setInterval(verificarNuevosMensajes, 5000);
        });
    }

    // Función para obtener la lista de amigos actualizada
    function obtenerListaAmigos() {
        $.ajax({
            url: "ajax/listaDeAmigos.jsp",
            type: "POST",
            data: {idSesion: idSesion},
            success: function (response) {
                // Parsear la respuesta como JSON
                var nuevaListaAmigos = JSON.parse(response);

                // Comparar la nueva lista de amigos con la lista anterior
                nuevaListaAmigos.forEach(function (usuario) {
                    var amigoExistente = listaAmigos.find(function (amigo) {
                        return amigo.usuario === usuario.usuario;
                    });

                    if (!amigoExistente) {
                        // Agregar nuevo amigo a la lista
                        listaAmigos.push(usuario);

                        // Crear elementos de la lista de amigos y agregarlos a la página
                        agregarAmigo(usuario);
                    }
                });
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    // Llamar a la función obtenerListaAmigos al cargar la página
    obtenerListaAmigos();

    // Llamar a la función obtenerListaAmigos cada 5 segundos para verificar cambios
    setInterval(obtenerListaAmigos, 5000);


    // Evento al buscador de amigos
    $("#buscar").on("keyup", function () {
        var textoBusqueda = $(this).val().toLowerCase();

        // Filtrar la lista de usuarios según el texto de búsqueda
        $.each(listaAmigos, function (index, amigo) {
            var nombreUsuario = amigo.usuario;
            var botonDelUsuario = document.getElementById(amigo.usuario);

            // Verificar si el usuario coincide con el texto de búsqueda y es favorito (si mostrarFavoritos está activo)
            if ((!mostrarFavoritos || amigo.favorito) && nombreUsuario.includes(textoBusqueda)) {
                $(botonDelUsuario).show(); // Mostrar el usuario si cumple con los criterios
            } else {
                $(botonDelUsuario).hide(); // Ocultar el usuario si no cumple con los criterios
            }
        });
    });


    // Cuando se envía el formulario del chat
    $('#chat-form').submit(function (event) {
        // Prevenir que se recargue la página al enviar el formulario
        event.preventDefault();

        // Obtener el mensaje del campo de entrada
        var message = $('input[name="chat-input"]').val();

        // Enviar una petición Ajax al servidor para guardar el mensaje en la base de datos
        var id_usuario_envio = idUsuarioChat; // Obtener el valor del campo de entrada

        $.ajax({
            url: 'ajax/guardar_mensaje.jsp',
            method: 'POST',
            data: {
                message: message,
                id_usuario_envio_mensaje: id_usuario_envio // Enviar el valor del campo como parámetro en la solicitud
            },
            success: function () {
                // Si la petición se completó correctamente, actualizar la vista del chat
                if (message !== "") {
                    $('#chat-body').append(
                            $('<div>').addClass('bocadillo bocadillo-izquierda').append(
                            $('<p>').addClass('card-text textoIzquierda').text(message)
                            )
                            );
                    $('input[name="chat-input"]').attr("placeholder", "Escribe un mensaje...");
                } else {
                    $('input[name="chat-input"]').attr("placeholder", "Debe rellenar el campo");
                }




                // Limpiar el campo de entrada
                $('input[name="chat-input"]').val('');

                // Establecer la posición del scroll en la parte inferior del chat-body después de un breve retraso
                setTimeout(function () {
                    $('#chat-body').scrollTop($('#chat-body')[0].scrollHeight);
                }, 100);
            }
        });


    });

    // Evento click que filtra a los amigos favoritos
    $("#filtraFavoritos").on("click", function () {
        var textoBusqueda = $("#buscar").val().toLowerCase();

        // Alternar el estado antes de filtrar la lista
        mostrarFavoritos = !mostrarFavoritos;

        // Filtrar la lista de usuarios según el texto de búsqueda y si son favoritos
        $.each(listaAmigos, function (index, amigo) {
            var nombreUsuario = amigo.usuario;
            var botonDelUsuario = document.getElementById(amigo.usuario);

            // Verificar si se deben mostrar solo los favoritos o todos los usuarios
            if (mostrarFavoritos) {
                // Verificar si el usuario es favorito y coincide con el texto de búsqueda
                if (amigo.favorito && nombreUsuario.includes(textoBusqueda)) {
                    $(botonDelUsuario).show(); // Mostrar el usuario si cumple con los criterios
                } else {
                    $(botonDelUsuario).hide(); // Ocultar el usuario si no cumple con los criterios
                }
            } else {
                // Verificar si el usuario coincide con el texto de búsqueda
                if (nombreUsuario.includes(textoBusqueda)) {
                    $(botonDelUsuario).show(); // Mostrar el usuario si cumple con los criterios
                } else {
                    $(botonDelUsuario).hide(); // Ocultar el usuario si no cumple con los criterios
                }
            }
        });

        // Cambiar el color del botón de la estrella
        $(this).toggleClass("estrellaActiva");
    });



});



// Configurar una función para recibir actualizaciones del servidor
function verificarNuevosMensajes() {
    $.ajax({
        url: 'ajax/recibir_actualizaciones.jsp',
        method: 'POST',
        data: {
            id_usuario_envio_mensaje: idUsuarioChat
        },
        success: function (data) {
            // Agregar nuevos mensajes al chat-body
            $('#chat-body').append(data);

        }
    });
}

// Función para limpiar el chat
function limpiarChat() {
    $("#chat-body").empty();
}

// Función para cargar los mensajes anteriores del chat
function cargarMensajesAnteriores() {
    $.ajax({
        url: 'ajax/cargar_mensajes_anteriores.jsp',
        method: 'POST',
        data: {
            id_usuario_envio_mensaje: idUsuarioChat
        },
        success: function (data) {
            // Actualizar la vista del chat con todos los mensajes anteriores
            $('#chat-body').append(data);

            // Establecer la posición del scroll en la parte inferior del chat-body
            $('#chat-body').scrollTop($('#chat-body')[0].scrollHeight);

        }
    });
}

// Función que abre las opciones para moverse por las páginas para el usuario
function abrirOpciones() {
    var listaDesplegable = document.getElementById("listaDesplegable");
    var estaMostrando = listaDesplegable.classList.contains("mostrar");

    if (estaMostrando) {
        listaDesplegable.classList.remove("mostrar");
    } else {
        listaDesplegable.classList.add("mostrar");
    }
}

// Función que abre la ventana modal para agregar amigos
function abrirAgregarAmigos() {
    var modal = document.getElementById("modalAgregarAmigo");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "block";
    modal.style.display = "block";
}

// Función que cierra la ventana modal para agregar amigos
function cerrarAgregarAmigos() {
    var modal = document.getElementById("modalAgregarAmigo");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "none";
    modal.style.display = "none";

    $('#nombre-amigo').val('');
    $('.errorAgregarAmigos').text('').css("display", "none");
    $('#resultados-amigos').scrollTop(0);
}

// Función que abre la ventana modal para eliminar amigos
function abrirEliminarAmigos() {
    var modal = document.getElementById("modalEliminarAmigo");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "block";
    modal.style.display = "block";
}

// Función que abre la ventana modal de eliminar amigos
function cerrarEliminarAmigos() {
    var modal = document.getElementById("modalEliminarAmigo");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "none";
    modal.style.display = "none";

    $('#nombre-amigo-eliminar').val('');
    $('.errorEliminarAmigos').text('').css("display", "none");
    $('#resultados-amigos-eliminar').scrollTop(0);
}

// Función que abre la ventana modal de las notificaciones
function abrirNotificaciones() {
    var modal = document.getElementById("modalNotificaciones");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "block";
    modal.style.display = "block";
}

// Función que cierra la ventana modal de las notificaciones
function cerrarNotificaciones() {
    var modal = document.getElementById("modalNotificaciones");
    var modoConcentracion = document.getElementById("modoConcentracion");
    modoConcentracion.style.display = "none";
    modal.style.display = "none";

    // Cerrar si estaba abierto los usuarios con notificacion
    var contenedor = document.getElementById("modal-content-notificaciones");
    // Verificar si el contenedor ya existe
    var aceptarSolicitudes = document.getElementsByClassName("aceptarSolicitudes")[0];
    if (!aceptarSolicitudes) {
        // Si no existe, crear el contenedor
        aceptarSolicitudes = document.createElement("div");
        aceptarSolicitudes.classList.add("aceptarSolicitudes");
        contenedor.appendChild(aceptarSolicitudes);
    } else {
        // Si existe, eliminar los hijos existentes
        while (aceptarSolicitudes.firstChild) {
            aceptarSolicitudes.removeChild(aceptarSolicitudes.firstChild);
        }
    }

}

// Función que hace una llamada ajax al servidor para agregar amigos
function agregarAmigoAccion() {
    var usuarioInput = $("#nombre-amigo").val();
    var usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    // Primero hay que comprobar que el usuario no coincida con el mismo
    if (usuarioInput === usuarioNombre) {
        //Si coinicide devolver mensaje de error al usuario
        $('.errorAgregarAmigos').text('No puedes agregarte').css("display", "block");
        return;
    }

    $.ajax({
        url: "ajax/agregarAmigos.jsp",
        type: "POST",
        data: {usuarioInput: usuarioInput, idUsuarioSesion: idUsuarioSesion},
        success: function (response) {
            console.log(response);
            // Si ya son amigos avisar al usuario
            if (response.trim() === "sonAmigos") {
                $('.errorAgregarAmigos').text('Ya son amigos').css("display", "block");
                // Si el usuario no existe avisar al usuario
            } else if (response.trim() === "noExiste") {
                $('.errorAgregarAmigos').text('No existe').css("display", "block");
            } else if (response.trim() === "yaExisteSolicitud") {
                $('.errorAgregarAmigos').text('Ya tiene una solicitud').css("display", "block");
            } else {
                cerrarAgregarAmigos();
                abrirModalConfirmarSolicitudAmistadEnviada();
            }
        },
        error: function (xhr, status, error) {

            console.log(error);
        }
    });
}

// Función que comprueba si existen las notificaciones
function compruebaNotificacion() {
    var usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/notificaciones.jsp",
        type: "POST",
        data: {usuarioNombre: usuarioNombre, idUsuarioSesion: idUsuarioSesion},
        success: function (response) {
            console.log(response);
            // Si ya son amigos avisar al usuario
            if (response.trim() === "solicitudPendiente") {
                abrirNotificaciones();
            } else if (response.trim() === "sinSolicitudPendiente") {
                cerrarNotificaciones();
                abrirModalSinNotificacion();
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función que hace una llamada ajax al servidor para eliminar un amigo
function eliminarAmigoAccion() {
    var usuarioInput = $("#nombre-amigo-eliminar").val();
    var usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    // Primero hay que comprobar que el usuario no coincida con el mismo
    if (usuarioInput === usuarioNombre) {
        //Si coinicide devolver mensaje de error al usuario
        $('.errorEliminarAmigos').text('No puedes borrarte').css("display", "block");
        return;
    }

    $.ajax({
        url: "ajax/eliminarAmigos.jsp",
        type: "POST",
        data: {usuarioInput: usuarioInput, idUsuarioSesion: idUsuarioSesion},
        success: function (response) {
            console.log(response);
            // Si ya son amigos avisar al usuario
            if (response.trim() === "noRegistradoComoAmigo") {
                $('.errorEliminarAmigos').text('Debe elegir un amigo').css("display", "block");
                // Si el usuario no existe avisar al usuario
            } else if (response.trim() === "eliminadoConExito") {
                cerrarEliminarAmigos();
                abrirModalConfirmarAmigoEliminado();
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función que abre el modal que confirma que se ha enviado la solicitud de agregar usuario
function abrirModalConfirmarSolicitudAmistadEnviada() {
    var modal = document.getElementById("modalConfirmaSolicitudAmigo");
    modal.style.display = "block";

    //Tiempo de la animación
    setTimeout(function () {
        modal.style.animation = "cerrarModalComentarioEliminadoConfirmacion 1s forwards";
    }, 2000);

    //Tiempo para quitar el modal
    setTimeout(function () {
        modal.style.display = "none";
        modal.style.animation = "";
    }, 3000);
}

// Función que abre el modal que confirma que se ha eliminado el amigo correctamente
function abrirModalConfirmarAmigoEliminado() {
    var modal = document.getElementById("modalConfirmaAmigoEliminado");
    modal.style.display = "block";

    //Tiempo de la animación
    setTimeout(function () {
        modal.style.animation = "cerrarModalComentarioEliminadoConfirmacion 1s forwards";
    }, 2000);

    //Tiempo para quitar el modal
    setTimeout(function () {
        modal.style.display = "none";
        modal.style.animation = "";
    }, 3000);
}

// Función que abre el modal que confirma que no hay notificaciones
function abrirModalSinNotificacion() {
    var modal = document.getElementById("modalNoHayNotificaciones");
    modal.style.display = "block";

    //Tiempo de la animación
    setTimeout(function () {
        modal.style.animation = "cerrarModalComentarioEliminadoConfirmacion 1s forwards";
    }, 2000);

    //Tiempo para quitar el modal
    setTimeout(function () {
        modal.style.display = "none";
        modal.style.animation = "";
    }, 3000);
}

// Función que devuelve la lista de los amigos solicitantes de amistad
function abrirSolicitudesNotificacion() {
    var usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/listaSolicitudes.jsp",
        type: "POST",
        data: {usuarioNombre: usuarioNombre, idUsuarioSesion: idUsuarioSesion, solicitud: 'solicitud'},
        success: function (response) {

            var contenedor = document.getElementById("modal-content-notificaciones");

            // Verificar si el contenedor ya existe
            var aceptarSolicitudes = document.getElementsByClassName("aceptarSolicitudes")[0];
            if (!aceptarSolicitudes) {
                // Si no existe, crear el contenedor
                aceptarSolicitudes = document.createElement("div");
                aceptarSolicitudes.classList.add("aceptarSolicitudes");
                contenedor.appendChild(aceptarSolicitudes);
            } else {
                // Si existe, eliminar los hijos existentes
                while (aceptarSolicitudes.firstChild) {
                    aceptarSolicitudes.removeChild(aceptarSolicitudes.firstChild);
                }
            }


            // Parsear la respuesta como JSON
            var usuarios = JSON.parse(response);

            usuarios.forEach(function (usuario) {
                aceptarSolicitudes.id = "usuario-" + usuario.usuario;
                var contenedorInfoSolicitante = document.createElement("div");
                contenedorInfoSolicitante.classList.add("contenedorInfoSolicitante");

                var infoSolicitanteIzquierda = document.createElement("div");
                infoSolicitanteIzquierda.classList.add("infoSolicitanteIzquierda");

                var imagen = document.createElement("img");
                if (usuario.foto) {
                    imagen.src = usuario.foto;
                } else {
                    imagen.src = "img/usuario.png";
                }
                imagen.classList.add("resaltadoImagen");
                infoSolicitanteIzquierda.appendChild(imagen);


                var nombreUsuario = document.createElement("span");
                nombreUsuario.textContent = usuario.usuario;
                infoSolicitanteIzquierda.appendChild(nombreUsuario);

                var infoSolicitanteDerecha = document.createElement("div");
                infoSolicitanteDerecha.classList.add("infoSolicitanteDerecha");

                var botonConfirmarSolicitante = document.createElement("button");
                botonConfirmarSolicitante.title = "Aceptar";
                botonConfirmarSolicitante.classList.add("botonConfirmarSolicitante");
                botonConfirmarSolicitante.onclick = function () {
                    aceptarSolicitudAmistad(usuario.id_usuario, contenedorInfoSolicitante);
                };
                var iconoConfirmarSolicitante = document.createElement("i");
                iconoConfirmarSolicitante.classList.add("bi", "bi-check-lg");
                botonConfirmarSolicitante.appendChild(iconoConfirmarSolicitante);
                infoSolicitanteDerecha.appendChild(botonConfirmarSolicitante);

                var botonDenegarSolicitante = document.createElement("button");
                botonDenegarSolicitante.title = "Rechazar";
                botonDenegarSolicitante.classList.add("botonDenegarSolicitante");
                botonDenegarSolicitante.onclick = function () {
                    denegarSolicitudAmistad(usuario.id_usuario, contenedorInfoSolicitante);
                };
                var iconoDenegarSolicitante = document.createElement("i");
                iconoDenegarSolicitante.classList.add("bi", "bi-x-lg");
                botonDenegarSolicitante.appendChild(iconoDenegarSolicitante);
                infoSolicitanteDerecha.appendChild(botonDenegarSolicitante);


                contenedorInfoSolicitante.appendChild(infoSolicitanteIzquierda);
                contenedorInfoSolicitante.appendChild(infoSolicitanteDerecha);
                aceptarSolicitudes.appendChild(contenedorInfoSolicitante);
            });

            contenedor.appendChild(aceptarSolicitudes);

        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función que devuelve la lista de los amigos solicitantes de amistad
function abrirAceptadasNotificacion() {
    var usuarioNombre = $('#nombreUsuarioSesion').data('usuario-nombre');
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/listaAgregados.jsp",
        type: "POST",
        data: {usuarioNombre: usuarioNombre, idUsuarioSesion: idUsuarioSesion, solicitud: 'recienAceptada'},
        success: function (response) {

            var contenedor = document.getElementById("modal-content-notificaciones");

            // Verificar si el contenedor ya existe
            var aceptarSolicitudes = document.getElementsByClassName("aceptarSolicitudes")[0];
            if (!aceptarSolicitudes) {
                // Si no existe, crear el contenedor
                aceptarSolicitudes = document.createElement("div");
                aceptarSolicitudes.classList.add("aceptarSolicitudes");
                contenedor.appendChild(aceptarSolicitudes);
            } else {
                // Si existe, eliminar los hijos existentes
                while (aceptarSolicitudes.firstChild) {
                    aceptarSolicitudes.removeChild(aceptarSolicitudes.firstChild);
                }
            }


            // Parsear la respuesta como JSON
            var usuarios = JSON.parse(response);

            usuarios.forEach(function (usuario) {
                aceptarSolicitudes.id = "usuario-" + usuario.usuario;
                var contenedorInfoSolicitante = document.createElement("div");
                contenedorInfoSolicitante.classList.add("contenedorInfoSolicitante");

                var infoSolicitanteIzquierda = document.createElement("div");
                infoSolicitanteIzquierda.classList.add("infoSolicitanteIzquierda");

                var imagen = document.createElement("img");
                if (usuario.foto) {
                    imagen.src = usuario.foto;
                } else {
                    imagen.src = "img/usuario.png";
                }
                imagen.classList.add("resaltadoImagen");
                infoSolicitanteIzquierda.appendChild(imagen);


                var nombreUsuario = document.createElement("span");
                nombreUsuario.textContent = usuario.usuario;
                infoSolicitanteIzquierda.appendChild(nombreUsuario);

                var infoSolicitanteDerecha = document.createElement("div");
                infoSolicitanteDerecha.classList.add("infoSolicitanteDerechaAceptadas");

                var botonConfirmarSolicitante = document.createElement("button");
                botonConfirmarSolicitante.title = "Quitar";
                botonConfirmarSolicitante.classList.add("botonConfirmarSolicitante");
                botonConfirmarSolicitante.onclick = function () {
                    usuarioAgregadoConfirmado(usuario.id_usuario, contenedorInfoSolicitante);
                };
                var iconoConfirmarSolicitante = document.createElement("i");
                iconoConfirmarSolicitante.classList.add("bi", "bi-check");
                botonConfirmarSolicitante.appendChild(iconoConfirmarSolicitante);
                infoSolicitanteDerecha.appendChild(botonConfirmarSolicitante);

                contenedorInfoSolicitante.appendChild(infoSolicitanteIzquierda);
                contenedorInfoSolicitante.appendChild(infoSolicitanteDerecha);
                aceptarSolicitudes.appendChild(contenedorInfoSolicitante);
            });

            contenedor.appendChild(aceptarSolicitudes);

        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función para aceptar la solicitud de amistad
function aceptarSolicitudAmistad(usuarioId, div) {
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/aceptarSolicitudAmistad.jsp",
        type: "POST",
        data: {idUsuarioSesion: idUsuarioSesion, usuario: usuarioId},
        success: function (response) {
            if (response.trim() === "correcto") {
                compruebaNotificacion();
                div.style.display = "none";
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función para aceptar la solicitud de amistad
function usuarioAgregadoConfirmado(usuarioId, div) {
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/usuarioAgregadoConfirmado.jsp",
        type: "POST",
        data: {idUsuarioSesion: idUsuarioSesion, usuario: usuarioId},
        success: function (response) {
            if (response.trim() === "correcto") {
                compruebaNotificacion();
                div.style.display = "none";
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

// Función para rechazar la solicitud de amistad
function denegarSolicitudAmistad(usuarioId, div) {
    var idUsuarioSesion = $('#idUsuarioSesion').data('usuario-id');

    $.ajax({
        url: "ajax/rechazarSolicitudAmistad.jsp",
        type: "POST",
        data: {idUsuarioSesion: idUsuarioSesion, usuario: usuarioId},
        success: function (response) {
            if (response.trim() === "correcto") {
                compruebaNotificacion();
                div.style.display = "none";
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}