package com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "vacante")
public class Vacante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idVacante")
    private Integer idVacante;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "area", nullable = false, length = 100)
    private String area;

    @Column(name = "salario", nullable = false)
    private Double salario;

    @Column(name = "descripcion", nullable = false, columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "estado", nullable = false)
    private String estado;

    public Vacante() {
    }

    public Integer getIdVacante() {
        return idVacante;
    }

    public void setIdVacante(Integer idVacante) {
        this.idVacante = idVacante;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Double getSalario() {
        return salario;
    }

    public void setSalario(Double salario) {
        this.salario = salario;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}