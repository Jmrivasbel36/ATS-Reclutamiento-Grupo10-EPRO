package logic;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Candidato {
    private String nombre;
    private String email;
    private int score;
    private String keywords;
    private String fecha;

    public Candidato(String nombre, String email, int score, String keywords) {
        this.nombre = nombre;
        this.email = email;
        this.score = score;
        this.keywords = keywords;
        this.fecha = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public String getNombre()   { return nombre; }
    public String getEmail()    { return email; }
    public int    getScore()    { return score; }
    public String getKeywords() { return keywords; }
    public String getFecha()    { return fecha; }

    public String getRankClass() {
        if (score >= 75) return "rank-high";
        if (score >= 40) return "rank-mid";
        return "rank-low";
    }
}
