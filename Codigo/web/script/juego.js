// Variable para comprobar si ya existe el comentario para poder editarlo
var booleanExisteComentario = false;

// Cuando se cargue el documento
$(document).ready(function () {
    // Captura el evento de escritura en el campo de búsqueda
    $('#buscar').on('input', function (event) {
        var busqueda = $(this).val().trim();

        // Verifica si se ha ingresado alguna palabra de búsqueda
        if (busqueda === '') {
            // Si no se ha ingresado ninguna palabra, oculta el contenedor de resultados
            $('#resultadosBusqueda').hide();
        } else {
            // Realiza la consulta a la API de RAWG utilizando AJAX
            $.ajax({
                url: 'https://api.rawg.io/api/games',
                data: {
                    search: busqueda,
                    key: '689ff6adde4e4c8aa9d9f2b52dd35c79'
                },
                success: function (response) {
                    // Limpia los resultados anteriores
                    $('#resultadosBusqueda').empty();

                    if (response.results.length > 0) {
                        // Si hay resultados, muestra el contenedor de resultados y procesa los juegos
                        $('#resultadosBusqueda').show();

                        // Itera sobre los resultados y muestra la imagen y el nombre de cada juego
                        $.each(response.results.slice(0, 8), function (index, juego) {
                            var id = juego.id; // Obtén el ID del juego
                            var imagen = juego.background_image;
                            var nombre = juego.name;

                            // Crea un formulario para el juego
                            var formularioJuego = $('<form>').addClass('formularioJuego').attr('action', 'ControladorJuegos').attr('method', 'GET');
                            ;
                            formularioJuego.append($('<input>').attr('type', 'hidden').attr('name', 'pkJuego').val(id)); // Input oculto con el ID del juego
                            formularioJuego.append($('<img>').attr('src', imagen));
                            formularioJuego.append($('<p>').text(nombre));

                            // Adjunta un controlador de eventos al formulario
                            formularioJuego.on('click', function (event) {
                                event.preventDefault(); // Evita que la página se recargue

                                // Acción que deseas realizar al hacer clic en el formulario
                                formularioJuego[0].submit(); // Envía el formulario
                            });

                            // Agrega el formulario al contenedor de resultados
                            $('#resultadosBusqueda').append(formularioJuego);
                        });
                    } else {
                        // Si no hay resultados, oculta el contenedor de resultados
                        $('#resultadosBusqueda').hide();
                    }
                }


            });
        }
    });

    // Captura el evento de pulsación de tecla en el campo de búsqueda
    $('#buscar').on('keydown', function (event) {
        var keyCode = event.keyCode || event.which;

        // Verifica si se ha presionado la tecla "Enter"
        if (keyCode === 13) {
            event.preventDefault();
            return false;
        }
    });

    //Para cambiar el color de los radio de las valoraciones
    const valoracionLabels = document.querySelectorAll('.valoracion-label');

    valoracionLabels.forEach(label => {
        const radioInput = label.querySelector('input[type="radio"]');

        radioInput.addEventListener('change', () => {
            if (radioInput.checked) {
                valoracionLabels.forEach(label => {
                    label.classList.remove('selected');
                });
                label.classList.add('selected');
            }
        });
    });

    // Función para validar el formulario e insertarlo
    function validar(e) {
        // Evitar la recarga de la página al enviar el formulario
        e.preventDefault();

        if (validarRadio() && validarComentario()) {
            // Obtener los datos del formulario
            var comentario = $('#textareaValoracion').val();
            var valoracion = $('input[name="valoracion"]:checked').val();
            var idUsuarioComentario = $('#idUsuarioComentario').val();
            var idJuegoComentario = $('#idJuegoComentario').val();

            // Realizar la solicitud AJAX al servidor
            $.ajax({
                url: 'ajax/aniadirComentario.jsp',
                method: 'POST',
                data: {
                    comentario: comentario,
                    valoracion: valoracion,
                    idUsuarioComentario: idUsuarioComentario,
                    idJuegoComentario: idJuegoComentario
                },
                success: function (response) {
                    // Restablecer el formulario
                    $('#textareaValoracion').val('');
                    $('input[name="valoracion"]').prop('checked', false);
                    // Si existe el comentario entonces avisa al usuario de que se ha editado con éxito
                    if (booleanExisteComentario) {
                        abrirModalEditarComentarioConfirmacion();
                    } else {
                        abrirModalAniadirComentarioConfirmacion();
                    }
                    cerrarModal();

                    // Restablecer el color de las valoraciones
                    valoracionLabels.forEach(label => {
                        label.classList.remove('selected');
                    });

                    // Cargar el comentario recién añadido
                    var opcionPorDefecto = document.querySelector(".listaOpciones li:nth-child(2)");
                    seleccionarOpcion(opcionPorDefecto);
                    // Después de agregar el comentario se cambia el evento
                    var contenedorComentario = document.getElementById("contenedorBotonFormulario");
                    contenedorComentario.setAttribute("onclick", "abrirExisteComentario()");


                },
                error: function (xhr, status, error) {
                    // Manejar errores de la solicitud AJAX
                    console.log(error);
                }
            });
        }

        return false;
    }

    // Asigna la función validar al evento click del botón enviar
    $('#enviarComentario').on('click', validar);

    // Cargar las valoraciones por defecto
    var opcionPorDefecto = document.querySelector(".listaOpciones li:first-child");
    seleccionarOpcion(opcionPorDefecto);

});

