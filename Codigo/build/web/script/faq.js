/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


$(document).ready(function () {
    // Oculta todas las respuestas al cargar la página
    $('.respuesta').hide();

    // Agrega un evento de clic a las preguntas
    $('.pregunta').click(function () {
        // Encuentra la respuesta correspondiente a la pregunta
        var respuesta = $(this).next('.respuesta');

        // Alterna la visibilidad de la respuesta al hacer clic en la pregunta
        respuesta.slideToggle();
    });
});