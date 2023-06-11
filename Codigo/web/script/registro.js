/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

let formulario = document.getElementsByTagName("form")[0];

window.onload = cargarFunciones;

//funcion en la que se cargan las funciones necesarias para el window onload
function cargarFunciones() {
    iniciar();
}

function iniciar() {
    document.getElementById("enviar").addEventListener('click', validar, false);
}

//comprueba que todo este correcto y ademas se haya confirmado el formulario
function validar(e) {
    if (validarUsuario() && validarContra() && validarNombre() && validarApellidos() 
            && validarFecha() && validarCorreo() && confirm("¿Desea continuar?")) {
        return true;
    } else {
        //Evitar que el usuario vaya a la pagina al ser incorrecto
        e.preventDefault();
        return false;
    }
}

//valida el campo del usuario
function validarUsuario () {
    let elemento = document.getElementById("usuario");
    let reg = /^[a-z0-9]{3,20}$/i;
    limpiarError(elemento);
    if (elemento.value == "") {
        error(elemento);
        return false;
    } else {
        if (!reg.test(elemento.value)) {
            elemento.value = "";
            elemento.placeholder = "solo hasta 20 letras y números";
            error(elemento);
            return false;
        }
    }
    return true;
}

//valida el campo de la fecha de nacimiento
function validarFecha() {
  let fecha = document.getElementById("fecha-nacimiento");
  if (fecha.value === "") {
    error(fecha);
    return false;
  } else {
    return true;
  }
}


//valida el campo de la contraseña
function validarContra () {
    let elemento = document.getElementById("contrasenia");
    let reg = /^[a-zA-Z0-9]{3,20}$/i;
    limpiarError(elemento);
    if (elemento.value == "") {
        error(elemento);
        return false;
    } else {
        if (!reg.test(elemento.value)) {
            elemento.value = "";
            elemento.placeholder = "solo hasta 20 letras y números";
            error(elemento);
            return false;
        }
    }
    return true;
}

//valida el campo del nombre
function validarNombre () {
    let elemento = document.getElementById("nombre");
    let reg = /^[a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{2,20}$/;
    limpiarError(elemento);
    if (elemento.value == "") {
        error(elemento);
        return false;
    } else {
        if (!reg.test(elemento.value)) {
            elemento.value = "";
            elemento.placeholder = "De 2 a 20 letras";
            error(elemento);
            return false;
        }
    }
    return true;
}

//valida el campo de los apellidos
function validarApellidos () {
    let elemento = document.getElementById("apellidos");
    let reg = /^[a-zA-ZÁÉÍÓÚáéíóúñÑ\s]{2,25}$/;
    limpiarError(elemento);
    if (elemento.value == "") {
        error(elemento);
        return false;
    } else {
        if (!reg.test(elemento.value)) {
            elemento.value = "";
            elemento.placeholder = "De 2 a 25 letras";
            error(elemento);
            return false;
        }
    }
    return true;
}

//valida el campo del correo electronico
function validarCorreo () {
    let elemento = document.getElementById("correo");
    let reg = /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;
    limpiarError(elemento);
    if (elemento.value == "") {
        error(elemento);
        return false;
    } else {
        if (!reg.test(elemento.value)) {
            elemento.value = "";
            elemento.placeholder = "Introduce una dirección de correo válida";
            error(elemento);
            return false;
        }
    }
    return true;
}

//limpia los errores
function limpiarError(a) {
    a.className = "";
}

//Se le pasa al elemento un class para darle un estilo de fallo
function error(a) {
    a.className = "error";
    a.focus();
}