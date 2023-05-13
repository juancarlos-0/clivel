/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import static Funciones.FuncionesAmigos.funcionPrepararNotificacion;
import static Funciones.FuncionesAmigos.preparaTodosAmigos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.DAO.AmigoModeloDAO;
import modelo.DAO.NotificacionModeloDAO;
import modelo.DAO.UsuarioModeloDAO;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
@WebServlet(name = "Controlador_amigos", urlPatterns = {"/Controlador_amigos"})
public class Controlador_amigos extends HttpServlet {

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
            String botonAgregarAmigo = request.getParameter("botonAgregarAmigo");
            String botonAceptarAmigo = request.getParameter("aceptarAmigo");
            String botonRechazarAmigo = request.getParameter("rechazarAmigo");
            String botonEliminarAmigo = request.getParameter("botonEliminarAmigo");
            String botonIrAChat = request.getParameter("botonIrAChat");

            //Agregar las notificaciones
            funcionPrepararNotificacion(request);

            //funcion que crea una lista con todos los amigos
            preparaTodosAmigos(request);

            // Obtener la sesion
            HttpSession session = request.getSession(false);

            //Control del botón de agregar un amigo
            if (botonAgregarAmigo != null) {
                String usuarioAgregar = request.getParameter("nombre-amigo");
                //Compruebo que el nombre introducido no este vacio
                if (usuarioAgregar.isBlank()) {
                    String mensajeError = "Debe introducir un nombre";
                    request.setAttribute("mensajeError", mensajeError);
                    //Agregar las notificaciones
                    funcionPrepararNotificacion(request);
                    //funcion que crea una lista con todos los amigos
                    preparaTodosAmigos(request);
                    request.getRequestDispatcher("amigos.jsp").forward(request, response);
                    return;
                } else {
                    //Compruebo si el usuario existe en la base de datos
                    Usuario u = new Usuario();
                    u.setUsuario(usuarioAgregar);
                    UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                    boolean existeUsuario = umDAO.existeUsuario(u);
                    if (!existeUsuario) {
                        String mensajeError = "No existe el usuario";
                        request.setAttribute("mensajeError", mensajeError);
                        umDAO.cerrarConexion();
                        //Agregar las notificaciones
                        funcionPrepararNotificacion(request);
                        //funcion que crea una lista con todos los amigos
                        preparaTodosAmigos(request);
                        request.getRequestDispatcher("amigos.jsp").forward(request, response);
                        return;
                    } else {
                        // Obtener el usuario de la sesión
                        Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
                        if (u.getUsuario().equals(objetoSesion.getUsuario())) {
                            //Si el usuario coincide con el suyo propio no puede agregarse
                            request.setAttribute("mensajeError", "No puedes agregarte!");
                            //Agregar las notificaciones
                            funcionPrepararNotificacion(request);
                            //funcion que crea una lista con todos los amigos
                            preparaTodosAmigos(request);
                            request.getRequestDispatcher("amigos.jsp").forward(request, response);
                            return;
                        } else {
                            // id del usuario que mandara la solicitud
                            int idUsuarioSesion = objetoSesion.getId_usuario();
                            //Comprobar que el usuario sea amigo
                            NotificacionModeloDAO nmDAO = new NotificacionModeloDAO();
                            //Obtener el id del usuario que se quiere agregar
                            UsuarioModeloDAO umdao2 = new UsuarioModeloDAO();
                            int idUsuarioAgregar = umdao2.idUsuario(usuarioAgregar);
                            umdao2.cerrarConexion();
                            boolean aceptada1 = nmDAO.compruebaSolicitudAceptada(objetoSesion.getId_usuario(), idUsuarioAgregar);
                            boolean aceptada2 = nmDAO.compruebaSolicitudAceptada(idUsuarioAgregar, objetoSesion.getId_usuario());
                            nmDAO.cerrarConexion();
                            if (aceptada1 || aceptada2) {
                                request.setAttribute("mensajeError", "Ya está agregado");
                                //Agregar las notificaciones
                                funcionPrepararNotificacion(request);
                                //funcion que crea una lista con todos los amigos
                                preparaTodosAmigos(request);
                                request.getRequestDispatcher("amigos.jsp").forward(request, response);
                                return;
                            } else {
                                //Si existe el usuario entonces se le enviará una solicitud para aceptar
                                int idUsuarioANotificar = umDAO.idUsuario(usuarioAgregar);
                                umDAO.cerrarConexion();
                                NotificacionModeloDAO nmDAO2 = new NotificacionModeloDAO();
                                nmDAO2.enviarSolicitudAmistad(idUsuarioSesion, idUsuarioANotificar);
                                nmDAO2.cerrarConexion();
                                //Volver a la página y lanzar un mensaje de que todo está correcto
                                request.setAttribute("correcto", "esCorrecto");
                                //Agregar las notificaciones
                                funcionPrepararNotificacion(request);
                                //funcion que crea una lista con todos los amigos
                                preparaTodosAmigos(request);
                                request.getRequestDispatcher("amigos.jsp").forward(request, response);
                                return;
                            }
                        }
                    }
                }
            }

