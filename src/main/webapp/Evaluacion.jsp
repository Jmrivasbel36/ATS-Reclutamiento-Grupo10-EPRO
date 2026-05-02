<%--
    Document   : evaluacion
    Persistence: atsEproGrupo10PU
    Entidades  : Evaluacion, Candidato, Usuario
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="
    logic.Evaluacion,
    logic.Candidato,
    logic.Usuario,
    jakarta.persistence.*,
    java.time.LocalDateTime,
    java.time.format.DateTimeFormatter,
    java.util.List
"%>
<%!
    /* ── Persistence Unit ──────────────────────────────────────────────── */
    private static final String PU = "atsEproGrupo10PU";
    private static final DateTimeFormatter FMT =
        DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;")
                .replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;");
    }
    private String nivelClass(int p) {
        return p >= 70 ? "alto" : p >= 40 ? "medio" : "bajo";
    }
%>
<%
    /* ════════════════════════════════════════════════════════════════════
       Variables de estado
       ════════════════════════════════════════════════════════════════════ */
    String mensajeError = null;
    String mensajeExito = null;

    EntityManagerFactory emf = null;
    EntityManager em         = null;

    try {
        emf = Persistence.createEntityManagerFactory(PU);
        em  = emf.createEntityManager();

        /* ── ELIMINAR evaluación ────────────────────────────────────────── */
        String paramEliminar = request.getParameter("eliminar");
        if (paramEliminar != null) {
            int elimId = Integer.parseInt(paramEliminar);
            em.getTransaction().begin();
            Evaluacion toDelete = em.find(Evaluacion.class, elimId);
            if (toDelete != null) em.remove(toDelete);
            em.getTransaction().commit();
            response.sendRedirect("Evaluacion.jsp");
            return;
        }

        /* ── REGISTRAR evaluación (POST) ────────────────────────────────── */
        if ("POST".equalsIgnoreCase(request.getMethod())
                && request.getParameter("evaluar") != null) {

            String puntajeStr   = request.getParameter("puntaje");
            String comentario   = request.getParameter("comentario");
            String idCandidatoS = request.getParameter("idCandidato");
            String idUsuarioS   = request.getParameter("idUsuario");

            /* Validación básica */
            if (puntajeStr == null || puntajeStr.isBlank()
             || comentario == null || comentario.isBlank()
             || idCandidatoS == null || idCandidatoS.isBlank()
             || idUsuarioS   == null || idUsuarioS.isBlank()) {
                mensajeError = "Todos los campos son obligatorios.";
            } else {
                int puntaje = Integer.parseInt(puntajeStr);
                if (puntaje < 0 || puntaje > 100) {
                    mensajeError = "El puntaje debe estar entre 0 y 100.";
                } else {
                    Candidato candidato = em.find(Candidato.class,
                                                  Integer.parseInt(idCandidatoS));
                    Usuario   usuario   = em.find(Usuario.class,
                                                  Integer.parseInt(idUsuarioS));

                    if (candidato == null) {
                        mensajeError = "El candidato seleccionado no existe en la BD.";
                    } else if (usuario == null) {
                        mensajeError = "El entrevistador seleccionado no existe en la BD.";
                    } else {
                        Evaluacion ev = new Evaluacion();
                        ev.setPuntaje(puntaje);
                        ev.setComentario(comentario.trim());
                        ev.setFecha(LocalDateTime.now());
                        ev.setCandidato(candidato);
                        ev.setUsuario(usuario);

                        em.getTransaction().begin();
                        em.persist(ev);
                        em.getTransaction().commit();
                        mensajeExito = "Evaluación registrada correctamente.";
                    }
                }
            }
        }

        /* ── CONSULTAS para poblar la vista ─────────────────────────────── */
        List<Candidato> candidatos = em.createQuery(
            "SELECT c FROM Candidato c ORDER BY c.nombre", Candidato.class)
            .getResultList();

        List<Usuario> usuarios = em.createQuery(
            "SELECT u FROM Usuario u ORDER BY u.username", Usuario.class)
            .getResultList();

        List<Evaluacion> evaluaciones = em.createQuery(
            "SELECT e FROM Evaluacion e " +
            "LEFT JOIN FETCH e.candidato " +
            "LEFT JOIN FETCH e.usuario " +
            "ORDER BY e.fecha DESC", Evaluacion.class)
            .getResultList();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS — Evaluación de Candidatos</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;600&family=Syne:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* ── Reset & Variables ─────────────────────────────────────────── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg:         #FFF;
            --surface:    #FFF;
            --surface-2:  #FFF;
            --border:     #7699e0;
            --accent:     #b1b1c7;
            --accent-2:   #0a59f6;
            --danger:     #ff4f6a;
            --warning:    #ffb347;
            --text:       #000;
            --text-muted: #000;
            --font-head:  'Syne', sans-serif;
            --font-mono:  'IBM Plex Mono', monospace;
            --radius:     10px;
        }
        body {
            background: var(--bg);
            color: var(--text);
            font-family: var(--font-mono);
            font-size: 14px;
            min-height: 100vh;
        }

        /* ── Layout ─────────────────────────────────────────────────────── */
        .wrapper { max-width: 1280px; margin: 0 auto; padding: 0 24px 60px; }

        /* ── Header ─────────────────────────────────────────────────────── */
        .header-main {
            border-bottom: 1px solid var(--border);
            padding: 32px 0 24px; margin-bottom: 36px;
            position: relative;
        }
        .header-main::before {
            content: ''; position: absolute; bottom: -1px; left: 0;
            width: 80px; height: 2px;
            background: linear-gradient(90deg, var(--accent), var(--accent-2));
        }
        .header-label {
            font-size: 11px; letter-spacing: .18em;
            text-transform: uppercase; color: var(--accent); margin-bottom: 8px;
        }
        .header-main h1 {
            font-family: var(--font-head);
            font-size: clamp(22px, 4vw, 34px);
            font-weight: 800; line-height: 1.1;
        }
        .header-main h1 span { color: var(--accent-2); }
        .nav-back {
            display: inline-flex; align-items: center; gap: 6px;
            margin-top: 14px; font-size: 12px;
            color: var(--text-muted); text-decoration: none;
            transition: color .2s;
        }
        .nav-back:hover { color: var(--accent); }

        /* ── Grid ───────────────────────────────────────────────────────── */
        .grid-layout {
            display: grid;
            grid-template-columns: 400px 1fr;
            gap: 28px; align-items: start;
        }
        @media (max-width: 900px) { .grid-layout { grid-template-columns: 1fr; } }

        /* ── Panel base ─────────────────────────────────────────────────── */
        .panel {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius); padding: 28px;
        }
        .panel h2 {
            font-family: var(--font-head);
            font-size: 16px; font-weight: 700;
            margin-bottom: 22px; padding-bottom: 14px;
            border-bottom: 1px solid var(--border);
            display: flex; align-items: center; gap: 8px;
        }
        .panel h2 .icon {
            width: 28px; height: 28px;
            background: var(--surface-2);
            border: 1px solid var(--border); border-radius: 6px;
            display: inline-flex; align-items: center; justify-content: center;
            font-size: 14px;
        }

        /* ── Formulario ─────────────────────────────────────────────────── */
        .form-group { margin-bottom: 16px; }
        .form-group label {
            display: block; font-size: 11px; letter-spacing: .12em;
            text-transform: uppercase; color: var(--text-muted); margin-bottom: 6px;
        }
        .form-group select,
        .form-group input,
        .form-group textarea {
            width: 100%; background: var(--surface-2);
            border: 1px solid var(--border); border-radius: 6px;
            color: var(--text); font-family: var(--font-mono); font-size: 13px;
            padding: 10px 12px; outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        .form-group select:focus,
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79,124,255,.15);
        }
        .form-group select option { background: var(--surface-2); }
        .form-group textarea { resize: vertical; min-height: 110px; line-height: 1.5; }

        /* Puntaje */
        .score-input-wrap { position: relative; }
        .score-input-wrap input { padding-right: 42px; }
        .score-suffix {
            position: absolute; right: 12px; top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted); font-size: 12px; pointer-events: none;
        }
        input[type="range"] {
            -webkit-appearance: none; width: 100%; height: 4px;
            background: var(--border); border-radius: 2px;
            border: none; padding: 0; margin-top: 8px;
        }
        input[type="range"]::-webkit-slider-thumb {
            -webkit-appearance: none; width: 16px; height: 16px;
            border-radius: 50%; background: var(--accent); cursor: pointer;
            box-shadow: 0 0 0 3px rgba(79,124,255,.25);
        }
        .score-level {
            display: inline-block; margin-top: 6px;
            font-size: 11px; padding: 2px 8px; border-radius: 20px;
        }
        .level-alto  { background: rgba(0,229,195,.12); color: var(--accent-2); }
        .level-medio { background: rgba(255,179,71,.12); color: var(--warning); }
        .level-bajo  { background: rgba(255,79,106,.12); color: var(--danger); }

        .section-hint {
            font-size: 11px; color: var(--text-muted); line-height: 1.5;
            margin-bottom: 18px; padding: 10px 12px;
            background: var(--surface-2); border-radius: 6px;
            border-left: 3px solid var(--accent);
        }
        .divider { border: none; border-top: 1px solid var(--border); margin: 18px 0; }

        .alert {
            border-radius: 6px; padding: 10px 14px; font-size: 12px;
            margin-bottom: 16px; display: flex; align-items: center; gap: 8px;
        }
        .alert-error   { background: rgba(255,79,106,.1); border: 1px solid rgba(255,79,106,.3); color: #ff7a8a; }
        .alert-success { background: rgba(0,229,195,.1);  border: 1px solid rgba(0,229,195,.3);  color: var(--accent-2); }

        .form-actions { display: flex; gap: 10px; margin-top: 20px; flex-wrap: wrap; }
        .btn {
            padding: 10px 20px; border: none; border-radius: 6px;
            font-family: var(--font-mono); font-size: 13px; font-weight: 600;
            cursor: pointer; transition: all .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-primary { background: var(--accent); color: #fff; flex: 1; justify-content: center; }
        .btn-primary:hover { background: #3d6aff; transform: translateY(-1px); }
        .btn-outline { background: transparent; border: 1px solid var(--border); color: var(--text-muted); }
        .btn-outline:hover { border-color: var(--danger); color: var(--danger); }
        .btn-icon { background: transparent; border: 1px solid var(--border); color: var(--text-muted); padding: 5px 10px; font-size: 11px; }
        .btn-icon:hover { border-color: var(--danger); color: var(--danger); }

        /* ── Tabla ──────────────────────────────────────────────────────── */
        .results-panel {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: var(--radius); overflow: hidden;
        }
        .results-header {
            padding: 22px 28px 18px; border-bottom: 1px solid var(--border);
            display: flex; align-items: center;
            justify-content: space-between; flex-wrap: wrap; gap: 10px;
        }
        .results-header h2 {
            font-family: var(--font-head); font-size: 16px; font-weight: 700;
            display: flex; align-items: center; gap: 8px;
        }
        .badge-count {
            background: var(--surface-2); border: 1px solid var(--border);
            border-radius: 20px; padding: 3px 12px;
            font-size: 11px; color: var(--text-muted);
        }
        .table-wrapper { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        thead tr { background: var(--surface-2); border-bottom: 1px solid var(--border); }
        th {
            padding: 11px 16px; text-align: left; font-size: 10px;
            letter-spacing: .14em; text-transform: uppercase;
            color: var(--text-muted); white-space: nowrap;
        }
        td { padding: 13px 16px; border-bottom: 1px solid var(--border); vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tbody tr { transition: background .15s; }
        tbody tr:hover { background: rgba(79,124,255,.04); }

        .col-id    { color: var(--text-muted); font-size: 12px; }
        .col-fecha { color: var(--text-muted); font-size: 11px; white-space: nowrap; }
        .col-comentario { max-width: 240px; font-size: 12px; line-height: 1.45; color: #c4c8db; }
        .col-name strong { display: block; font-size: 13px; }
        .col-name small  { color: var(--text-muted); font-size: 11px; }

        .score-pill {
            display: inline-flex; align-items: center; justify-content: center;
            width: 48px; height: 28px; border-radius: 6px;
            font-size: 13px; font-weight: 600;
        }
        .score-pill.alto  { background: rgba(0,229,195,.15); color: var(--accent-2); }
        .score-pill.medio { background: rgba(255,179,71,.15); color: var(--warning); }
        .score-pill.bajo  { background: rgba(255,79,106,.15); color: var(--danger); }

        .empty-state { text-align: center; padding: 52px 20px; color: var(--text-muted); }
        .empty-state .empty-icon { font-size: 36px; margin-bottom: 10px; }
        .empty-state p { font-size: 13px; }
    </style>
</head>
<body>
<div class="wrapper">

    <!-- ══ HEADER ══════════════════════════════════════════════════════════ -->
    <header class="header-main">
        <div class="header-label">ATS / Módulo de Evaluación</div>
        <h1>Evaluación de <span>Candidatos</span></h1>
        <a href="index.jsp" class="nav-back">
            <i class="fas fa-arrow-left"></i> Volver al listado de vacantes
        </a>
    </header>

    <div class="grid-layout">

        <!-- ══ PANEL: FORMULARIO DEL ENTREVISTADOR ════════════════════════ -->
        <aside class="panel">
            <h2><span class="icon">✍</span> Registrar Evaluación</h2>

            <% if (mensajeError != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> <%=esc(mensajeError)%>
                </div>
            <% } %>
            <% if (mensajeExito != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%=esc(mensajeExito)%>
                </div>
            <% } %>

            <div class="section-hint">
                Selecciona el candidato entrevistado, el entrevistador responsable,
                asigna un puntaje y deja tus observaciones.
            </div>

            <form method="POST" action="Evaluacion.jsp">

                <!-- Candidato → FK idCandidato -->
                <div class="form-group">
                    <label for="idCandidato">Candidato</label>
                    <select id="idCandidato" name="idCandidato" required>
                        <option value="">— Seleccionar candidato —</option>
                        <% for (Candidato c : candidatos) { %>
                            <option value="<%=c.getIdCandidato()%>">
                                #<%=c.getIdCandidato()%> — <%=esc(c.getNombre())%>
                                &lt;<%=esc(c.getEmail())%>&gt;
                            </option>
                        <% } %>
                    </select>
                </div>

                <!-- Usuario → FK idUsuario -->
                <div class="form-group">
                    <label for="idUsuario">Entrevistador</label>
                    <select id="idUsuario" name="idUsuario" required>
                        <option value="">— Seleccionar entrevistador —</option>
                        <% for (Usuario u : usuarios) { %>
                            <option value="<%=u.getIdUsuario()%>">
                                <%=esc(u.getUsername())%>
                                (<%=u.getRol() != null ? esc(u.getRol().name()) : ""%>)
                            </option>
                        <% } %>
                    </select>
                </div>

                <hr class="divider">

                <!-- Puntaje -->
                <div class="form-group">
                    <label for="puntaje">Puntaje de Evaluación</label>
                    <div class="score-input-wrap">
                        <input type="number" id="puntaje" name="puntaje"
                               placeholder="0 – 100" min="0" max="100"
                               oninput="syncSlider(this.value)" required>
                        <span class="score-suffix">/ 100</span>
                    </div>
                    <input type="range" id="scoreRange" min="0" max="100" value="50"
                           oninput="document.getElementById('puntaje').value=this.value;
                                    syncSlider(this.value)">
                    <span class="score-level level-medio" id="scoreLevel">
                        Nivel: Medio (50)
                    </span>
                </div>

                <!-- Comentario -->
                <div class="form-group">
                    <label for="comentario">Comentario del Entrevistador</label>
                    <textarea id="comentario" name="comentario"
                              placeholder="Describe fortalezas, áreas de mejora e impresión general del candidato…"
                              required></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" name="evaluar" class="btn btn-primary">
                        <i class="fas fa-save"></i> Guardar Evaluación
                    </button>
                    <button type="reset" class="btn btn-outline"
                            onclick="syncSlider(50)">Limpiar</button>
                </div>
            </form>
        </aside>

        <!-- ══ TABLA evaluacion ════════════════════════════════════════════ -->
        <section class="results-panel">
            <div class="results-header">
                <h2>
                    <i class="fas fa-table" style="color:var(--accent);font-size:14px;"></i>
                    Tabla <code style="color:var(--accent-2);font-size:13px;">evaluacion</code>
                </h2>
                <span class="badge-count"><%=evaluaciones.size()%> registros</span>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>idEvaluacion</th>
                            <th>puntaje</th>
                            <th>comentario</th>
                            <th>fecha</th>
                            <th>idCandidato</th>
                            <th>idUsuario</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (evaluaciones.isEmpty()) { %>
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <div class="empty-icon">🗂️</div>
                                    <p>No hay evaluaciones registradas aún.<br>
                                       Usa el formulario para agregar la primera.</p>
                                </div>
                            </td>
                        </tr>
                    <% } else {
                           for (Evaluacion ev : evaluaciones) {
                               String lvl   = nivelClass(ev.getPuntaje());
                               String fecha = ev.getFecha() != null
                                             ? ev.getFecha().format(FMT) : "—";
                               Candidato evCand = ev.getCandidato();
                               Usuario   evUser = ev.getUsuario();
                    %>
                        <tr>
                            <!-- idEvaluacion -->
                            <td class="col-id">#<%=ev.getIdEvaluacion()%></td>

                            <!-- puntaje -->
                            <td>
                                <span class="score-pill <%=lvl%>">
                                    <%=ev.getPuntaje()%>
                                </span>
                            </td>

                            <!-- comentario -->
                            <td class="col-comentario"><%=esc(ev.getComentario())%></td>

                            <!-- fecha -->
                            <td class="col-fecha"><%=fecha%></td>

                            <!-- idCandidato (FK → nombre) -->
                            <td class="col-name">
                                <% if (evCand != null) { %>
                                    <strong><%=esc(evCand.getNombre())%></strong>
                                    <small>#<%=evCand.getIdCandidato()%></small>
                                <% } else { %>
                                    <span style="color:var(--text-muted)">—</span>
                                <% } %>
                            </td>

                            <!-- idUsuario (FK → username) -->
                            <td class="col-name">
                                <% if (evUser != null) { %>
                                    <strong><%=esc(evUser.getUsername())%></strong>
                                    <small>#<%=evUser.getIdUsuario()%></small>
                                <% } else { %>
                                    <span style="color:var(--text-muted)">—</span>
                                <% } %>
                            </td>

                            <!-- Eliminar -->
                            <td>
                                <a href="Evaluacion.jsp?eliminar=<%=ev.getIdEvaluacion()%>"
                                   onclick="return confirm('¿Eliminar evaluación #<%=ev.getIdEvaluacion()%>?')">
                                    <button type="button" class="btn btn-icon">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </a>
                            </td>
                        </tr>
                    <%   }
                       } %>
                    </tbody>
                </table>
            </div>
        </section>

    </div><!-- /grid-layout -->
</div><!-- /wrapper -->

<script>
    function syncSlider(val) {
        val = parseInt(val) || 0;
        document.getElementById('scoreRange').value = val;
        const el = document.getElementById('scoreLevel');
        if (val >= 70) {
            el.className = 'score-level level-alto';
            el.textContent = 'Nivel: Alto (' + val + ')';
        } else if (val >= 40) {
            el.className = 'score-level level-medio';
            el.textContent = 'Nivel: Medio (' + val + ')';
        } else {
            el.className = 'score-level level-bajo';
            el.textContent = 'Nivel: Bajo (' + val + ')';
        }
    }
    syncSlider(50);
</script>

<%
    } catch (Exception ex) {
        if (em != null && em.getTransaction().isActive()) {
            em.getTransaction().rollback();
        }
        out.println(
            "<div style='color:#ff4f6a;padding:28px;font-family:monospace;" +
            "background:#1a0a0d;border:1px solid #ff4f6a;border-radius:8px;margin:24px;'>" +
            "<strong>&#10060; Error de persistencia:</strong><br><br>" +
            esc(ex.getClass().getName()) + ": " + esc(ex.getMessage()) +
            "</div>"
        );
    } finally {
        if (em  != null && em.isOpen())  em.close();
        if (emf != null && emf.isOpen()) emf.close();
    }
%>
</body>
</html>
