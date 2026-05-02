package persistencia;

import java.util.List;
import logic.Usuario;
import logic.Vacante;
import persistencia.exceptions.NonexistentEntityException;
import persistencia.exceptions.PreexistingEntityException;

public class ControladoraPersistencia {

    VacanteJpaController  vacanJpa  = new VacanteJpaController();
    UsuarioJpaController  usuarJpa  = new UsuarioJpaController();

    // ── Vacante ──────────────────────────────────────────────────────────────
    public void CrearVacante(Vacante vacan) { vacanJpa.create(vacan); }
    public List<Vacante> TraerVacante()     { return vacanJpa.findVacanteEntities(); }
    public void EditarVacante(Vacante vacan) throws NonexistentEntityException, Exception {
        vacanJpa.edit(vacan);
    }
    public void EliminarVacante(Integer id) throws NonexistentEntityException {
        vacanJpa.destroy(id);
    }

    // ── Usuario ──────────────────────────────────────────────────────────────
    public void CrearUsuario(Usuario u) throws PreexistingEntityException {
        if (usuarJpa.existeUsername(u.getUsername()))
            throw new PreexistingEntityException("El usuario '" + u.getUsername() + "' ya existe.");
        usuarJpa.create(u);
    }

    public Usuario BuscarUsuario(String username) {
        return usuarJpa.findByUsername(username);
    }

    public List<Usuario> TraerUsuarios() {
        return usuarJpa.findUsuarioEntities();
    }
}