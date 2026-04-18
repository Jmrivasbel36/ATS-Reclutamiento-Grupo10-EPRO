package com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "candidato")
public class Candidato implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCandidato")
    private Integer idCandidato;

    @Column(name = "nombre", nullable = false, length = 120)
    private String nombre;

    @Column(name = "email", nullable = false, length = 120)
    private String email;

    @Column(name = "fechaRegistro", nullable = false)
    private LocalDateTime fechaRegistro;

    @Enumerated(EnumType.STRING)
    @Column(name = "estadoPipeline", nullable = false)
    private EstadoPipeline estadoPipeline;

    @Column(name = "cvRuta", length = 255)
    private String cvRuta;

    @ManyToOne(optional = false)
    @JoinColumn(name = "idVacante", nullable = false)
    private Vacante vacante;

    public Candidato() {
    }

    public Candidato(String nombre, String email, LocalDateTime fechaRegistro,
                     EstadoPipeline estadoPipeline, String cvRuta, Vacante vacante) {
        this.nombre = nombre;
        this.email = email;
        this.fechaRegistro = fechaRegistro;
        this.estadoPipeline = estadoPipeline;
        this.cvRuta = cvRuta;
        this.vacante = vacante;
    }

    public Integer getIdCandidato() {
        return idCandidato;
    }

    public void setIdCandidato(Integer idCandidato) {
        this.idCandidato = idCandidato;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public EstadoPipeline getEstadoPipeline() {
        return estadoPipeline;
    }

    public void setEstadoPipeline(EstadoPipeline estadoPipeline) {
        this.estadoPipeline = estadoPipeline;
    }

    public String getCvRuta() {
        return cvRuta;
    }

    public void setCvRuta(String cvRuta) {
        this.cvRuta = cvRuta;
    }

    public Vacante getVacante() {
        return vacante;
    }

    public void setVacante(Vacante vacante) {
        this.vacante = vacante;
    }
}