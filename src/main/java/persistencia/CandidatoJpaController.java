package persistencia;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import java.io.Serializable;
import java.util.List;
import logic.Candidato;
import persistencia.exceptions.NonexistentEntityException;

public class CandidatoJpaController implements Serializable {

    private EntityManagerFactory emf;

    /** Constructor sin args — crea su propio EMF igual que VacanteJpaController */
    public CandidatoJpaController() {
        emf = Persistence.createEntityManagerFactory("atsEproGrupo10PU");
    }

    public CandidatoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // ── CREATE ────────────────────────────────────────────────────────────
    public void create(Candidato candidato) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            // Adjuntar la Vacante al contexto de persistencia para evitar
            // "detached entity passed to persist"
            if (candidato.getVacante() != null
                    && candidato.getVacante().getIdVacante() != null) {
                candidato.setVacante(
                    em.getReference(logic.Vacante.class,
                                    candidato.getVacante().getIdVacante()));
            }
            em.persist(candidato);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    // ── EDIT ──────────────────────────────────────────────────────────────
    public void edit(Candidato candidato) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            candidato = em.merge(candidato);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                if (findCandidato(candidato.getIdCandidato()) == null) {
                    throw new NonexistentEntityException(
                        "El candidato con id " + candidato.getIdCandidato() + " no existe.");
                }
            }
            throw ex;
        } finally {
            if (em != null) em.close();
        }
    }

    // ── DESTROY ───────────────────────────────────────────────────────────
    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Candidato candidato;
            try {
                candidato = em.getReference(Candidato.class, id);
                candidato.getIdCandidato(); // fuerza carga para detectar si existe
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException(
                    "El candidato con id " + id + " no existe.", enfe);
            }
            em.remove(candidato);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    // ── FIND ALL ──────────────────────────────────────────────────────────
    public List<Candidato> findCandidatoEntities() {
        return findCandidatoEntities(true, -1, -1);
    }

    public List<Candidato> findCandidatoEntities(int maxResults, int firstResult) {
        return findCandidatoEntities(false, maxResults, firstResult);
    }

    private List<Candidato> findCandidatoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Candidato.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    // ── FIND BY ID ────────────────────────────────────────────────────────
    public Candidato findCandidato(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Candidato.class, id);
        } finally {
            em.close();
        }
    }

    // ── COUNT ─────────────────────────────────────────────────────────────
    public int getCandidatoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Candidato> rt = cq.from(Candidato.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}