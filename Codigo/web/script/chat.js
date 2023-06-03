/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Cuando se envía el formulario del chat
$('#chat-form').submit(function (event) {
    // Prevenir que se recargue la página al enviar el formulario
    event.preventDefault();

    // Obtener el mensaje del campo de entrada
    var message = $('input[name="chat-input"]').val();

    // Enviar una petición Ajax al servidor para guardar el mensaje en la base de datos
    var id_usuario_envio = $('input[name="id_usuario_envio_mensaje"]').val(); // Obtener el valor del campo de entrada

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

var id_usuario_envio = $('input[name="id_usuario_envio_mensaje"]').val();

// Configurar una función para recibir actualizaciones del servidor
function verificarNuevosMensajes() {
    $.ajax({
        url: 'ajax/recibir_actualizaciones.jsp',
        method: 'POST',
        data: {
            id_usuario_envio_mensaje: id_usuario_envio
        },
        success: function (data) {
            // Agregar nuevos mensajes al chat-body
            $('#chat-body').append(data);

            // Establecer la posición del scroll en la parte inferior del chat-body solo si se agregaron nuevos mensajes

        }
    });
}


function cargarMensajesAnteriores() {
    $.ajax({
        url: 'ajax/cargar_mensajes_anteriores.jsp',
        method: 'POST',
        data: {
            id_usuario_envio_mensaje: id_usuario_envio
        },
        success: function (data) {
            // Actualizar la vista del chat con todos los mensajes anteriores
            $('#chat-body').append(data);

            // Establecer la posición del scroll en la parte inferior del chat-body
            $('#chat-body').scrollTop($('#chat-body')[0].scrollHeight);

        }
    });
}

// Comenzar a recibir actualizaciones
cargarMensajesAnteriores();

// Llamar a la función verificarNuevosMensajes cada 5 segundos
setInterval(verificarNuevosMensajes, 500);
