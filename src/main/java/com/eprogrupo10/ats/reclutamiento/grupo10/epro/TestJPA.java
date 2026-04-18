package com.eprogrupo10.ats.reclutamiento.grupo10.epro;

import com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity.Candidato;
import com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity.EstadoPipeline;
import com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity.RolUsuario;
import com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity.Usuario;
import com.eprogrupo10.ats.reclutamiento.grupo10.epro.entity.Vacante;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.time.LocalDateTime;

public class TestJPA {

    public static void main(String[] args) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ATS_PU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            Usuario u = new Usuario("admin2", "123456", RolUsuario.RRHH);
            em.persist(u);

            Vacante v = new Vacante();
            v.setNombre("Desarrollador Java");
            v.setArea("Tecnología");
            v.setSalario(1200.00);
            v.setDescripcion("Vacante para desarrollador backend con conocimientos en Java y SQL");
            v.setEstado("ABIERTA");
            em.persist(v);

            Candidato c = new Candidato();
            c.setNombre("Juan Pérez");
            c.setEmail("juanperez@gmail.com");
            c.setFechaRegistro(LocalDateTime.now());
            c.setEstadoPipeline(EstadoPipeline.APLICO);
            c.setCvRuta("cv_juanperez.pdf");
            c.setVacante(v);
            em.persist(c);

            em.getTransaction().commit();

            System.out.println("Usuario, vacante y candidato guardados correctamente");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}