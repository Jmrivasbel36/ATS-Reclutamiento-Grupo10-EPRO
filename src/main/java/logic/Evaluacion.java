package logic;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "evaluacion")
public class Evaluacion implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idEvaluacion")
    private Integer idEvaluacion;

    @Column(name = "puntaje", nullable = false)
    private Integer puntaje;

    @Column(name = "comentario", columnDefinition = "TEXT")
    private String comentario;

    @Column(name = "fecha", nullable = false)
    private LocalDateTime fecha;

    @ManyToOne(optional = false)
    @JoinColumn(name = "idCandidato", nullable = false)
    private Candidato candidato;

    @ManyToOne
    @JoinColumn(name = "idUsuario")
    private Usuario usuario;

    // ── Constructor vacío requerido por JPA ───────────────────────────────
    public Evaluacion() {
    }

    // ── Constructor completo (sin id, lo genera la BD) ────────────────────
    public Evaluacion(Integer puntaje, String comentario, LocalDateTime fecha,
                      Candidato candidato, Usuario usuario) {
        this.puntaje    = puntaje;
        this.comentario = comentario;
        this.fecha      = fecha;
        this.candidato  = candidato;
        this.usuario    = usuario;
    }

    // ── Getters ───────────────────────────────────────────────────────────
    public Integer      getIdEvaluacion() { return idEvaluacion; }
    public Integer      getPuntaje()      { return puntaje; }
    public String       getComentario()   { return comentario; }
    public LocalDateTime getFecha()       { return fecha; }
    public Candidato    getCandidato()    { return candidato; }
    public Usuario      getUsuario()      { return usuario; }

    // ── Setters ───────────────────────────────────────────────────────────
    public void setIdEvaluacion(Integer idEvaluacion) { this.idEvaluacion = idEvaluacion; }
    public void setPuntaje(Integer puntaje)           { this.puntaje = puntaje; }
    public void setComentario(String comentario)      { this.comentario = comentario; }
    public void setFecha(LocalDateTime fecha)         { this.fecha = fecha; }
    public void setCandidato(Candidato candidato)     { this.candidato = candidato; }
    public void setUsuario(Usuario usuario)           { this.usuario = usuario; }

    // ── Utilidad ──────────────────────────────────────────────────────────
    public String getNivelClass() {
        if (puntaje == null) return "bajo";
        if (puntaje >= 70)   return "alto";
        if (puntaje >= 40)   return "medio";
        return "bajo";
    }

    @Override
    public String toString() {
        return String.format(
            "Evaluacion{id=%d, puntaje=%d, candidato=%s, usuario=%s, fecha=%s}",
            idEvaluacion, puntaje,
            candidato != null ? candidato.getNombre() : "null",
            usuario   != null ? usuario.getUsername()  : "null",
            fecha
        );
    }
}