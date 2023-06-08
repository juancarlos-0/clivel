/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


//Formulario para que se vea un icono de mensaje cuando te hayan enviado mensajes
document.getElementById('aplicarIconoMensaje').addEventListener('submit', function (event) {
    console.log("Formulario enviado");
    // Prevenir que se recargue la página al enviar el formulario
    event.preventDefault();

    // Obtener los valores de los campos de entrada
    var idUsuarioActual = document.querySelector('input[name="idUsuarioActual"]').value;
    var idUsuarioChat = document.querySelector('input[name="idUsuarioChat"]').value;

    // Crear una instancia de XMLHttpRequest
    var xhr = new XMLHttpRequest();

    // Configurar la petición
    xhr.open('POST', 'ajax/comprobarSiExistenMensajes.jsp', true);

    // Configurar el encabezado para el envío de datos en formato de formulario
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

    // Manejar la respuesta de la petición
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Si la petición se completó correctamente, actualizar la vista de la tabla de amigos
            document.getElementById('mostrarIcono').innerHTML = xhr.responseText;
        }
    };

    // Enviar la petición con los datos del formulario
    xhr.send('idUsuarioActual=' + encodeURIComponent(idUsuarioActual) +
            '&idUsuarioChat=' + encodeURIComponent(idUsuarioChat));
});