// Funcion para abrir la ventana modal de comentarios
function abrirModal() {
    // Mostrar la ventana modal utilizando jQuery
    $("#miModal").css("display", "block");
}

// Funcion para cerrar la ventana modal
function cerrarModal() {
    var modal = document.getElementById("miModal");
    modal.style.display = "none";

    // Limpiar campos
    let textarea = document.getElementById("textareaValoracion");
    textarea.value = "";

    // Deseleccionar opción de valoración existente
    let valoracionExistente = document.querySelector(`input[name="valoracion"]:checked`);
    if (valoracionExistente) {
        valoracionExistente.checked = false;
        valoracionExistente.parentElement.classList.remove('selected');
    }
    // boolean que comprueba si se va a editar el comentario
    booleanExisteComentario = false;
}

// Función que abre la ventana modal que informa que no ha iniciado sesión
function abrirModalFallo() {
    var modal = document.getElementById("modal");
    modal.style.display = "block";
}

// Función que abre la ventana modal que avisa que ya hay un comentario
function abrirExisteComentario() {
    var modal = document.getElementById("modalExisteComentario");
    modal.style.display = "block";
}

// Función que cierra la ventana modal que avisa que hay un comentario
function cerrarExisteComentario() {
    var modal = document.getElementById("modalExisteComentario");
    modal.style.display = "none";
}

// Función que cierra la ventana modal que informa que no ha iniciado sesión
function cerrarModalFallo() {
    var modal = document.getElementById("modal");
    modal.style.display = "none";
}

// Función para validar que ha escrito un comentario
function validarComentario() {
    let elemento = $("#textareaValoracion");
    let elemento2 = $("#comentarioPalabra");
    elemento2.css("color", "hsla(0,0%,100%,.4)");

    if (elemento.val() === "") {
        elemento.focus();
        elemento2.css("color", "red");
        return false;
    }

    return true;
}

// Función que valida que los radio estén pulsados
function validarRadio() {
    // Obtener todos los radios de valoración
    let radiosValoracion = $('input[name="valoracion"]');

    // Verificar si al menos uno de los radios está seleccionado
    let radioSeleccionado = radiosValoracion.is(':checked');

    // Elemento para el error
    let elementoError = $("#valoracionPalabra");
    elementoError.css("color", "hsla(0,0%,100%,.4)");

    // Si no hay ningún radio seleccionado, mostrar el error
    if (!radioSeleccionado) {
        elementoError.css("color", "red");
        return false;
    }

    return true;
}

// Función que abre la lista de ordenar los comentarios
function desplegableComentarios() {
    var listaDesplegable = document.getElementById("listaDesplegable");
    var estaMostrando = listaDesplegable.classList.contains("mostrar");

    if (estaMostrando) {
        listaDesplegable.classList.remove("mostrar");
    } else {
        listaDesplegable.classList.add("mostrar");
    }
}

// Limite de mensajes que se muestran por primera vez
let mensajesMostrados = 6;

// Primera opción seleccionada para comprobar si se selecciona otra
let opcSeleccionada = "";

// Variable para obtener el id de los comentarios
var idValoracionModal = "";

//Variables para el comentario y la valoracion para editar
var comentarioEditar = "";
var valoracionEditar = "";

