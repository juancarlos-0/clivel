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
    
    private int id_valoracion;
    private int id_juego;
    private int id_usuario;
    private String comentario;
    private String opinion;
    private Date fecha_valoracion;
    private String imagenUsuario;
    private String nombreUsuario;
    private int likes;
    private int dislikes;
    private int id_like;
    private String opinionSesion;

    public Valoracion() {
    }

    public Valoracion(int id_valoracion, int id_juego, int id_usuario, String comentario, String opinion, Date fecha_valoracion, String imagenUsuario, String nombreUsuario, int likes, int dislikes, int id_like, String opinionSesion) {
        this.id_valoracion = id_valoracion;
        this.id_juego = id_juego;
        this.id_usuario = id_usuario;
        this.comentario = comentario;
        this.opinion = opinion;
        this.fecha_valoracion = fecha_valoracion;
        this.imagenUsuario = imagenUsuario;
        this.nombreUsuario = nombreUsuario;
        this.likes = likes;
        this.dislikes = dislikes;
        this.id_like = id_like;
        this.opinionSesion = opinionSesion;
    }

    public int getId_valoracion() {
        return id_valoracion;
    }

    public void setId_valoracion(int id_valoracion) {
        this.id_valoracion = id_valoracion;
    }

    public int getId_juego() {
        return id_juego;
    }

    public void setId_juego(int id_juego) {
        this.id_juego = id_juego;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public Date getFecha_valoracion() {
        return fecha_valoracion;
    }

    public void setFecha_valoracion(Date fecha_valoracion) {
        this.fecha_valoracion = fecha_valoracion;
    }

    public String getImagenUsuario() {
        return imagenUsuario;
    }

    public void setImagenUsuario(String imagenUsuario) {
        this.imagenUsuario = imagenUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    } 

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }

    public int getId_like() {
        return id_like;
    }

    public void setId_like(int id_like) {
        this.id_like = id_like;
    }

    public String getIdUsuarioSesion() {
        return opinionSesion;
    }

    public void setIdUsuarioSesion(String opinionSesion) {
        this.opinionSesion = opinionSesion;
    }
    
}
