/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.Date;

/**
 *
 * @author Juancarlos
 */
public class Usuario {
    
    private int id_usuario;
    private String usuario;
    private String contrasenia;
    private String nombre;
    private String apellidos;
    private String correo;
    private Date fecha_nacimiento;
    private String foto;
    private String descripcion;
    private String rol;
    private boolean experto;
    private String estado;
    private boolean usuario_cambiado;

    public Usuario() {
    }

    public Usuario(int id_usuario, String usuario, String contrasenia, String nombre, String apellidos, String correo, Date fecha_nacimiento, String foto, String descripcion, String rol, boolean experto, String estado, boolean usuario_cambiado) {
        this.id_usuario = id_usuario;
        this.usuario = usuario;
        this.contrasenia = contrasenia;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.correo = correo;
        this.fecha_nacimiento = fecha_nacimiento;
        this.foto = foto;
        this.descripcion = descripcion;
        this.rol = rol;
        this.experto = experto;
        this.estado = estado;
        this.usuario_cambiado = usuario_cambiado;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public boolean isExperto() {
        return experto;
    }

    public void setExperto(boolean experto) {
        this.experto = experto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean isUsuario_cambiado() {
        return usuario_cambiado;
    }

    public void setUsuario_cambiado(boolean usuario_cambiado) {
        this.usuario_cambiado = usuario_cambiado;
    }

   
    
    
    
}