// Función que muestra la opción seleccionada
function seleccionarOpcion(opcion) {

    // Variable para obtener el id del usuario de la sesión
    var contenedorUsuarioSesion = document.getElementById('contenedorComentarioIndividual');
    var idUsuarioSesion = contenedorUsuarioSesion.getAttribute('data-id-usuario');

    var tituloSeleccionado = document.querySelector(".tituloSeleccionado");
    tituloSeleccionado.textContent = opcion.textContent;

    var listaDesplegable = document.getElementById("listaDesplegable");
    listaDesplegable.classList.remove("mostrar");

    // Comprobar si se ha seleccionado otra opción
    if (opcSeleccionada === "") {
        opcSeleccionada = opcion;
    }

    if (opcSeleccionada !== "") {
        if (opcSeleccionada !== opcion) {
            mensajesMostrados = 6;
            opcSeleccionada = opcion;
        }
    }

    // Obtener el ID del juego
    const idJuego = obtenerIdJuego();

    // Verificar si se ha presionado el botón "Cargar más"
    if (opcion.id === 'botonComentario') {
        mensajesMostrados += 6;
    }

    // Cargar las valoraciones utilizando AJAX
    const mensajesContainer = document.getElementById('contenedorComentarioIndividual');
    const xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const mensajes = JSON.parse(xhr.responseText);

            // Ordenar los mensajes según la opción seleccionada
            if (opcion.textContent === 'Más recientes') {
                mensajes.sort((a, b) => new Date(b.fecha_valoracion) - new Date(a.fecha_valoracion));
            } else if (opcion.textContent === 'Más antiguos') {
                mensajes.sort((a, b) => new Date(a.fecha_valoracion) - new Date(b.fecha_valoracion));
            } else if (opcion.textContent === 'Más gustados') {
                mensajes.sort((a, b) => b.likes - a.likes);
            }

            mensajesContainer.innerHTML = "";

            for (let i = 0; i < mensajesMostrados && i < mensajes.length; i++) {
                const mensaje = mensajes[i];

                // Crear elementos HTML para mostrar el mensaje
                const seccionComentario = document.createElement('div');
                seccionComentario.classList.add('seccionesComentarioIndividual');

                // Header del contendedor
                const headerComentario = document.createElement('div');
                headerComentario.classList.add('headerComentarioIndividual');
                const spanRecomendado = document.createElement('span');
                spanRecomendado.textContent = mensaje.opinion;
                const iconoValoracion = document.createElement('i');
                if (mensaje.opinion === "Excelente") {
                    iconoValoracion.classList.add('bi', 'bi-heart-fill');
                } else if (mensaje.opinion === "Bueno") {
                    iconoValoracion.classList.add('bi', 'bi-fire');
                } else if (mensaje.opinion === "Aceptable") {
                    iconoValoracion.classList.add('bi', 'bi-emoji-sunglasses-fill');
                } else if (mensaje.opinion === "Pasar") {
                    iconoValoracion.classList.add('bi', 'bi-bandaid-fill');
                }

                // Agrupar comentario en un div
                const divSecundarioHeader = document.createElement("div");
                divSecundarioHeader.appendChild(spanRecomendado);
                divSecundarioHeader.appendChild(iconoValoracion);

                headerComentario.appendChild(divSecundarioHeader);

                // Añadir boton que tiene la lista de opciones para el comentario
                if (mensaje.id_usuario === parseInt(idUsuarioSesion)) {
                    const botonOpciones = document.createElement('button');
                    botonOpciones.id = "botonOpciones";
                    botonOpciones.classList.add('bi', 'bi-three-dots');
                    botonOpciones.onclick = function () {
                        desplegableOpcionesComentarios();
                    };
                    headerComentario.appendChild(botonOpciones);

                    // Lista de las opciones
                    const listaOpciones = document.createElement('ul');
                    listaOpciones.classList.add('listaOpcionesComentario');
                    listaOpciones.id = "listaOpcionesComentario";

                    const editarItem = document.createElement('li');
                    editarItem.textContent = "Editar";
                    editarItem.onclick = function () {
                        opcionSeleccionadaComentarioUsuario(this);
                    };
                    listaOpciones.appendChild(editarItem);

                    const borrarItem = document.createElement('li');
                    borrarItem.textContent = "Borrar";
                    borrarItem.onclick = function () {
                        opcionSeleccionadaComentarioUsuario(this);
                    };
                    listaOpciones.appendChild(borrarItem);
                    headerComentario.appendChild(listaOpciones);

                    // Asignar a la varible global el id del comentario
                    idValoracionModal = mensaje.id_valoracion;

                    // Asignar a las variables de editar el contenido
                    comentarioEditar = mensaje.comentario;
                    valoracionEditar = mensaje.opinion;
                }

                // Body del contenedor
                const bodyComentario = document.createElement('div');
                bodyComentario.classList.add('bodyComentarioIndividual');
                const mensajeTexto = document.createElement('p');
                mensajeTexto.textContent = mensaje.comentario;
                bodyComentario.appendChild(mensajeTexto);

                //Footer del contenedor
                const footerComentario = document.createElement('div');
                footerComentario.classList.add('footerComentarioIndividual');
                const contenedorImg = document.createElement('div');
                contenedorImg.classList.add('contenedorImg');
                const imagenUsuario = document.createElement('img');
                if (mensaje.imagenUsuario === '' || mensaje.imagenUsuario == null) {
                    imagenUsuario.setAttribute('src', 'img/usuario.png');
                } else {
                    imagenUsuario.setAttribute('src', mensaje.imagenUsuario);
                }

                imagenUsuario.setAttribute('alt', 'img');
                const contenedorInfoUsuario = document.createElement('div');
                contenedorInfoUsuario.classList.add('contenedorInfoUsuario');
                const spanNombre = document.createElement('span');
                spanNombre.textContent = mensaje.nombreUsuario;
                const spanFechaComentario = document.createElement('span');
                spanFechaComentario.classList.add('fechaComentario');
                spanFechaComentario.textContent = mensaje.fecha_valoracion;
                contenedorInfoUsuario.appendChild(spanNombre);
                contenedorInfoUsuario.appendChild(spanFechaComentario);
                contenedorImg.appendChild(imagenUsuario);
                contenedorImg.appendChild(contenedorInfoUsuario);

                //Pulgares
                const pulgares = document.createElement('div');
                pulgares.classList.add('pulgares');

                // Pulgar arriba botón
                const botonPulgarArriba = document.createElement('button');
                // Agregar evento para añadir o eliminar me gustas

                // Para obtener el id del usuario
                const contenedorComentario = document.getElementById('contenedorComentarioIndividual');
                const idUsuario = contenedorComentario.getAttribute('data-id-usuario');

                attPulgarArriba(botonPulgarArriba);
                botonPulgarArriba.classList.add('btnSinEstilo');

                // Likes
                const spanLikesObtenidos = document.createElement('span');
                spanLikesObtenidos.classList.add('likesObtenidos');
                spanLikesObtenidos.setAttribute('id', 'contadorLikes_' + mensaje.id_valoracion);
                spanLikesObtenidos.textContent = mensaje.likes;

                // Pulgar arriba icono
                const iconoPulgarArriba = document.createElement('i');
                let identificadorPulgarArriba = "likeNumero" + i;
                iconoPulgarArriba.id = identificadorPulgarArriba;
                botonPulgarArriba.appendChild(spanLikesObtenidos);
                botonPulgarArriba.appendChild(iconoPulgarArriba);

                // Pulgar abajo botón
                const botonPulgarAbajo = document.createElement('button');
                botonPulgarAbajo.classList.add('btnSinEstilo');

                // Pulgar abajo icono
                const iconoPulgarAbajo = document.createElement('i');
                let identificadorPulgarAbajo = "dislikeNumero" + i;
                iconoPulgarAbajo.id = identificadorPulgarAbajo;

                // Si existe usuario en la sesión se permite añadir likes

                if (parseInt(idUsuarioSesion) !== 0) {
                    botonPulgarArriba.addEventListener('click', () => {
                        compruebaLike(identificadorPulgarArriba, identificadorPulgarAbajo, mensaje.id_valoracion, idUsuario);
                    });
                    botonPulgarAbajo.addEventListener('click', () => {
                        compruebaDislike(identificadorPulgarAbajo, identificadorPulgarArriba, mensaje.id_valoracion, idUsuario);
                    });
                }


                // Añadir iconos correspondientes al usuario de la sesión
                if (mensaje.opinionSesion === "like") {
                    iconoPulgarArriba.classList.add('bi', 'bi-hand-thumbs-up-fill', 'pulgarArriba');
                    iconoPulgarAbajo.classList.add('bi', 'bi-hand-thumbs-down', 'pulgarAbajo');
                } else if (mensaje.opinionSesion === "dislike") {
                    iconoPulgarArriba.classList.add('bi', 'bi-hand-thumbs-up', 'pulgarArriba');
                    iconoPulgarAbajo.classList.add('bi', 'bi-hand-thumbs-down-fill', 'pulgarAbajo');
                } else {
                    iconoPulgarArriba.classList.add('bi', 'bi-hand-thumbs-up', 'pulgarArriba');
                    iconoPulgarAbajo.classList.add('bi', 'bi-hand-thumbs-down', 'pulgarAbajo');
                }

                botonPulgarAbajo.appendChild(iconoPulgarAbajo);
                attPulgarAbajo(botonPulgarAbajo);

                // Insertar todo al DOM
                pulgares.appendChild(botonPulgarArriba);
                pulgares.appendChild(botonPulgarAbajo);


                footerComentario.appendChild(contenedorImg);
                footerComentario.appendChild(pulgares);

                seccionComentario.appendChild(headerComentario);
                seccionComentario.appendChild(bodyComentario);
                seccionComentario.appendChild(footerComentario);

                mensajesContainer.appendChild(seccionComentario);
            }

            // Verificar si se deben mostrar el botón "Cargar más"
            if (mensajesMostrados < mensajes.length) {
                const contenedorBotonVerMasComentario = document.getElementById('contenedorBotonVerMasComentario');

                // Verificar si el botón ya existe, si es así, eliminarlo antes de crear uno nuevo
                const botonCargarMasExistente = document.getElementById('botonCargarMas');
                if (botonCargarMasExistente) {
                    contenedorBotonVerMasComentario.removeChild(botonCargarMasExistente);
                }

                // Crear el botón "Cargar más"
                const botonCargarMas = document.createElement('button');
                botonCargarMas.textContent = 'Cargar más';
                botonCargarMas.classList.add('botonComentario');
                botonCargarMas.id = 'botonCargarMas';
                botonCargarMas.addEventListener('click', function () {
                    mensajesMostrados += 6; // Aumentar la cantidad de mensajes mostrados

                    // Volver a llamar a la función para cargar los mensajes con la nueva cantidad
                    seleccionarOpcion(opcion);

                });

                // Agregar el botón al contenedor
                contenedorBotonVerMasComentario.appendChild(botonCargarMas);
            } else {
                // Si no hay más mensajes para cargar, eliminar el botón existente si está presente
                const botonCargarMasExistente = document.getElementById('botonCargarMas');
                if (botonCargarMasExistente) {
                    botonCargarMasExistente.parentNode.removeChild(botonCargarMasExistente);
                }
            }

        } else if (xhr.readyState === 4 && xhr.status !== 200) {
            console.error('Error al cargar los mensajes:', xhr.status);
        }
    };

    xhr.open('GET', 'ajax/cargarValoraciones.jsp?idJuego=' + idJuego + '&idUsuarioSesion=' + idUsuarioSesion, true);
    xhr.send();
}

