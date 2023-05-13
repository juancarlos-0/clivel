/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
import modelo.DAO.UsuarioModeloDAO;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
@WebServlet(name = "Comprobar_registro_de_usuario", urlPatterns = {"/Comprobar_registro_de_usuario"})
public class Comprobar_registro_de_usuario extends HttpServlet {

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
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String botonRegistrarse = request.getParameter("enviar");
            if (botonRegistrarse != null) {

                //Obtener datos introducidos por el usuario
                String usuario = request.getParameter("usuario");
                String nombre = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String contrasenia = request.getParameter("contrasenia");

                //Obtener fecha y convertirla util.DATE
                String fecha_nacimiento = request.getParameter("fecha-nacimiento");
                SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
                Date fechaNacimiento = formatoFecha.parse(fecha_nacimiento);

                String correo = request.getParameter("correo");

                //Convertirlo a objeto
                Usuario objeto_usuario = new Usuario();
                objeto_usuario.setUsuario(usuario);
                objeto_usuario.setEstado("conectado");
                objeto_usuario.setExperto(false);
                objeto_usuario.setRol("normal");
                objeto_usuario.setNombre(nombre);
                objeto_usuario.setApellidos(apellidos);
                objeto_usuario.setContrasenia(contrasenia);
                objeto_usuario.setFecha_nacimiento(fechaNacimiento);
                objeto_usuario.setCorreo(correo);
                objeto_usuario.setDescripcion("");
                objeto_usuario.setFoto(null);
                objeto_usuario.setUsuario_cambiado(false);

                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                if (umDAO.existeUsuario(objeto_usuario)) {
                    umDAO.cerrarConexion();
                    //Pasar datos a la vista
                    request.setAttribute("usuarioFallo", "Ya existe el usuario");
                    camposIntroducidos(request, nombre, apellidos, contrasenia, fecha_nacimiento);
                    request.setAttribute("correo", correo);
                    request.getRequestDispatcher("registro.jsp").forward(request, response);
                    return;
                } else if (umDAO.existeCorreo(objeto_usuario)) {
                    umDAO.cerrarConexion();
                    //Pasar datos a la vista
                    request.setAttribute("usuario", usuario);
                    camposIntroducidos(request, nombre, apellidos, contrasenia, fecha_nacimiento);
                    request.setAttribute("correoFallo", "No se puede repetir el correo");
                    request.getRequestDispatcher("registro.jsp").forward(request, response);
                    return;
                }

                umDAO.registrarUsuario(objeto_usuario);
                umDAO.cerrarConexion();
                response.sendRedirect("perfil.jsp");
                return;

            } else {
                response.sendRedirect("registro.jsp");
                return;
            }
        }
    }

    public void camposIntroducidos(HttpServletRequest request, String nombre,
            String apellidos, String contrasenia, String fecha_nacimiento) {
        request.setAttribute("nombre", nombre);
        request.setAttribute("apellidos", apellidos);
        request.setAttribute("contra", contrasenia);
        request.setAttribute("fecha", fecha_nacimiento);
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
            Logger.getLogger(Comprobar_registro_de_usuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Comprobar_registro_de_usuario.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Comprobar_registro_de_usuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Comprobar_registro_de_usuario.class.getName()).log(Level.SEVERE, null, ex);
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
