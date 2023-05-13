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
    document.getElementById("cambiarDatos").addEventListener('click', validar, false);
}

//comprueba que todo este correcto y ademas se haya confirmado el formulario
function validar(e) {
    if (validarUsuario() && validarContra() && validarNombre() && validarApellidos() 
            && validarFecha() && confirm("¿Cambiar los datos?")) {
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
  let fecha = document.getElementById("fechaNacimiento");
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

//valida el campo del nombre
function validarNombre () {
    let elemento = document.getElementById("nombre");
    let reg = /^[a-z]+(?:\s[a-z]+)*$/i;
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
    let reg = /^[a-z]{2,25}$/i;
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

//limpia los errores
function limpiarError(a) {
    a.className = "form-control";
}

//Se le pasa al elemento un class para darle un estilo de fallo
function error(a) {
    a.className = "form-control border-danger";
    a.focus();
}