// Función para obtener el id del juego
function obtenerIdJuego() {
    const juegoElement = document.getElementById('idJuegoComentario2');
    const idJuego = juegoElement.dataset.juegoId;
    return idJuego;
}

// Función para los atributos del botón del pulgar arriba
function attPulgarArriba(botonPulgarArriba) {
    botonPulgarArriba.setAttribute('type', 'submit');
    botonPulgarArriba.setAttribute('name', 'pulgarArriba');
    botonPulgarArriba.setAttribute('value', 'like');
}

// Función para los atributos del botón del pulgar abajo
function attPulgarAbajo(botonPulgarAbajo) {
    botonPulgarAbajo.setAttribute('type', 'submit');
    botonPulgarAbajo.setAttribute('name', 'pulgarAbajo');
    botonPulgarAbajo.setAttribute('value', 'dislike');
}

//Función con ajax para agregar un like
function darLike(idValoracion, idUsuario) {
    // Envía una solicitud al servidor para agregar un me gusta (like) a la valoración con el ID correspondiente
    $.ajax({
        url: 'ajax/aniadirLike.jsp',
        method: 'POST',
        data: {
            idValoracion: idValoracion,
            idUsuario: idUsuario
        },
        success: function (response) {
            // Obtener el ID de la valoración desde la respuesta del servidor
            var idValoracion = response.idValoracion;

            // Obtener el contador de likes correspondiente al ID de la valoración
            var textoCuentaLikes = document.getElementById('contadorLikes_' + idValoracion);

            // Obtener el valor actual del contador de likes como número
            var likesActual = parseInt(textoCuentaLikes.textContent);

            // Sumar los likes actualizados al valor actual
            var totalLikes = likesActual + 1;

            // Actualizar el texto del contador de likes
            if (textoCuentaLikes) {
                textoCuentaLikes.textContent = totalLikes;
            }
        },
        error: function (error) {
            // Manejo de errores
            console.error('Error al agregar me gusta', error);
        }
    });
}

