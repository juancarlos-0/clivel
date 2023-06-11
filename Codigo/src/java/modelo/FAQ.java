/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Juancarlos
 */
public class FAQ {
    private int id_FAQ;
    private String pregunta;
    private String respuesta;

    public FAQ() {
    }

    public FAQ(int id_FAQ, String pregunta, String respuesta) {
        this.id_FAQ = id_FAQ;
        this.pregunta = pregunta;
        this.respuesta = respuesta;
    }

    public int getId_FAQ() {
        return id_FAQ;
    }

    public void setId_FAQ(int id_FAQ) {
        this.id_FAQ = id_FAQ;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
    
    
}
