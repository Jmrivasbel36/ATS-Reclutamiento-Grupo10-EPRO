package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logic.Controladora;
import logic.RolUsuario;
import logic.Usuario;

@WebServlet(name = "svUsuario", urlPatterns = {"/login", "/registro", "/logout"})
public class svUsuario extends HttpServlet {

    Controladora ctrl = new Controladora();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // GET /login o /registro → solo redirige al JSP
        if ("/registro".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/registro.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // ── REGISTRO ─────────────────────────────────────────────────────────
        if ("/registro".equals(path)) {
            String username = request.getParameter("usuario").trim();
            String password = request.getParameter("clave");
            String rolStr   = request.getParameter("rol");

            try {
                RolUsuario rol = RolUsuario.valueOf(rolStr);
                ctrl.RegistrarUsuario(username, password, rol);
                // Redirige al login con mensaje de éxito
                response.sendRedirect(request.getContextPath() + "/login.jsp?registrado=1");
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Rol inválido.");
                request.getRequestDispatcher("/registro.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("/registro.jsp").forward(request, response);
            }
            return;
        }

        // ── LOGIN ─────────────────────────────────────────────────────────────
        String username = request.getParameter("usuario").trim();
        String password = request.getParameter("clave");

        Usuario u = ctrl.Login(username, password);

        if (u == null) {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Guardar usuario en sesión
        HttpSession session = request.getSession();
        session.setAttribute("usuarioActivo", u);
        session.setAttribute("rolActivo",     u.getRol().name());

        // Redirigir según rol
        if (u.getRol() == RolUsuario.RRHH) {
            response.sendRedirect(request.getContextPath() + "/svVacante");
        } else {
            response.sendRedirect(request.getContextPath() + "/entrevistador.jsp");
        }
    }
}