//Función con ajax para agregar un like
function darDislike(idValoracion, idUsuario) {
    // Envía una solicitud al servidor para agregar un me gusta (like) a la valoración con el ID correspondiente
    $.ajax({
        url: 'ajax/darDislike.jsp',
        method: 'POST',
        data: {
            idValoracion: idValoracion,
            idUsuario: idUsuario
        },
        success: function (response) {

        },
        error: function (error) {
            // Manejo de errores
            console.error('Error al agregar me gusta', error);
        }
    });
}

//Función con ajax para eliminar un like
function eliminaLike(idValoracion, idUsuario) {
    // Envía una solicitud al servidor para agregar un me gusta (like) a la valoración con el ID correspondiente
    $.ajax({
        url: 'ajax/eliminarLike.jsp',
        method: 'POST',
        data: {
            idValoracion: idValoracion,
            idUsuario: idUsuario
        },
        success: function (response) {
            // Obtener el ID de la valoración desde la respuesta del servidor
            var idValoracion = response.idValoracion;

            // Obtener el contador de likes correspondiente al ID de la valoración
            var textoCuentaLikes = document.getElementById('contadorLikes_' + idValoracion);

            // Obtener el valor actual del contador de likes como número
            var likesActual = parseInt(textoCuentaLikes.textContent);

            // Sumar los likes actualizados al valor actual
            var totalLikes = likesActual - 1;

            // Actualizar el texto del contador de likes
            if (textoCuentaLikes) {
                textoCuentaLikes.textContent = totalLikes;
            }
        },
        error: function (error) {
            // Manejo de errores
            console.error('Error al agregar me gusta', error);
        }
    });
}

