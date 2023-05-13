/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Funciones;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import modelo.Amigos;
import modelo.DAO.AmigoModeloDAO;
import modelo.DAO.NotificacionModeloDAO;
import modelo.DAO.UsuarioModeloDAO;
import modelo.Usuario;

/**
 *
 * @author Juancarlos
 */
public class FuncionesAmigos {

    //Funcion que carga las notificaciones del usuario
    public static void funcionPrepararNotificacion(HttpServletRequest request) {
        //Seguir controlando la sesión del usuario
        // Obtener la sesion
        HttpSession session = request.getSession(false);
        // Obtener el usuario de la sesión
        Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");

        //Lista de amigos
        //Lista de peticiones de amistad
        NotificacionModeloDAO nmDAO = new NotificacionModeloDAO();
        //Obtener ids de todos los usuarios que quieren ser amigos
        List<Integer> idUsuariosSolicitantes = new ArrayList<>();
        idUsuariosSolicitantes = nmDAO.listaDeIdSolicitantes(objetoSesion);
        nmDAO.cerrarConexion();
        //Obtener lista de los usuarios solicitantes
        UsuarioModeloDAO umDAO = new UsuarioModeloDAO();
        List<Usuario> listaUsuariosSolicitantes = new ArrayList<>();
        listaUsuariosSolicitantes = umDAO.listaDeUsuariosMedianteId(idUsuariosSolicitantes);
        umDAO.cerrarConexion();
        request.setAttribute("listaUsuariosSolicitantes", listaUsuariosSolicitantes);
    }

    //Función que carga todos los amigos del usuario
    public static void preparaTodosAmigos(HttpServletRequest request) {
        //Seguir controlando la sesión del usuario
        // Obtener la sesion
        HttpSession session = request.getSession(false);
        // Obtener el usuario de la sesión
        Usuario objetoSesion = (Usuario) session.getAttribute("datosUsuario");
        
        //Crear lista con todos los amigos
        List<Usuario> usuariosAmigos = new ArrayList<>();
        AmigoModeloDAO amDAO = new AmigoModeloDAO();
        usuariosAmigos = amDAO.listaAmigos(objetoSesion.getId_usuario());
        amDAO.cerrarConexion();
        request.setAttribute("listaUsuariosAmigos", usuariosAmigos);
    }
}
