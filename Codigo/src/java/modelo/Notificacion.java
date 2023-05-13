/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Juancarlos
 */
public class Notificacion {
    
    private int id_usuario;
    private int id_usuario_notificacion;
    private String estado;

    public Notificacion() {
    }

    public Notificacion(int id_usuario, int id_usuario_notificacion, String estado) {
        this.id_usuario = id_usuario;
        this.id_usuario_notificacion = id_usuario_notificacion;
        this.estado = estado;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_usuario_notificacion() {
        return id_usuario_notificacion;
    }

    public void setId_usuario_notificacion(int id_usuario_notificacion) {
        this.id_usuario_notificacion = id_usuario_notificacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
