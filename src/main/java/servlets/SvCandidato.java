package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import logic.Candidato;
import logic.EstadoPipeline;
import logic.Vacante;
import persistencia.CandidatoJpaController;
import persistencia.VacanteJpaController;

@WebServlet(name = "SvCandidato", urlPatterns = {"/svCandidato"})
public class SvCandidato extends HttpServlet {

    private final CandidatoJpaController candidatoJpa = new CandidatoJpaController();
    private final VacanteJpaController   vacanteJpa   = new VacanteJpaController();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        if (!"aplicar".equals(accion)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String nombre       = request.getParameter("nombre");
        String email        = request.getParameter("email");
        String cvRuta       = request.getParameter("cvRuta");
        String idVacanteStr = request.getParameter("idVacante");

        // ── Validación ────────────────────────────────────────────────────
        if (nombre == null || nombre.isBlank()
         || email  == null || email.isBlank()
         || cvRuta == null || cvRuta.isBlank()
         || idVacanteStr == null || idVacanteStr.isBlank()) {

            request.getSession().setAttribute("popoverError",
                "Todos los campos son obligatorios.");
            request.getSession().setAttribute("vacanteAplicada", idVacanteStr);
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            // ── Buscar la vacante FK ──────────────────────────────────────
            int idVacante = Integer.parseInt(idVacanteStr);
            Vacante vacante = vacanteJpa.findVacante(idVacante);

            if (vacante == null) {
                request.getSession().setAttribute("popoverError",
                    "La vacante seleccionada no existe.");
                response.sendRedirect("index.jsp");
                return;
            }

            // ── Construir y persistir el candidato ────────────────────────
            // estadoPipeline inicia en APLICO al postularse
            Candidato candidato = new Candidato(
                nombre.trim(),
                email.trim(),
                LocalDateTime.now(),
                EstadoPipeline.APLICO,   // valor inicial al aplicar
                cvRuta.trim(),
                vacante
            );

            candidatoJpa.create(candidato);

            // ── Éxito → guardar mensaje en sesión y redirigir ─────────────
            request.getSession().setAttribute("popoverExito",
                "¡Postulación enviada con éxito! Te contactaremos pronto.");
            request.getSession().removeAttribute("popoverError");

        } catch (Exception e) {
            System.err.println("Error en svCandidato: " + e.getMessage());
            request.getSession().setAttribute("popoverError",
                "Error al guardar la postulación: " + e.getMessage());
        }

        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}