            //Controlador para aceptar amigo
            if (botonAceptarAmigo != null) {
                String id_cadena = request.getParameter("id_usuario");
                int nuevoAmigo = Integer.parseInt(id_cadena);
                //Guardar amigo en la tabla
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
                AmigoModeloDAO amDAO = new AmigoModeloDAO();
                amDAO.agregarAmigo(nuevoAmigo, objetoSesion.getId_usuario());
                amDAO.agregarAmigo(objetoSesion.getId_usuario(), nuevoAmigo);
                amDAO.cerrarConexion();
                //Aceptar en notificaciones la solicitud
                NotificacionModeloDAO nmDAO = new NotificacionModeloDAO();
                nmDAO.aceptarSolicitud(nuevoAmigo, objetoSesion.getId_usuario());
                nmDAO.aceptarSolicitud(objetoSesion.getId_usuario(), nuevoAmigo);
                request.setAttribute("abrirNotificaciones", "abrirNotificaciones");
                //Agregar las notificaciones
                funcionPrepararNotificacion(request);
                //funcion que crea una lista con todos los amigos
                preparaTodosAmigos(request);
                request.getRequestDispatcher("amigos.jsp").forward(request, response);
                return;
            }

            //Controlador para rechazar amigo
            if (botonRechazarAmigo != null) {
                //Datos usuario rechazado
                String id_cadena = request.getParameter("id_usuario");
                int idRechazar = Integer.parseInt(id_cadena);
                //Datos usuario actual
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
                //Denegar solicitud
                NotificacionModeloDAO nmDAO = new NotificacionModeloDAO();
                nmDAO.rechazarSolicitud(idRechazar, objetoSesion.getId_usuario());
                nmDAO.rechazarSolicitud(objetoSesion.getId_usuario(), idRechazar);
                nmDAO.cerrarConexion();
                //Agregar las notificaciones
                funcionPrepararNotificacion(request);
                //funcion que crea una lista con todos los amigos
                preparaTodosAmigos(request);
                request.getRequestDispatcher("amigos.jsp").forward(request, response);
                return;
            }

            //Controla el eliminar a un amigo
            if (botonEliminarAmigo != null) {
                //Obtener el nombre del amigo
                String amigoEliminar = request.getParameter("nombre-amigo-eliminar");
                //Comprobar que haya introducido un valor
                if (amigoEliminar.isBlank()) {
                    request.setAttribute("eliminarAmigoFallo", "No puede dejar el campo vacío");
                    //Agregar las notificaciones
                    funcionPrepararNotificacion(request);
                    //funcion que crea una lista con todos los amigos
                    preparaTodosAmigos(request);
                    request.getRequestDispatcher("amigos.jsp").forward(request, response);
                    return;
                }
                //Obtener el id del amigo
                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                int id_usuario_eliminar = umDAO.idUsuario(amigoEliminar);
                umDAO.cerrarConexion();
                // Obtener el usuario de la sesión
                Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
                //Comprobar si son amigos los usuarios
                AmigoModeloDAO amDAO = new AmigoModeloDAO();
                boolean existeAmistad = amDAO.compruebaAmistad(id_usuario_eliminar, objetoSesion.getId_usuario());
                amDAO.cerrarConexion();
                if (!existeAmistad) {
                    request.setAttribute("eliminarAmigoFallo", "No tiene agregado al usuario");
                    //Agregar las notificaciones
                    funcionPrepararNotificacion(request);
                    //funcion que crea una lista con todos los amigos
                    preparaTodosAmigos(request);
                    request.getRequestDispatcher("amigos.jsp").forward(request, response);
                    return;
                } else {
                    //Eliminar amistad
                    AmigoModeloDAO amDAO2 = new AmigoModeloDAO();
                    amDAO2.eliminarAmistad(id_usuario_eliminar, objetoSesion.getId_usuario());
                    amDAO2.cerrarConexion();
                    //Eliminar datos de notificaciones
                    NotificacionModeloDAO nmDAO = new NotificacionModeloDAO();
                    nmDAO.rechazarSolicitud(id_usuario_eliminar, objetoSesion.getId_usuario());
                    nmDAO.rechazarSolicitud(objetoSesion.getId_usuario(), id_usuario_eliminar);
                    //Agregar las notificaciones
                    funcionPrepararNotificacion(request);
                    //funcion que crea una lista con todos los amigos
                    preparaTodosAmigos(request);
                    request.getRequestDispatcher("amigos.jsp").forward(request, response);
                    return;
                }
            }

            if (botonIrAChat != null) {
                //Agregar las notificaciones
                funcionPrepararNotificacion(request);

                //funcion que crea una lista con todos los amigos
                preparaTodosAmigos(request);
                
                //Recoger el nombre del usuario
                String nombre_usuario_chat = request.getParameter("nombre_usuario_chat");
                Usuario u = new Usuario();
                //Recoger datos del usuario
                UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
                u = umDAO.devolverDatos(nombre_usuario_chat);
                umDAO.cerrarConexion();
                //Devolver los datos del usuario
                request.setAttribute("usuario_chat", u);
                

                //Reenviar a la página de amigos
                request.getRequestDispatcher("amigos.jsp").forward(request, response);
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
