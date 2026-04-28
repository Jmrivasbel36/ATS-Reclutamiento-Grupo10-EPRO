package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import logic.Controladora;
import logic.Vacante;

@WebServlet(name = "svVacante", urlPatterns = {"/svVacante"})
public class svVacante extends HttpServlet {

    Controladora ctrl = new Controladora();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vacante> listaVacantes = ctrl.TraerVacante();
        System.out.println(">>> Vacantes encontradas: " + listaVacantes.size());
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaVacantes", listaVacantes);
        response.sendRedirect("Vacantes.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            switch (accion != null ? accion : "") {

                case "editar": {
                    int id             = Integer.parseInt(request.getParameter("idVacante"));
                    String nombre      = request.getParameter("nombre");
                    String area        = request.getParameter("area");
                    double salario     = Double.parseDouble(request.getParameter("Salario"));
                    String descripcion = request.getParameter("descripcion");
                    String estado      = request.getParameter("estado");

                    Vacante vacan = new Vacante();
                    vacan.setIdVacante(id);
                    vacan.setNombre(nombre);
                    vacan.setArea(area);
                    vacan.setSalario(salario);
                    vacan.setDescripcion(descripcion);
                    vacan.setEstado(estado);

                    ctrl.EditarVacante(vacan);
                    break;
                }

                case "eliminar": {
                    int id = Integer.parseInt(request.getParameter("idVacante"));
                    ctrl.EliminarVacante(id);
                    break;
                }

                default: {
                    // Crear nueva vacante
                    String nombre      = request.getParameter("nombre");
                    String area        = request.getParameter("area");
                    double salario     = Double.parseDouble(request.getParameter("Salario"));
                    String descripcion = request.getParameter("descripcion");
                    String estado      = request.getParameter("estado");

                    Vacante vacan = new Vacante();
                    vacan.setNombre(nombre);
                    vacan.setArea(area);
                    vacan.setSalario(salario);
                    vacan.setDescripcion(descripcion);
                    vacan.setEstado(estado);

                    ctrl.CrearVacante(vacan);
                    break;
                }
            }
        } catch (Exception e) {
            System.err.println("Error en svVacante [" + accion + "]: " + e.getMessage());
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para gestión de vacantes";
    }
}
