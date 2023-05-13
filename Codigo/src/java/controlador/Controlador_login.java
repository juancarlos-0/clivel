/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.DAO.UsuarioModeloDAO;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
@WebServlet(name = "Controlador_login", urlPatterns = {"/Controlador_login"})
public class Controlador_login extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            //Controlar botones de registro e inicio de sesion
            String botonIniciaSesion = request.getParameter("inicia");
            String botonRegistro = request.getParameter("registro");

            //Obtener campos
            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");

            if (botonIniciaSesion != null) {
                //Crear objetos
                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                Usuario objetoUsuario = new Usuario();

                //Introducir datos en los objetos
                objetoUsuario.setUsuario(usuario);
                objetoUsuario.setContrasenia(contrasenia);

                if (!umDAO.existeUsuario(objetoUsuario)) {
                    //Si no existe el usuario se avisa en la vista
                    umDAO.cerrarConexion();
                    request.setAttribute("usuarioFallo", "No existe el usuario");
                    request.setAttribute("usuario", usuario);
                    request.setAttribute("contrasenia", contrasenia);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                } else if (!umDAO.contraUsuarioCoincide(objetoUsuario)) {
                    //Si la contraseña está mal introducida se avisa en la vista
                    umDAO.cerrarConexion();
                    request.setAttribute("contraFallo", "No es correcta la contraseña");
                    request.setAttribute("usuario", usuario);
                    request.setAttribute("contrasenia", contrasenia);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                } else {
                    //Crear un objeto con los datos del usuario el cual será una sesión
                    Usuario datosUsuario = new Usuario();
                    datosUsuario = umDAO.devolverDatos(usuario);
                    umDAO.cerrarConexion();
                    //Crear la sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("datosUsuario", datosUsuario);
                    //Redirigir a la página de perfil
                    request.getRequestDispatcher("perfil.jsp").forward(request, response);
                    return;
                }

            }

            if (botonRegistro != null) {
                response.sendRedirect("registro.jsp");
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
        } catch (SQLException ex) {
            Logger.getLogger(Controlador_login.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(Controlador_login.class.getName()).log(Level.SEVERE, null, ex);
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
