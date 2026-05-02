package logic;

import java.util.List;
import persistencia.ControladoraPersistencia;
import persistencia.exceptions.NonexistentEntityException;
import persistencia.exceptions.PreexistingEntityException;

public class Controladora {

    ControladoraPersistencia cp = new ControladoraPersistencia();

    // ── Vacante ──────────────────────────────────────────────────────────────
    public void CrearVacante(Vacante vacan)  { cp.CrearVacante(vacan); }
    public List<Vacante> TraerVacante()      { return cp.TraerVacante(); }
    public void EditarVacante(Vacante vacan) throws NonexistentEntityException, Exception {
        cp.EditarVacante(vacan);
    }
    public void EliminarVacante(Integer id) throws NonexistentEntityException {
        cp.EliminarVacante(id);
    }

    // ── Usuario ──────────────────────────────────────────────────────────────
    public void RegistrarUsuario(String username, String password, RolUsuario rol)
            throws PreexistingEntityException {
        // Guardamos el password en texto plano (sin hash por simplicidad)
        Usuario u = new Usuario(username, password, rol);
        cp.CrearUsuario(u);
    }

    // Retorna el Usuario si las credenciales son correctas, null si no
    public Usuario Login(String username, String password) {
        Usuario u = cp.BuscarUsuario(username);
        if (u == null) return null;
        // Comparación directa (password en texto plano)
        if (u.getPasswordHash().equals(password)) return u;
        return null;
    }

    public List<Usuario> TraerUsuarios() { return cp.TraerUsuarios(); }
}