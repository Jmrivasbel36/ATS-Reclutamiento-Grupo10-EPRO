/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import java.io.Serializable;
import jakarta.persistence.Query;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.Persistence;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import java.util.List;
import logic.Vacante;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class VacanteJpaController implements Serializable {

    public VacanteJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public VacanteJpaController(){
          emf = Persistence.createEntityManagerFactory("atsEproGrupo10PU");
    }

    public void create(Vacante vacante) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(vacante);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Vacante vacante) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            vacante = em.merge(vacante);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = vacante.getIdVacante();
                if (findVacante(id) == null) {
                    throw new NonexistentEntityException("The vacante with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Vacante vacante;
            try {
                vacante = em.getReference(Vacante.class, id);
                vacante.getIdVacante();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The vacante with id " + id + " no longer exists.", enfe);
            }
            em.remove(vacante);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Vacante> findVacanteEntities() {
        return findVacanteEntities(true, -1, -1);
    }

    public List<Vacante> findVacanteEntities(int maxResults, int firstResult) {
        return findVacanteEntities(false, maxResults, firstResult);
    }

    private List<Vacante> findVacanteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Vacante.class));
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

    public Vacante findVacante(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Vacante.class, id);
        } finally {
            em.close();
        }
    }

    public int getVacanteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Vacante> rt = cq.from(Vacante.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