//Función con ajax para eliminar un dislike
function eliminaDislike(idValoracion, idUsuario) {
    // Envía una solicitud al servidor para agregar un me gusta (like) a la valoración con el ID correspondiente
    $.ajax({
        url: 'ajax/eliminarDislike.jsp',
        method: 'POST',
        data: {
            idValoracion: idValoracion,
            idUsuario: idUsuario
        },
        success: function (response) {

        },
        error: function (error) {
            // Manejo de errores
            console.error('Error al agregar me gusta', error);
        }
    });
}

//Función que comprueba si hay like o no
function compruebaLike(identificadorPulgarArriba, identificadorPulgarAbajo, iv, iu) {
    let iPulgarArriba = document.getElementById(identificadorPulgarArriba);
    let iPulgarAbajo = document.getElementById(identificadorPulgarAbajo);


    if (iPulgarArriba.classList.contains('bi-hand-thumbs-up')) {
        darLike(iv, iu);
        iPulgarArriba.classList.remove('bi-hand-thumbs-up');
        iPulgarArriba.classList.add('bi-hand-thumbs-up-fill');
        iPulgarAbajo.classList.remove('bi-hand-thumbs-down-fill');
        iPulgarAbajo.classList.add('bi-hand-thumbs-down');
    } else {
        eliminaLike(iv, iu);
        iPulgarArriba.classList.remove('bi-hand-thumbs-up-fill');
        iPulgarArriba.classList.add('bi-hand-thumbs-up');
    }
}

