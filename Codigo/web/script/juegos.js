// url de la api rawg
var apiUrl = "https://api.rawg.io/api/games";
// url de la key para obtener datos
var apiKey = "689ff6adde4e4c8aa9d9f2b52dd35c79";
// Página por la que se comienza
var currentPage = 1;
// Cantidad máxima de juegos por página
var gamesPerPage = 20;

// contenedor donde se ponen todas las cartas
var contenedorJuegos = document.getElementById("contenedorJuegos");
// contenedor donde se pone la paginacion
var paginacion = document.getElementById("paginacion");

// variables con dos select y un input
var desplegable1 = document.getElementById("desplegable1");
var desplegable2 = document.getElementById("desplegable2");
var inputBusqueda = document.getElementById("busqueda");

//funcion que hace la peticion ajax, muestra las cards y la paginacion
function cargarJuegos(page, filtro1, filtro2, inputBusqueda) {
    var request = new XMLHttpRequest();

    //si todos los metodos de filtro/busqueda estan vacios una url especifica
    if (filtro1.trim() === "" && filtro2.trim() === "" && inputBusqueda.trim() === "") {
        request.open("GET", apiUrl + "?key=" + apiKey + "&page=" + page, true);
    } else {
        //sino estan vacios se construye url unica
        var url = apiUrl + "?key=" + apiKey + "&page=" + page;

        // Objeto de mapeo para los filtros de plataforma
        const plataformaFiltros = {
            Playstation: "&platforms=18",
            Xbox: "&platforms=1",
            Nintendo: "&platforms=7",
            Pc: "&platforms=4",
            Ios: "&platforms=3",
            Android: "&platforms=21"
        };

        // Objeto de mapeo para los filtros de ordenamiento
        const ordenamientoFiltros = {
            popularidad: "&ordering=-added",
            valoracion: "&ordering=-metacritic",
            valoracionMala: "&ordering=metacritic",
            lanzamiento: "&ordering=-released",
            adicion: "&ordering=added",
            tiempo: "&ordering=playtime"
        };

        // 3 posibilidades de filtro de los selects
        if (filtro1.trim() !== "" && filtro2.trim() !== "") {
            // Ambos filtros tienen valor
            url += ordenamientoFiltros[filtro1] + plataformaFiltros[filtro2];
        } else if (filtro1.trim() !== "") {
            // Solo el filtro1 tiene valor
            url += ordenamientoFiltros[filtro1];
        } else if (filtro2.trim() !== "") {
            // Solo el filtro2 tiene valor
            url += plataformaFiltros[filtro2];
        }

        // Agregar inputBusqueda a la URL de la solicitud
        if (inputBusqueda.trim() !== "") {
            url += "&search=" + inputBusqueda;
        }

        request.open("GET", url, true);
    }
    request.onload = function () {
        if (request.status >= 200 && request.status < 400) {
            //Variables
            var datos = JSON.parse(request.responseText);
            var juegos = datos.results;
            var totalGames = datos.count || juegos.length;

            // Vaciar el contenedor de juegos antes de cargar los nuevos
            contenedorJuegos.innerHTML = "";

            // Bucle para recorrer cada juego
            juegos.forEach(game => {
                //crear elemento carta que contiene todo sobre el juego
                var cartaJuego = document.createElement("div");
                cartaJuego.className = "col-md-4 cartaJuego";

                var card = document.createElement("div");
                card.className = "card";

                // Crear imagen del juego
                var imagenJuego = document.createElement("img");
                imagenJuego.src = game.background_image;
                imagenJuego.className = "card-img-top";

                // Crear contenedor para el carrusel
                var carouselContainer = document.createElement("div");
                carouselContainer.className = "carousel slide";
                carouselContainer.id = "carouselJuego-" + game.id;

                // Realizar la solicitud a la API para obtener las imágenes del carrusel
                var xhr = new XMLHttpRequest();
                var urlImagenes = "https://api.rawg.io/api/games/" + game.id + "/screenshots?key=" + apiKey;
                xhr.open("GET", urlImagenes, true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        var data = JSON.parse(xhr.responseText);
                        var screenshots = data.results.map(result => result.image);

                        // Crear elementos para el carrusel
                        var carouselInner = document.createElement("div");
                        carouselInner.className = "carousel-inner";

                        var slidePrincipal = document.createElement("div");
                        slidePrincipal.className = "carousel-item active";
                        slidePrincipal.appendChild(imagenJuego);
                        carouselInner.appendChild(slidePrincipal);

                        screenshots.forEach((imageSrc) => {
                            var slide = document.createElement("div");
                            slide.className = "carousel-item";

                            var image = document.createElement("img");
                            image.src = imageSrc;
                            image.alt = "Captura de pantalla del juego";

                            slide.appendChild(image);
                            carouselInner.appendChild(slide);
                        });

                        // Crear indicadores (dots) y ocultarlos inicialmente
                        var carouselIndicators = document.createElement("ol");
                        carouselIndicators.className = "carousel-indicators";
                        carouselIndicators.style.display = "none";

                        // Crear indicador para la imagenJuego (primera diapositiva)
                        var indicatorPrincipal = document.createElement("li");
                        indicatorPrincipal.setAttribute("data-bs-target", "#carouselJuego-" + game.id);
                        indicatorPrincipal.setAttribute("data-bs-slide-to", "0");
                        indicatorPrincipal.className = "active";
                        carouselIndicators.appendChild(indicatorPrincipal);

                        // Crear indicadores para las diapositivas adicionales
                        screenshots.forEach((_, index) => {
                            var indicator = document.createElement("li");
                            indicator.setAttribute("data-bs-target", "#carouselJuego-" + game.id);
                            indicator.setAttribute("data-bs-slide-to", (index + 1).toString());
                            carouselIndicators.appendChild(indicator);
                        });

                        carouselContainer.appendChild(carouselIndicators);

                        carouselContainer.appendChild(carouselInner);

                        // Inicializar el carrusel de Bootstrap
                        var carouselInstance = new bootstrap.Carousel(carouselContainer, {
                            interval: false // Deshabilitar reproducción automática
                        });

                        // Pausar el carrusel al pasar el mouse por encima
                        carouselContainer.addEventListener("mouseenter", function () {
                            carouselInstance.pause();
                            carouselIndicators.style.display = "flex"; // Mostrar los dots al pasar el mouse sobre el carrusel
                        });

                        // Reanudar el carrusel al quitar el mouse
                        carouselContainer.addEventListener("mouseleave", function () {
                            carouselInstance.cycle();
                            carouselIndicators.style.display = "none"; // Ocultar los dots al quitar el mouse del carrusel
                        });
                    }
                };

                // Realizar la solicitud al servidor
                xhr.send();

                // crear div para el cuerpo de la carta
                var cardBody = document.createElement("div");
                cardBody.className = "card-body";

                // Crear formulario para el título del juego
                var formTitulo = document.createElement("form");
                formTitulo.setAttribute("action", "ControladorJuegos");
                

                // Crear el botón del título del juego
                var tituloJuego = document.createElement("button");
                tituloJuego.type = "submit";
                tituloJuego.className = "btn-like-h5";
                tituloJuego.textContent = game.name;
                tituloJuego.name = "botonJuego";

                // Crear el input oculto con el id del juego
                var inputIdJuego = document.createElement("input");
                inputIdJuego.type = "hidden";
                inputIdJuego.name = "pkJuego";
                inputIdJuego.value = game.id;

                // Añadir el botón al formulario
                formTitulo.appendChild(inputIdJuego);
                formTitulo.appendChild(tituloJuego);

                // Crear elementos para los nombres de las plataformas
                var plataformaNames = document.createElement("div");
                plataformaNames.className = "plataforma-names";

                // Añadir el formulario al contenedor del título
                var tituloContainer = document.createElement("h5");
                tituloContainer.appendChild(formTitulo);

                // Crear elementos para los nombres de las plataformas
                var plataformaNames = document.createElement("div");
                plataformaNames.className = "plataforma-names";

                // set para comprobar que no se repitan elementos
                var iconSet = new Set();

                // recorrer las plataformas para cada juego
                game.platforms.forEach(platform => {
                    var platformName = platform.platform.name.toLowerCase();

                    //  comprobaciones de que exista ese elemento en el set
                    if (platformName.includes("xbox") && !iconSet.has("bi bi-xbox")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-xbox";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.xbox.com";
                        platformLinkEnlace.target = "_blank";
                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);

                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-xbox");
                    } else if (platformName.includes("playstation") && !iconSet.has("bi bi-playstation")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-playstation";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.playstation.com";
                        platformLinkEnlace.target = "_blank";
                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);

                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-playstation");
                    } else if (platformName.includes("nintendo") && !iconSet.has("bi bi-nintendo-switch")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-nintendo-switch";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.nintendo.com";
                        platformLinkEnlace.target = "_blank";
                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);

                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-nintendo-switch");
                    } else if (platformName.includes("pc") && !iconSet.has("bi bi-desktop")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-pc";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.pccomponentes.com";
                        platformLinkEnlace.target = "_blank";
                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);

                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-pc");
                    } else if (platformName.includes("ios") && !iconSet.has("bi bi-phone")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-phone";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.ios.com";
                        platformLinkEnlace.target = "_blank";
                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);

                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-phone");
                    } else if (platformName.includes("android") && !iconSet.has("bi bi-phone")) {
                        var platformIcon = document.createElement("i");
                        platformIcon.className = "bi bi-phone";

                        var platformLinkEnlace = document.createElement("a");
                        platformLinkEnlace.href = "https://www.android.com";

                        platformLinkEnlace.className = "icon-link";
                        platformLinkEnlace.appendChild(platformIcon);
                        platformLinkEnlace.target = "_blank";
                        plataformaNames.appendChild(platformLinkEnlace);
                        iconSet.add("bi bi-phone");
                    }
                });

                // contenedor para la nota
                var metacriticContainer = document.createElement("div");
                metacriticContainer.className = "metacritic-container";

                // contenedor para los iconos
                var contenedorIconos = document.createElement("div");
                contenedorIconos.appendChild(plataformaNames);

                // parrafo para la nota
                var metacriticRating = document.createElement("p");
                metacriticRating.className = "metacritic-rating";
                metacriticRating.textContent = game.metacritic;

                // comprobar que tenga nota o añadir un no aplica
                if (metacriticRating.textContent.trim() === "") {
                    metacriticRating.textContent = "NA";
                }

                // añadir parrafo de la nota al div
                metacriticContainer.appendChild(metacriticRating);

                // crear contenedor para icono y nota
                var contenedorLinea = document.createElement("div");
                contenedorLinea.className = "contenedor-linea";

                // añadir icono y nota al contenedor
                contenedorLinea.appendChild(contenedorIconos);
                contenedorLinea.appendChild(metacriticContainer);

                // añadir todo lo que falta al body de la carta
                cardBody.appendChild(contenedorLinea);

                // Añadir el contenedor del carousel a la carta

                cardBody.appendChild(tituloContainer);

                // añadir a la pagna
                card.appendChild(carouselContainer);
                card.appendChild(cardBody);
                cartaJuego.appendChild(card);
                contenedorJuegos.appendChild(cartaJuego);
            });

            // Actualizar la paginación
            actualizarPaginacion(totalGames);

        } else {
            // control de errores
            console.error("Error en la solicitud: " + request.statusText);
        }
    };
    // comprobar errores
    request.onerror = function () {
        console.error("Error de conexión");
    };
    request.send();
}

