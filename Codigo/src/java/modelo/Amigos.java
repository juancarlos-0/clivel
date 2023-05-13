/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Juancarlos
 */
public class Amigos {
    
    private int id_usuario;
    private int id_usuario_amigo;

    public Amigos() {
    }

    public Amigos(int id_usuario, int id_usuario_amigo) {
        this.id_usuario = id_usuario;
        this.id_usuario_amigo = id_usuario_amigo;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_usuario_amigo() {
        return id_usuario_amigo;
    }

    public void setId_usuario_amigo(int id_usuario_amigo) {
        this.id_usuario_amigo = id_usuario_amigo;
    }
    
    
}
