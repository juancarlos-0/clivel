/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
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
        try ( PrintWriter out = response.getWriter()) {
            //Obtener botones de envío
            String botonCambiarDatos = request.getParameter("cambiarDatos");
            String botonCambiarFoto = request.getParameter("cambiarFoto");

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
                SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
                Date fechaNacimientoDate = formatoFecha.parse(fechaNacimiento);
                String descripcion = request.getParameter("descripcion");
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
                int id = objetoSesion.getId_usuario();
                

                Usuario u = new Usuario();
                u.setId_usuario(id);

                //Obtener la foto de perfil
                Part fotoPerfil = request.getPart("foto-perfil");

                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                umDAO.subirFoto(u, fotoPerfil);
                umDAO.cerrarConexion();
                //Redirigir
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
