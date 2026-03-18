<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="logic.ATSLogic, logic.Candidato, java.util.*, java.io.InputStream" %>
<%
    // ── Inicializar sesión de candidatos ──────────────────────────────────
    if (session.getAttribute("candidatos") == null) {
        session.setAttribute("candidatos", new ArrayList<Candidato>());
    }

    @SuppressWarnings("unchecked")
    List<Candidato> candidatos = (List<Candidato>) session.getAttribute("candidatos");

    // ── Vaciar base de datos ──────────────────────────────────────────────
    if ("1".equals(request.getParameter("limpiar"))) {
        candidatos.clear();
        response.sendRedirect("index.jsp");
        return;
    }

    String mensajeError = null;

    // ── Procesar registro de candidato ────────────────────────────────────
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("registrar") != null) {
        String nombre = request.getParameter("nombre");
        String email  = request.getParameter("email");

        // Leer PDF con Apache PDFBox
        Part filePart = request.getPart("cv_pdf");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream is = filePart.getInputStream()) {
                // PDFBox se usa dentro de ATSLogic, no en el JSP
                Candidato c = ATSLogic.procesarCVDesdeStream(nombre, email, is);
                candidatos.add(c);
                candidatos.sort((a, b) -> b.getScore() - a.getScore());
                session.setAttribute("candidatos", candidatos);
            } catch (Exception e) {
                mensajeError = "Error procesando el PDF: " + e.getMessage();
            }
        } else {
            mensajeError = "Debes subir un archivo PDF.";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS — Sistema de Reclutamiento</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;600&family=Syne:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="CSS/styles.css">
</head>
<body>
<div class="wrapper">

    <!-- ══ HEADER ══════════════════════════════════════════════════════════ -->
    <header class="header-main">
        <div class="header-inner">
            <div class="header-label">ATS / Sistema de Reclutamiento</div>
            <h1><%=ATSLogic.VACANTE_TITULO%></h1>
            <div class="keywords-row">
                <span class="kw-label">Keywords requeridas:</span>
                <% for (String k : ATSLogic.KEYWORDS_PESO.keySet()) { %>
                    <span class="keywords-tag"><%=k%></span>
                <% } %>
            </div>
        </div>
    </header>

    <main class="content">

        <!-- ══ FORMULARIO ══════════════════════════════════════════════════ -->
        <section class="panel">
            <h2>Registro de Candidato</h2>

            <% if (mensajeError != null) { %>
                <div class="alert-error">⚠ <%=mensajeError%></div>
            <% } %>

            <form method="POST" enctype="multipart/form-data" action="index.jsp">
                <div class="form-group">
                    <label for="nombre">Nombre Completo</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Ej. María García López" required>
                </div>
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" placeholder="correo@empresa.com" required>
                </div>
                <div class="form-group">
                    <label for="cv_pdf">Subir CV (PDF)</label>
                    <div class="file-drop">
                        <input type="file" id="cv_pdf" name="cv_pdf" accept="application/pdf" required>
                        <span class="file-hint">Selecciona o arrastra tu PDF aquí</span>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" name="registrar" class="btn btn-primary">
                        Procesar y Clasificar
                    </button>
                    <a href="?limpiar=1"
                       onclick="return confirm('¿Vaciar toda la base de datos de candidatos?')">
                        <button type="button" class="btn btn-outline">Vaciar BD</button>
                    </a>
                </div>
            </form>
        </section>

        <!-- ══ TABLA DE RESULTADOS ══════════════════════════════════════════ -->
        <section class="results">
            <div class="results-header">
                <h2>Candidatos Clasificados</h2>
                <span class="badge-count"><%=candidatos.size()%> registros</span>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Candidato</th>
                            <th>Match Score</th>
                            <th>Tecnologías Detectadas</th>
                            <th>Fecha Registro</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (candidatos.isEmpty()) { %>
                        <tr>
                            <td colspan="5" class="empty-state">
                                <div class="empty-icon">📋</div>
                                No hay candidatos registrados aún.
                            </td>
                        </tr>
                    <% } else {
                           for (int i = 0; i < candidatos.size(); i++) {
                               Candidato c = candidatos.get(i);
                    %>
                        <tr class="row-animate">
                            <td class="col-rank">#<%=i + 1%></td>
                            <td class="col-name">
                                <strong><%=escapeHtml(c.getNombre())%></strong>
                                <small><%=escapeHtml(c.getEmail())%></small>
                            </td>
                            <td class="col-score">
                                <span class="score-pill <%=c.getRankClass()%>">
                                    <%=c.getScore()%>%
                                </span>
                                <div class="score-bar">
                                    <div class="score-fill <%=c.getRankClass()%>"
                                         style="width:<%=c.getScore()%>%"></div>
                                </div>
                            </td>
                            <td class="col-kw">
                                <% for (String kw : c.getKeywords().split(", ")) { %>
                                    <% if (!kw.equals("—")) { %>
                                        <span class="kw-chip"><%=kw.trim()%></span>
                                    <% } else { %>
                                        <span class="kw-none">—</span>
                                    <% } %>
                                <% } %>
                            </td>
                            <td class="col-date"><%=c.getFecha()%></td>
                        </tr>
                    <%   }
                       } %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<%!
    /** Escapa caracteres HTML para evitar XSS — equivalente a htmlspecialchars() en PHP */
    private String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&",  "&amp;")
                .replace("<",  "&lt;")
                .replace(">",  "&gt;")
                .replace("\"", "&quot;")
                .replace("'",  "&#39;");
    }
%>
</body>
</html>
