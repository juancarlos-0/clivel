/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Juancarlos
 */
public class Juego {

    private int id_juego;
    private String nombre;
    private String fechaLanzamiento;
    private int numeroComentarios;

    public Juego() {
    }

    public Juego(int id_juego, String nombre, String fechaLanzamiento, int numeroComentarios) {
        this.id_juego = id_juego;
        this.nombre = nombre;
        this.fechaLanzamiento = fechaLanzamiento;
        this.numeroComentarios = numeroComentarios;
    }

    public int getId_juego() {
        return id_juego;
    }

    public void setId_juego(int id_juego) {
        this.id_juego = id_juego;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFechaLanzamiento() {
        return fechaLanzamiento;
    }

    public void setFechaLanzamiento(String fechaLanzamiento) {
        this.fechaLanzamiento = fechaLanzamiento;
    }

    public int getNumeroComentarios() {
        return numeroComentarios;
    }

    public void setNumeroComentarios(int numeroComentarios) {
        this.numeroComentarios = numeroComentarios;
    }

}
