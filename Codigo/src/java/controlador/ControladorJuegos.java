/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.DAO.JuegoDAO;
import modelo.DAO.ValoracionDAO;
import modelo.Juego;
import modelo.JuegoRawg;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
@WebServlet(name = "ControladorJuegos", urlPatterns = {"/ControladorJuegos"})
public class ControladorJuegos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String botonJuego = request.getParameter("botonJuego");
            String pkJuego = request.getParameter("pkJuego");

            // si se quiere ver un juego en específico
            if (pkJuego != null) {
                //datos para conectar con la API
                String apiKey = "689ff6adde4e4c8aa9d9f2b52dd35c79";
                String apiURL = "https://api.rawg.io/api/games/" + pkJuego + "?key=" + apiKey;

                //conectar con la api
                try {
                    // Realizar la solicitud GET a la API
                    URL url = new URL(apiURL);
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("GET");

                    // Leer la respuesta de la API
                    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                    StringBuilder respuesta = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        respuesta.append(line);
                    }
                    reader.close();

                    // Crear un JsonParser 
                    JsonParser parser = new JsonParser();

                    // Leer la respuesta JSON y obtener el nombre del juego
                    JsonObject jsonObject = parser.parse(respuesta.toString()).getAsJsonObject();
                    String nombreJuego = jsonObject.get("name").getAsString();
                    String imagenPrincipal = jsonObject.get("background_image").getAsString();

                    // Obtener las plataformas del juego
                    JsonArray platformsArray = jsonObject.get("parent_platforms").getAsJsonArray();
                    List<String> plataformas = new ArrayList<>();
                    for (JsonElement platformElement : platformsArray) {
                        JsonObject platformObject = platformElement.getAsJsonObject();
                        String plataforma = platformObject.get("platform").getAsJsonObject().get("name").getAsString();
                        plataformas.add(plataforma);
                    }

                    // Obtener el tiempo promedio de juego
                    int averagePlaytime = jsonObject.get("playtime").getAsInt();

                    //Obtener la fecha de salida del juego
                    String fechaDeLanzamiento = jsonObject.get("released").getAsString();

                    // Obtener la descripción del juego
                    String descripcion = new String(jsonObject.get("description").getAsString().getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

                    // Obtener los géneros del juego
                    JsonArray genresArray = jsonObject.getAsJsonArray("genres");
                    List<String> genres = new ArrayList<>();
                    for (JsonElement element : genresArray) {
                        JsonObject genreObject = element.getAsJsonObject();
                        if (genreObject.has("name")) {
                            String genre = genreObject.get("name").getAsString();
                            genres.add(genre);
                        }
                    }

                    // Obtener los desarrolladores del juego
                    JsonArray developersArray = jsonObject.getAsJsonArray("developers");
                    List<String> developers = new ArrayList<>();
                    for (JsonElement element : developersArray) {
                        JsonObject developerObject = element.getAsJsonObject();
                        if (developerObject.has("name")) {
                            String developer = developerObject.get("name").getAsString();
                            developers.add(developer);
                        }
                    }

                    // Obtener los publicadores del juego
                    JsonArray publishersArray = jsonObject.getAsJsonArray("publishers");
                    List<String> publishers = new ArrayList<>();
                    for (JsonElement element : publishersArray) {
                        JsonObject publisherObject = element.getAsJsonObject();
                        if (publisherObject.has("name")) {
                            String publisher = publisherObject.get("name").getAsString();
                            publishers.add(publisher);
                        }
                    }

                    // Obtener la edad recomendada del juego
                    int ageRating = -1; // Valor predeterminado para juegos sin clasificación de edad
                    if (jsonObject.has("esrb_rating")) {
                        JsonElement esrbRatingElement = jsonObject.get("esrb_rating");
                        if (esrbRatingElement instanceof JsonObject) {
                            ageRating = esrbRatingElement.getAsJsonObject().get("id").getAsInt();
                        }
                    }

                    // Obtener la valoración de Metacritic del juego
                    int metacriticRating = -1; // Valor predeterminado para juegos sin valoración de Metacritic
                    if (jsonObject.has("metacritic")) {
                        JsonElement metacriticElement = jsonObject.get("metacritic");
                        if (metacriticElement instanceof JsonPrimitive && ((JsonPrimitive) metacriticElement).isNumber()) {
                            metacriticRating = metacriticElement.getAsInt();
                        }
                    }

                    // Obtener la lista de trailers del juego
                    String trailersURL = "https://api.rawg.io/api/games/" + pkJuego + "/movies?key=" + apiKey;
                    URL trailersUrl = new URL(trailersURL);
                    HttpURLConnection trailersConnection = (HttpURLConnection) trailersUrl.openConnection();
                    trailersConnection.setRequestMethod("GET");

                    BufferedReader trailersReader = new BufferedReader(new InputStreamReader(trailersConnection.getInputStream()));
                    StringBuilder trailersResponse = new StringBuilder();
                    String trailersLine;
                    while ((trailersLine = trailersReader.readLine()) != null) {
                        trailersResponse.append(trailersLine);
                    }
                    trailersReader.close();

                    JsonParser trailersParser = new JsonParser();
                    JsonObject trailersJsonObject = trailersParser.parse(trailersResponse.toString()).getAsJsonObject();
                    JsonArray trailersArray = trailersJsonObject.getAsJsonArray("results");

                    List<String> trailersList = new ArrayList<>();
                    for (JsonElement trailerElement : trailersArray) {
                        JsonObject trailerObject = trailerElement.getAsJsonObject();
                        String trailerUrl = trailerObject.get("data").getAsJsonObject().get("max").getAsString();
                        trailersList.add(trailerUrl);
                    }

                    // Obtener la lista de capturas de pantalla del juego
                    String screenshotsURL = "https://api.rawg.io/api/games/" + pkJuego + "/screenshots?key=" + apiKey;
                    URL screenshotsUrl = new URL(screenshotsURL);
                    HttpURLConnection screenshotsConnection = (HttpURLConnection) screenshotsUrl.openConnection();
                    screenshotsConnection.setRequestMethod("GET");

                    BufferedReader screenshotsReader = new BufferedReader(new InputStreamReader(screenshotsConnection.getInputStream()));
                    StringBuilder screenshotsResponse = new StringBuilder();
                    String screenshotsLine;
                    while ((screenshotsLine = screenshotsReader.readLine()) != null) {
                        screenshotsResponse.append(screenshotsLine);
                    }
                    screenshotsReader.close();

                    JsonParser screenshotsParser = new JsonParser();
                    JsonObject screenshotsJsonObject = screenshotsParser.parse(screenshotsResponse.toString()).getAsJsonObject();
                    JsonArray screenshotsArray = screenshotsJsonObject.getAsJsonArray("results");

                    List<String> screenshotsList = new ArrayList<>();
                    for (JsonElement screenshotElement : screenshotsArray) {
                        JsonObject screenshotObject = screenshotElement.getAsJsonObject();
                        String screenshotUrl = screenshotObject.get("image").getAsString();
                        screenshotsList.add(screenshotUrl);
                    }

                    // Construir la URL de la API para obtener las tiendas del juego
                    String storesURL = "https://api.rawg.io/api/games/" + pkJuego + "/stores?key=" + apiKey;

                    // Realizar la solicitud GET a la API de las tiendas
                    URL storesUrl = new URL(storesURL);
                    HttpURLConnection storesConnection = (HttpURLConnection) storesUrl.openConnection();
                    storesConnection.setRequestMethod("GET");

                    // Leer la respuesta de la API de las tiendas
                    BufferedReader storesReader = new BufferedReader(new InputStreamReader(storesConnection.getInputStream()));
                    StringBuilder storesResponse = new StringBuilder();
                    String storesLine;
                    while ((storesLine = storesReader.readLine()) != null) {
                        storesResponse.append(storesLine);
                    }
                    storesReader.close();

                    // Parsear la respuesta JSON de las tiendas
                    JsonParser storesParser = new JsonParser();
                    JsonObject storesJsonObject = storesParser.parse(storesResponse.toString()).getAsJsonObject();
                    JsonArray storesArray = storesJsonObject.getAsJsonArray("results");

                    Map<String, String> storesMap = new HashMap<>();

                    for (JsonElement storeElement : storesArray) {
                        JsonObject storeObject = storeElement.getAsJsonObject();
                        int storeId = storeObject.get("store_id").getAsInt();
                        String storeUrl = storeObject.get("url").getAsString();

                        // Obtener el nombre de la tienda en base al ID utilizando el enumerado
                        String storeName = getNombreTiendaPorId(storeId);

                        // Agregar la entrada al mapa
                        storesMap.put(storeName, storeUrl);
                    }

                    JuegoRawg jr = new JuegoRawg();
                    jr.setNombre(nombreJuego);
                    jr.setImagenPrincipal(imagenPrincipal);
                    jr.setPlataformas(plataformas);
                    jr.setTiempoPromedioDejuego(averagePlaytime);
                    jr.setFechaLanzamiento(fechaDeLanzamiento);
                    jr.setDescripcion(descripcion);
                    jr.setDesarrolladores(developers);
                    jr.setGenero(genres);
                    jr.setEdadRecomendada(ageRating);
                    jr.setMetacritic(metacriticRating);
                    jr.setTrailer(trailersList);
                    jr.setImagenesAdicionales(screenshotsList);
                    jr.setUrlCompraJuego(storesMap);

                    // Comprobar si el id de rawg existe en la base de datos, sino insertarlo
                    Juego j = new Juego();
                    j.setId_juego(Integer.parseInt(pkJuego));

                    JuegoDAO jDAO = new JuegoDAO();
                    boolean existeJuego = jDAO.compruebaID(j.getId_juego());

                    //sino existe insertar el id del juego
                    if (!existeJuego) {
                        jDAO.agregarID(j.getId_juego());
                    }

                    jDAO.cerrarConexion();

                    jr.setIdJuego(j.getId_juego());

                    // Comprobar que el usuario ya tenga una valoracion en la bd
                    HttpSession session = request.getSession();

                    // Realizar operaciones con la sesión
                    Usuario datosUsuario = (Usuario) session.getAttribute("datosUsuario");
                    
                    boolean existeValoracion = false;
                    
                    if (datosUsuario != null) {
                        ValoracionDAO vDAO = new ValoracionDAO();
                        existeValoracion = vDAO.existeValoracion(datosUsuario.getId_usuario(), j.getId_juego());
                        vDAO.cerrarConexion();
                    }

                    request.setAttribute("existeValoracion", existeValoracion);

                    request.setAttribute("juego", jr);
                    request.getRequestDispatcher("juego.jsp").forward(request, response);
                    return; 

                } catch (IOException e) {
                    e.printStackTrace();
                }

            }
        }
    }

    private String getNombreTiendaPorId(int id) {
        String storeName = null;
        switch (id) {
            case 1:
                storeName = "Steam";
                break;
            case 3:
                storeName = "PlayStation Store";
                break;
            case 2:
                storeName = "Xbox Series Store";
                break;
            case 4:
                storeName = "App Store";
                break;
            case 5:
                storeName = "GOG";
                break;
            case 6:
                storeName = "Nintendo Store";
                break;
            case 7:
                storeName = "Xbox 360 Store";
                break;
            case 8:
                storeName = "Google Play";
                break;
            case 9:
                storeName = "itch.io";
                break;
            case 11:
                storeName = "Epic Games";
                break;
            default:
                // Tienda no encontrada
                break;
        }
        return storeName;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