//Función que comprueba si hay dislike o no
function compruebaDislike(identificadorPulgarAbajo, identificadorPulgarArriba, iv, iu) {
    let iPulgarAbajo = document.getElementById(identificadorPulgarAbajo);
    let iPulgarArriba = document.getElementById(identificadorPulgarArriba);

    if (iPulgarAbajo.classList.contains('bi-hand-thumbs-down')) {
        if (iPulgarArriba.classList.contains('bi-hand-thumbs-up-fill')) {
            eliminaLike(iv, iu);
        }
        darDislike(iv, iu);
        iPulgarAbajo.classList.remove('bi-hand-thumbs-down');
        iPulgarAbajo.classList.add('bi-hand-thumbs-down-fill');
        iPulgarArriba.classList.remove('bi-hand-thumbs-up-fill');
        iPulgarArriba.classList.add('bi-hand-thumbs-up');
    } else {
        eliminaDislike(iv, iu);
        iPulgarAbajo.classList.remove('bi-hand-thumbs-down-fill');
        iPulgarAbajo.classList.add('bi-hand-thumbs-down');
    }
}

// Función que abre la lista de las opciones del comentario
function desplegableOpcionesComentarios() {
    var listaDesplegable = document.getElementById("listaOpcionesComentario");
    var estaMostrando = listaDesplegable.classList.contains("mostrar");

    if (estaMostrando) {
        listaDesplegable.classList.remove("mostrar");
    } else {
        listaDesplegable.classList.add("mostrar");
    }
}

// Función para cerrar la ventana modal del borrar el comentario
function cerrarModalEliminarComentario() {
    var modal = document.getElementById("modalEliminarComentario");
    modal.style.display = "none";
}

// Función que abre la ventana modal que informa que no ha iniciado sesión
function abrirModalEliminarComentario() {
    // Cerrar también el primer desplegable de opciones
    var listaDesplegable = document.getElementById("listaOpcionesComentario");
    listaDesplegable.classList.remove("mostrar");
    var modal = document.getElementById("modalEliminarComentario");
    modal.style.display = "block";
}

// Función para la acción de la lista de la opción de los comentarios
function opcionSeleccionadaComentarioUsuario(opcion) {
    // Obtener la opción seleccionada
    const textoOpcion = opcion.textContent;

    if (textoOpcion === "Editar") {
        editarComentario();
    } else if (textoOpcion === "Borrar") {
        abrirModalEliminarComentario();
    }
}

// Función para eliminar el comentario
function accionEliminarComentario() {
    $.ajax({
        url: 'ajax/eliminarComentario.jsp',
        method: 'POST',
        data: {
            idValoracionModal: idValoracionModal
        },
        success: function (response) {
            //Cerrar ventana modal del borrar mensaje
            cerrarModalEliminarComentario();
            // Si todo es correcto recargar nuevamente los comentarios
            var opcionPorDefecto = document.querySelector(".listaOpciones li:first-child");
            seleccionarOpcion(opcionPorDefecto);
            //Mostrar modal de confirmacion de comentario eliminado
            abrirModalEliminarComentarioConfirmacion();
        },
        error: function (error) {
            // Manejo de errores
            console.error('Error al eliminar el comentario', error);
        }
    });
}

// Función que abre la ventana modal que confirma que se a borrado el comentario
function abrirModalEliminarComentarioConfirmacion() {
    var modal = document.getElementById("modalConfirmarEliminarComentario");
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

    // Después de agregar eliminar el comentario permitir que puede volver a agregarlo
    var contenedorComentario = document.getElementById("contenedorBotonFormulario");
    contenedorComentario.setAttribute("onclick", "abrirModal()");

}

// Función que abre la ventana modal que confirma que se a editado el comentario
function abrirModalEditarComentarioConfirmacion() {
    var modal = document.getElementById("modalConfirmarEditarComentario");
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

// Función que abre la ventana modal que confirma que se a añadido un comentario
function abrirModalAniadirComentarioConfirmacion() {
    var modal = document.getElementById("modalConfirmarAniadirComentario");
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

// Función para abrir la ventana modal del comentario para editar
function editarComentario() {
    //Añadir el texto que ya tenía el usuario añadido en el textarea
    let textarea = document.getElementById("textareaValoracion");
    textarea.value = comentarioEditar;

    //Añadir la valoración que ya tenia el usuario
    let valoracionExistente = document.querySelector(`input[name="valoracion"][value="${valoracionEditar}"]`);
    if (valoracionExistente) {
        valoracionExistente.checked = true;
        valoracionExistente.parentElement.classList.add('selected');
    }
    booleanExisteComentario = true;
    abrirModal();
}