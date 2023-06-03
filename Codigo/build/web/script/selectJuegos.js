var desplegable1 = document.getElementById("desplegable1");
var desplegable2 = document.getElementById("desplegable2");

desplegable1.addEventListener("change", function() {
  desplegable1.style.color = "white";
  var opcionSeleccionada = desplegable1.options[desplegable1.selectedIndex].text;
  var opcionSeleccionadaValue = desplegable1.options[desplegable1.selectedIndex].value;
  
  desplegable1.options[0].textContent = "Ordenado por: " + opcionSeleccionada;
  desplegable1.options[0].value = opcionSeleccionadaValue; // Establecer el valor como vacío 
  desplegable1.selectedIndex = 1; // Seleccionar otro elemento en el desplegable
  desplegable1.selectedIndex = 0; // Volver a seleccionar el índice 0
  
});

desplegable2.addEventListener("change", function() {
    desplegable2.style.color = "white";
});
