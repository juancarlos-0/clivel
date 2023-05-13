/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


$(document).ready(function () {
    var resultados = [];

    $('#nombre-amigo').keyup(function () {
        var query = $('#nombre-amigo').val();
        $.ajax({
            url: 'ajax/buscarAmigos.jsp',
            type: 'POST',
            data: {query: query},
            success: function (data) {
                resultados = JSON.parse(data);
                mostrarResultados();
            }
        });
    });

    $('#resultados-amigos').on('click', 'li', function () {
        var nombre = $(this).text();
        $('#nombre-amigo').val(nombre);
        elegirResultado();
        $('#resultados-amigos').hide();
    });

    function mostrarResultados() {
        var contenedor = $('#resultados-amigos');
        contenedor.css('cursor', 'pointer');
        contenedor.empty();
        if (resultados.length > 0) {
            contenedor.show();
            for (var i = 0; i < resultados.length; i++) {
                var option = $('<li>').text(resultados[i].nombre);
                contenedor.append(option);
            }
            if (resultados[0].nombre.toLowerCase() == $('#nombre-amigo').val().toLowerCase()) {
                contenedor.hide();
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
        var query = $('#nombre-amigo-eliminar').val();
        $.ajax({
            url: 'ajax/eliminarAmigos.jsp',
            type: 'POST',
            data: {query: query},
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
    
    function mostrarResultados2() {
        var contenedor = $('#resultados-amigos-eliminar');
        contenedor.css('cursor', 'pointer');
        contenedor.empty();
        if (resultados.length > 0) {
            contenedor.show();
            for (var i = 0; i < resultados.length; i++) {
                var option = $('<li>').text(resultados[i].nombre);
                contenedor.append(option);
            }
            if (resultados[0].nombre.toLowerCase() == $('#nombre-amigo-eliminar').val().toLowerCase()) {
                contenedor.hide();
            }
        } else {
            contenedor.hide();
        }
    }
    
    function elegirResultado2() {
        $('#resultados-amigos-eliminar').on('click', 'li', function () {
            var nombre = $(this).text();
            $('#nombre-amigo-eliminar').val(nombre);
            ocultarResultados();
            $('#nombre-amigo-eliminar').focus();

        });
    }
});