// funcion que crea la paginacion y la actualiza
function actualizarPaginacion(totalGames) {
    //variable para hacer calculo de las paginas que habrá
    var totalPages = Math.ceil(totalGames / gamesPerPage);

    // Vaciar la paginación antes de actualizarla
    paginacion.innerHTML = "";

    // Crear botones de paginación: Anterior
    var buttonAnterior = document.createElement("button");
    buttonAnterior.textContent = "Anterior";
    buttonAnterior.className = "btn btn-secondary";

    //comprobacion para que al boton anterior no se ponga en negativo
    buttonAnterior.addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            introducirDatosInputsSinPaginacion();
        }
    });
    paginacion.appendChild(buttonAnterior);

    // Crear bloques de paginación
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(startPage + 4, totalPages);

    //crear botones, maximo seran 5
    for (var i = startPage; i <= endPage; i++) {
        var button = document.createElement("button");
        button.textContent = i;
        button.className = "btn btn-secondary";

        // añadir estilo a la paginacion en la que estamos
        if (i == currentPage) {
            button.style.backgroundColor = "#8a6fd2";
            button.style.color = "white";
            button.style.fontWeight = "bold";
        }
        // evento para cuando haces click cambiar de pagina a cada boton
        button.addEventListener("click", function () {
            currentPage = parseInt(this.textContent);
            introducirDatosInputsSinPaginacion();
        });
        paginacion.appendChild(button);
    }

    // Crear botones de paginación: Siguiente
    var buttonSiguiente = document.createElement("button");
    buttonSiguiente.textContent = "Siguiente";
    buttonSiguiente.className = "btn btn-secondary";
    // evento que comprueba que no puedas superar el limite de paginas
    buttonSiguiente.addEventListener("click", function () {
        if (currentPage < totalPages) {
            currentPage++;
            introducirDatosInputsSinPaginacion();
        }
    });
    paginacion.appendChild(buttonSiguiente);
}

