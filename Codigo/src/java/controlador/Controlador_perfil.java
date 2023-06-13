/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modelo.DAO.UsuarioModeloDAO;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
@MultipartConfig
@WebServlet(name = "Controlador_perfil", urlPatterns = {"/Controlador_perfil"})
public class Controlador_perfil extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            //Obtener botones de envío
            String botonCambiarDatos = request.getParameter("cambiarDatos");
            String botonCambiarFoto = request.getParameter("cambiarFoto");
            String botonCambiarFondo = request.getParameter("cambiarFondo");

            // Obtener la sesion
            HttpSession session = request.getSession(false);

            if (botonCambiarDatos != null) {
                // Obtener el usuario de la sesión
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
                // Obtener el nombre del usuario
                String nombreUsuarioSesion = request.getParameter("usuarioOriginal");
                // Comprobar si el usuario introducido es igual o diferente
                String nombreUsuario = request.getParameter("usuario");
                //Si el nombre es igual no se cambia el nombre así que
                //se recogen todos los datos a modificar
                String apellidos = request.getParameter("apellidos");
                String contresenia = request.getParameter("contrasenia");
                String nombre = request.getParameter("nombre");
                String fechaNacimiento = request.getParameter("fechaNacimiento");
                SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaNacimientoDate = formatoFecha.parse(fechaNacimiento);
                String descripcion = new String(request.getParameter("descripcion").getBytes("ISO-8859-1"), "UTF-8");
                String correo = request.getParameter("correo");
                String idString = request.getParameter("id");
                int id = Integer.parseInt(idString);

                //Introducir los datos en el objeto del usuario
                Usuario usu = new Usuario();
                usu.setId_usuario(id);
                usu.setApellidos(apellidos);
                usu.setContrasenia(contresenia);
                usu.setNombre(nombre);
                usu.setFecha_nacimiento(fechaNacimientoDate);
                usu.setDescripcion(descripcion);
                usu.setCorreo(correo);
                usu.setUsuario(nombreUsuario);
                //Comprobar que el nuevo usuario sea igual al antiguo
                if (nombreUsuario.equals(nombreUsuarioSesion)) {
                    //Actualizar los datos sin cambiar el nombre de usuario
                    UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                    umDAO.actualizaDatos(usu);
                    //Actualizar el objeto de la sesion
                    usu = umDAO.devolverDatos(nombreUsuario);
                    umDAO.cerrarConexion();
                    session.setAttribute("datosUsuario", usu);
                    //Redirigir
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                } else {
                    //Actualiza los datos cambiando el nombre del usuario
                    UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                    umDAO.actualizaDatosUsuario(usu);//Actualizar el objeto de la sesion
                    usu = umDAO.devolverDatos(nombreUsuario);
                    umDAO.cerrarConexion();
                    session.setAttribute("datosUsuario", usu);
                    //Redirigir
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;

                }
            }

            if (botonCambiarFoto != null) {
                // Obtener el usuario de la sesión
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");

                //Obtener la imagen mediante una Part
                Part parteFichero = request.getPart("foto-perfil");

                //comprobar de que se haya introducido una imagen
                if (parteFichero == null || parteFichero.getSize() == 0) {
                    //Crear error
                    request.setAttribute("errorInsertarFoto", "Debe introducir una foto para subirla.");
                    //Redirigir nuevamente al login
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                }
                
                //Obtener el nombre del fichero
                String nombreFichero = parteFichero.getSubmittedFileName();
                //Obtener la extensión del fichero
                String extensionFichero = nombreFichero.substring(nombreFichero.lastIndexOf("."));
                
                //comprobar la extensión del fichero
                if (!extensionFichero.toLowerCase().equals(".jpg") && !extensionFichero.toLowerCase().equals(".png")
                        && !extensionFichero.toLowerCase().equals(".jpeg")) {
                    //Crear error
                    request.setAttribute("errorInsertarFoto", "Debe ser una imagen(jpg, png o jpeg).");
                    //Redirigir nuevamente al login
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                }
                
                //Crear ubicación para el fichero
                String ubicacion = getServletContext().getRealPath("/img/usuarios/");
                //Nombre único para el fichero con el nombre del usuario
                String nombreDeFichero = objetoSesion.getUsuario() + extensionFichero;
                //Obtener la ruta de destino
                String rutaDestino = ubicacion + File.separator + (objetoSesion.getUsuario() + extensionFichero);
                Path rutaArchivo = Paths.get(rutaDestino);

                // Verificar si el archivo existe y eliminarlo si es necesario
                if (Files.exists(rutaArchivo)) {
                    Files.delete(rutaArchivo);
                }
                
                Files.copy(parteFichero.getInputStream(), Paths.get(ubicacion, nombreDeFichero));
                //Guardar la ruta de la foto en la BD
                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                umDAO.subirFoto(objetoSesion.getId_usuario(), "img/usuarios/" + nombreDeFichero);
                umDAO.cerrarConexion();
                //Establecer nuevamente el objeto con la nueva ruta
                objetoSesion.setFoto("img/usuarios/" + nombreDeFichero);
                request.setAttribute("datosUsuario", objetoSesion);

                //Redirigir nuevamente al login
                request.getRequestDispatcher("perfil.jsp").forward(request, response);
                return;
            }

            if (botonCambiarFondo != null) {
                // Obtener el usuario de la sesión
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");

                //Obtener la imagen mediante una Part
                Part parteFichero = request.getPart("fondo-perfil");
                
                //Comprobar de que se haya introducido un fondo
                if (parteFichero == null || parteFichero.getSize() == 0) {
                    //Crear error
                    request.setAttribute("errorInsertarFondo", "Debe introducir un fondo para subirlo.");
                    //Redirigir nuevamente al login
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                }
                
                //Obtener el nombre del fichero
                String nombreFichero = parteFichero.getSubmittedFileName();
                //Obtener la extensión del fichero
                String extensionFichero = nombreFichero.substring(nombreFichero.lastIndexOf("."));
                
                //comprobar la extensión del fichero
                if (!extensionFichero.toLowerCase().equals(".jpg") && !extensionFichero.toLowerCase().equals(".png")
                        && !extensionFichero.toLowerCase().equals(".jpeg")) {
                    //Crear error
                    request.setAttribute("errorInsertarFondo", "Debe ser una imagen(jpg, png o jpeg).");
                    //Redirigir nuevamente al login
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                }
                
                //Crear ubicación para el fichero
                String ubicacion = getServletContext().getRealPath("/img/fondo/");
                //Nombre único para el fichero con el nombre del usuario
                String nombreDeFichero = objetoSesion.getUsuario() + extensionFichero;
                //Obtener la ruta de destino
                String rutaDestino = ubicacion + File.separator + (objetoSesion.getUsuario() + extensionFichero);
                Path rutaArchivo = Paths.get(rutaDestino);

                // Verificar si el archivo existe y eliminarlo si es necesario
                if (Files.exists(rutaArchivo)) {
                    Files.delete(rutaArchivo);
                }

                Files.copy(parteFichero.getInputStream(), Paths.get(ubicacion, nombreDeFichero));
                //Guardar la ruta de la foto en la BD
                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                umDAO.subirFondo(objetoSesion.getId_usuario(), "img/fondo/" + nombreDeFichero);
                umDAO.cerrarConexion();
                //Establecer nuevamente el objeto con la nueva ruta
                objetoSesion.setFoto("img/usuarios/" + nombreDeFichero);
                request.setAttribute("datosUsuario", objetoSesion);

                //Redirigir nuevamente al login
                request.getRequestDispatcher("perfil.jsp").forward(request, response);
                return;
            }
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(Controlador_perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(Controlador_perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
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
