<%--
    Document   : index
    Popover de aplicación → persiste Candidato en BD via svCandidato
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%
    /* ── Leer mensajes de sesión dejados por svCandidato ────────────────── */
    String popoverError  = (String) session.getAttribute("popoverError");
    String popoverExito  = (String) session.getAttribute("popoverExito");
    String vacanteAplicada = (String) session.getAttribute("vacanteAplicada");
    if (vacanteAplicada == null) vacanteAplicada = "";

    /* Limpiar mensajes después de leerlos (patrón POST-Redirect-GET) */
    session.removeAttribute("popoverError");
    session.removeAttribute("popoverExito");
    session.removeAttribute("vacanteAplicada");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS | Grupo 10</title>
    <link rel="stylesheet" href="./CSS/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* ══ Popover Overlay ═════════════════════════════════════════════ */
        #popoverAplicar {
            border: none; padding: 0; background: transparent;
            position: fixed; inset: 0; margin: auto;
            width: 100%; height: 100%;
            max-width: 100%; max-height: 100%;
            display: flex; align-items: center; justify-content: center;
            background: rgba(8,10,18,0.72);
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            z-index: 9999;
        }
        #popoverAplicar:not(:popover-open) { display: none; }

        .popover-card {
            background: #ffffff; border-radius: 20px;
            padding: 40px 44px; width: 100%; max-width: 520px;
            box-shadow: 0 32px 64px rgba(0,0,0,.28), 0 0 0 1px rgba(255,255,255,.06);
            position: relative;
            animation: slideUp .3s cubic-bezier(.16,1,.3,1);
            font-family: 'Outfit', sans-serif;
        }
        @keyframes slideUp {
            from { opacity:0; transform:translateY(24px) scale(.97); }
            to   { opacity:1; transform:translateY(0)    scale(1); }
        }

        .pop-header {
            display: flex; align-items: flex-start;
            justify-content: space-between; margin-bottom: 6px;
        }
        .pop-badge {
            display: inline-flex; align-items: center; gap: 6px;
            background: #eff6ff; color: #1d4ed8;
            font-size: 11px; font-weight: 600; letter-spacing: .08em;
            text-transform: uppercase; padding: 5px 12px;
            border-radius: 20px; margin-bottom: 10px;
        }
        .pop-badge i { font-size: 9px; }
        .pop-title { font-size: 22px; font-weight: 700; color: #0f172a; line-height: 1.25; margin-bottom: 4px; }
        .pop-sub   { font-size: 13px; color: #64748b; margin-bottom: 28px; }
        .pop-sub strong { color: #1e40af; }

        .btn-close-pop {
            background: #f1f5f9; border: none;
            width: 34px; height: 34px; border-radius: 50%;
            cursor: pointer; font-size: 16px; color: #64748b;
            display: flex; align-items: center; justify-content: center;
            transition: background .2s, color .2s;
            flex-shrink: 0; margin-left: 12px;
        }
        .btn-close-pop:hover { background: #fee2e2; color: #dc2626; }

        .pop-form .fgroup { margin-bottom: 18px; }
        .pop-form label {
            display: block; font-size: 12px; font-weight: 600;
            color: #374151; margin-bottom: 6px; letter-spacing: .04em;
        }
        .pop-form label span { color: #ef4444; }
        .pop-form input {
            width: 100%; padding: 11px 14px;
            border: 1.5px solid #e2e8f0; border-radius: 10px;
            font-family: 'Outfit', sans-serif; font-size: 14px;
            color: #0f172a; background: #f8fafc; outline: none;
            transition: border-color .2s, box-shadow .2s, background .2s;
        }
        .pop-form input:focus {
            border-color: #3b82f6; background: #fff;
            box-shadow: 0 0 0 4px rgba(59,130,246,.12);
        }
        .pop-form input::placeholder { color: #94a3b8; }

        .cv-input-wrap { position: relative; }
        .cv-input-wrap i {
            position: absolute; left: 13px; top: 50%;
            transform: translateY(-50%);
            color: #94a3b8; font-size: 13px; pointer-events: none;
        }
        .cv-input-wrap input { padding-left: 36px; }

        .pop-alert {
            border-radius: 10px; padding: 11px 14px; font-size: 13px;
            margin-bottom: 18px; display: flex; align-items: center; gap: 8px;
        }
        .pop-alert-err { background:#fef2f2; border:1px solid #fca5a5; color:#dc2626; }
        .pop-alert-ok  { background:#f0fdf4; border:1px solid #86efac; color:#16a34a; }

        .pop-divider { border:none; border-top:1px solid #f1f5f9; margin:20px 0; }
        .pop-footer  { display: flex; gap: 10px; }
        .pop-footer .btn-cancel {
            flex: 1; background: #f1f5f9; border: none; padding: 12px;
            border-radius: 10px; font-family: 'Outfit', sans-serif;
            font-size: 14px; font-weight: 600; color: #64748b;
            cursor: pointer; transition: background .2s;
        }
        .pop-footer .btn-cancel:hover { background: #e2e8f0; }
        .pop-footer .btn-submit {
            flex: 2; background: linear-gradient(135deg,#2563eb,#1d4ed8);
            border: none; padding: 12px 20px; border-radius: 10px;
            font-family: 'Outfit', sans-serif; font-size: 14px; font-weight: 700;
            color: #fff; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            box-shadow: 0 4px 14px rgba(37,99,235,.35);
            transition: transform .15s, box-shadow .15s;
        }
        .pop-footer .btn-submit:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(37,99,235,.45);
        }

        /* Éxito */
        .pop-success { text-align: center; padding: 16px 0 8px; }
        .pop-success .check-circle {
            width: 64px; height: 64px;
            background: linear-gradient(135deg,#22c55e,#16a34a);
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; font-size: 28px; color:#fff;
            margin: 0 auto 18px;
            box-shadow: 0 8px 24px rgba(34,197,94,.3);
        }
        .pop-success h3 { font-size:20px; font-weight:700; color:#0f172a; margin-bottom:8px; }
        .pop-success p  { font-size:14px; color:#64748b; line-height:1.5; margin-bottom:24px; }
        .btn-close-success {
            background: #0f172a; color: #fff; border: none;
            padding: 12px 32px; border-radius: 10px;
            font-family: 'Outfit', sans-serif; font-size: 14px; font-weight: 700;
            cursor: pointer; transition: background .2s;
        }
        .btn-close-success:hover { background: #1e293b; }
    </style>
</head>
<body>

    <!-- ══ HEADER ══════════════════════════════════════════════════════════ -->
    <header>
        <div class="container">
            <div class="logo">
                <h1><i class="fas fa-briefcase"></i> ATS | Grupo 10</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="svVacante" class="active">Home</a></li>
                    <li><a href="./Vacantes.jsp">Publicar Trabajos</a></li>
                    <li><a href="./Evaluacion.jsp">Candidatos</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <a href="./login.jsp" class="btn btn-outline">Inicia Sesión</a>
                <a class="btn btn-primary">Registrar</a>
            </div>
        </div>
    </header>

    <!-- ══ HERO ════════════════════════════════════════════════════════════ -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1>Sistema De Gestión De Candidatos</h1>
                <p>Vacantes, pipeline de candidatos, evaluación, notas, adjuntos y reportes. Incluye roles.</p>
                <div class="search-box">
                    <div class="search-group">
                        <i class="fas fa-search"></i>
                        <input type="text" id="job-search" placeholder="Título, palabras clave o empresa">
                    </div>
                    <div class="search-group">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" id="location-search" placeholder="Ciudad, estado o remoto">
                    </div>
                    <button class="btn btn-primary search-btn">Buscar</button>
                </div>
            </div>
        </div>
    </section>

    <!-- ══ LISTADO DE VACANTES ═════════════════════════════════════════════ -->
    <section class="job-listings">
        <div class="container">

            <div class="filters-panel">
                <h3>Filtros</h3>
                <div class="filter-group">
                    <h4>Tipo de trabajo</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="job-type" value="full-time"> Tiempo completo</label>
                        <label><input type="checkbox" name="job-type" value="part-time"> Medio tiempo</label>
                        <label><input type="checkbox" name="job-type" value="contract"> Contrato</label>
                        <label><input type="checkbox" name="job-type" value="internship"> Pasantía</label>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Nivel de experiencia</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="experience" value="entry"> Junior</label>
                        <label><input type="checkbox" name="experience" value="mid"> Semi Senior</label>
                        <label><input type="checkbox" name="experience" value="senior"> Senior</label>
                        <label><input type="checkbox" name="experience" value="executive"> Ejecutivo</label>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Rango Salarial</h4>
                    <div class="range-slider">
                        <input type="range" min="30000" max="200000" value="30000" class="slider" id="salary-range">
                        <span id="salary-value">$30,000+</span>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Modalidad</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="remote" value="remote"> Remoto</label>
                        <label><input type="checkbox" name="remote" value="hybrid"> Híbrido</label>
                        <label><input type="checkbox" name="remote" value="onsite"> Presencial</label>
                    </div>
                </div>
                <button class="btn btn-outline btn-block">Limpiar Filtros</button>
            </div>

            <div class="jobs-container">
                <div class="jobs-header">
                    <h2>Vacantes Disponibles
                        <span id="job-count">
                            (<c:out value="${empty sessionScope.listaVacantes ? 0 : sessionScope.listaVacantes.size()}"/>)
                        </span>
                    </h2>
                    <div class="sort-options">
                        <label for="sort-by">Ordenar por:</label>
                        <select id="sort-by">
                            <option value="relevance">Relevancia</option>
                            <option value="recent">Más reciente</option>
                            <option value="salary-high">Salario (Mayor a Menor)</option>
                            <option value="salary-low">Salario (Menor a Mayor)</option>
                        </select>
                    </div>
                </div>

                <div id="jobs-list">
                    <c:choose>
                        <c:when test="${empty sessionScope.listaVacantes}">
                            <div style="text-align:center;padding:60px 20px;color:#888;">
                                <i class="fas fa-briefcase" style="font-size:48px;margin-bottom:16px;display:block;"></i>
                                <p>No hay vacantes disponibles en este momento.</p>
                                <a href="./Vacantes.jsp" class="btn btn-primary" style="margin-top:12px;">
                                    Publicar primera vacante
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="v" items="${sessionScope.listaVacantes}">
                                <div class="job-card">
                                    <div class="job-card-header">
                                        <div class="company-logo">
                                            <i class="fas fa-briefcase"></i>
                                        </div>
                                        <div class="job-info">
                                            <h3 class="job-title"><c:out value="${v.nombre}"/></h3>
                                            <p class="company-name">
                                                <i class="fas fa-layer-group"></i>
                                                <c:out value="${v.area}"/>
                                            </p>
                                        </div>
                                        <span class="job-type-badge">
                                            <c:choose>
                                                <c:when test="${v.estado == 'Activa'}">
                                                    <span style="background:#d1fae5;color:#065f46;padding:4px 10px;border-radius:20px;font-size:12px;font-weight:600;">
                                                        <i class="fas fa-circle" style="font-size:8px;"></i> Activa
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#fee2e2;color:#991b1b;padding:4px 10px;border-radius:20px;font-size:12px;font-weight:600;">
                                                        <i class="fas fa-circle" style="font-size:8px;"></i>
                                                        <c:out value="${v.estado}"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="job-description">
                                        <p><c:out value="${v.descripcion}"/></p>
                                    </div>
                                    <div class="job-footer">
                                        <div class="job-tags">
                                            <span class="tag">
                                                <i class="fas fa-dollar-sign"></i>
                                                <fmt:formatNumber value="${v.salario}" type="number"
                                                    minFractionDigits="2" maxFractionDigits="2"/>
                                            </span>
                                        </div>
                                        <button class="btn btn-outline apply-btn"
                                                onclick="abrirPopover('<c:out value="${v.nombre}"/>', '<c:out value="${v.idVacante}"/>')">
                                            Aplicar
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="pagination">
                    <button class="pagination-btn"><i class="fas fa-chevron-left"></i></button>
                    <button class="pagination-btn"><i class="fas fa-chevron-right"></i></button>
                </div>
            </div>
        </div>
    </section>

    <!-- ══ POPOVER — FORMULARIO DE APLICACIÓN ═════════════════════════════ -->
    <div id="popoverAplicar" popover>
        <div class="popover-card">

            <%-- ── Estado ÉXITO ──────────────────────────────────────────── --%>
            <% if (popoverExito != null) { %>
            <div class="pop-success">
                <div class="check-circle"><i class="fas fa-check"></i></div>
                <h3>¡Postulación enviada!</h3>
                <p><%=popoverExito%><br>Revisa tu correo electrónico para más información.</p>
                <button class="btn-close-success"
                        onclick="document.getElementById('popoverAplicar').hidePopover()">
                    Cerrar
                </button>
            </div>

            <%-- ── Formulario (normal / con error) ──────────────────────── --%>
            <% } else { %>
            <div class="pop-header">
                <div>
                    <div class="pop-badge">
                        <i class="fas fa-circle"></i> Vacante activa
                    </div>
                    <h2 class="pop-title">Aplicar a esta vacante</h2>
                    <p class="pop-sub">Postúlate a <strong id="pop-vacante-nombre">la vacante</strong></p>
                </div>
                <button class="btn-close-pop"
                        onclick="document.getElementById('popoverAplicar').hidePopover()"
                        title="Cerrar">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <% if (popoverError != null) { %>
                <div class="pop-alert pop-alert-err">
                    <i class="fas fa-exclamation-circle"></i> <%=popoverError%>
                </div>
            <% } %>

            <%-- ▸ action → svCandidato (servlet JPA) --%>
            <form method="POST" action="svCandidato" class="pop-form" id="formAplicar">
                <input type="hidden" name="accion"    value="aplicar">
                <input type="hidden" name="idVacante" id="hiddenIdVacante" value="<%=vacanteAplicada%>">

                <%-- nombre --%>
                <div class="fgroup">
                    <label for="pop-nombre">Nombre completo <span>*</span></label>
                    <input type="text" id="pop-nombre" name="nombre"
                           placeholder="Ej. María García López"
                           required autocomplete="name">
                </div>

                <%-- email --%>
                <div class="fgroup">
                    <label for="pop-email">Correo electrónico <span>*</span></label>
                    <input type="email" id="pop-email" name="email"
                           placeholder="correo@ejemplo.com"
                           required autocomplete="email">
                </div>

                <%-- cvRuta --%>
                <div class="fgroup">
                    <label for="pop-cv">Enlace a tu CV (PDF) <span>*</span></label>
                    <div class="cv-input-wrap">
                        <i class="fas fa-link"></i>
                        <input type="url" id="pop-cv" name="cvRuta"
                               placeholder="https://drive.google.com/tu-cv.pdf"
                               required>
                    </div>
                </div>

                <%-- estadoPipeline: campo informativo (no editable por el candidato) --%>
                <div class="fgroup" style="font-size:11px;color:#94a3b8;
                     background:#f8fafc;border-radius:8px;padding:8px 12px;
                     border:1px dashed #e2e8f0;">
                    <i class="fas fa-info-circle" style="color:#3b82f6;"></i>
                    El estado del pipeline (<strong>APLICO → FILTRO → ENTREVISTA → PRUEBA → OFERTA</strong>)
                    será gestionado por el equipo de reclutamiento.
                </div>

                <hr class="pop-divider">

                <div class="pop-footer">
                    <button type="button" class="btn-cancel"
                            onclick="document.getElementById('popoverAplicar').hidePopover()">
                        Cancelar
                    </button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> Enviar postulación
                    </button>
                </div>
            </form>
            <% } %>

        </div>
    </div>

    <!-- ══ SCRIPTS ════════════════════════════════════════════════════════ -->
    <script>
        /* Salary slider */
        const salaryRange = document.getElementById('salary-range');
        const salaryValue = document.getElementById('salary-value');
        if (salaryRange) {
            salaryRange.addEventListener('input', () => {
                salaryValue.textContent = '$' + Number(salaryRange.value).toLocaleString() + '+';
            });
        }

        /* Abrir popover con contexto de la vacante */
        function abrirPopover(nombreVacante, idVacante) {
            const pop = document.getElementById('popoverAplicar');
            const el  = document.getElementById('pop-vacante-nombre');
            const hid = document.getElementById('hiddenIdVacante');
            if (el)  el.textContent = nombreVacante || 'la vacante';
            if (hid) hid.value      = idVacante     || '';
            pop.showPopover();
        }

        /* Reabrir popover si svCandidato redirigió con error o éxito */
        <% if (popoverError != null || popoverExito != null) { %>
        window.addEventListener('DOMContentLoaded', () => {
            document.getElementById('popoverAplicar').showPopover();
        });
        <% } %>
    </script>
</body>
</html>