//evento al select de ordenado por
desplegable1.addEventListener("change", function () {
    introducirDatosInputs();
});

//eventos al select de las plataformas
desplegable2.addEventListener("change", function () {
    introducirDatosInputs();
});

//evento al input text
inputBusqueda.addEventListener("input", function () {
    introducirDatosInputs();
});

//funcion para adquirir datos de los filtros
function introducirDatosInputs() {
    var opcionSeleccionada1 = desplegable1.options[desplegable1.selectedIndex].value;
    var opcionSeleccionada2 = desplegable2.options[desplegable2.selectedIndex].value;
    var textoBusqueda = inputBusqueda.value;
    //al filtrar la pagina se pondrá a 1
    currentPage = 1;
    cargarJuegos(currentPage, opcionSeleccionada1, opcionSeleccionada2, textoBusqueda);
}

//funcion para adquirir datos de los filtros sin resetear las paginas
function introducirDatosInputsSinPaginacion() {
    var opcionSeleccionada1 = desplegable1.options[desplegable1.selectedIndex].value;
    var opcionSeleccionada2 = desplegable2.options[desplegable2.selectedIndex].value;
    var textoBusqueda = inputBusqueda.value;
    cargarJuegos(currentPage, opcionSeleccionada1, opcionSeleccionada2, textoBusqueda);
}

// Cargar juegos de la página inicial
cargarJuegos(currentPage, "", "", "");