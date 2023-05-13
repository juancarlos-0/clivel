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
public class Mensaje {
    
    private int id_mensaje;
    private Usuario usuario;
    private String tipo;
    private String mensaje_texto;
    private byte[] mensaje_binario;
    private Date fecha_envio;
    private boolean visto;

    public Mensaje() {
    }

    public int getId_mensaje() {
        return id_mensaje;
    }

    public void setId_mensaje(int id_mensaje) {
        this.id_mensaje = id_mensaje;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getMensaje_texto() {
        return mensaje_texto;
    }

    public void setMensaje_texto(String mensaje_texto) {
        this.mensaje_texto = mensaje_texto;
    }

    public byte[] getMensaje_binario() {
        return mensaje_binario;
    }

    public void setMensaje_binario(byte[] mensaje_binario) {
        this.mensaje_binario = mensaje_binario;
    }

    public Date getFecha_envio() {
        return fecha_envio;
    }

    public void setFecha_envio(Date fecha_envio) {
        this.fecha_envio = fecha_envio;
    }

    public boolean isVisto() {
        return visto;
    }

    public void setVisto(boolean visto) {
        this.visto = visto;
    }
    
    
}
