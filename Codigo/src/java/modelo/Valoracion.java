/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Date;

/**
 *
 * @author Juancarlos
 */
public class Valoracion {
    
    private Juego id_juego;
    private String comentario;
    private int puntuacion;
    private Usuario usuario;
    private Date fecha_valoracion;

    public Valoracion() {
    }

    public Juego getId_juego() {
        return id_juego;
    }

    public void setId_juego(Juego id_juego) {
        this.id_juego = id_juego;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) {
        this.puntuacion = puntuacion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Date getFecha_valoracion() {
        return fecha_valoracion;
    }

    public void setFecha_valoracion(Date fecha_valoracion) {
        this.fecha_valoracion = fecha_valoracion;
    }

    
    
    
}
