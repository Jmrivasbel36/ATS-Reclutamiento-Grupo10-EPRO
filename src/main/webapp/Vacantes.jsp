<%@page import="logic.Vacante"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Vacante> vacantes = (List<Vacante>) session.getAttribute("listaVacantes");
    String error = (String) request.getAttribute("error");
    String exito = (String) request.getAttribute("exito");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ATS — Gestión de Vacantes</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;600&family=Syne:wght@400;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/vacantes.css">
        <style>
            [popover] {
                border: none;
                border-radius: 16px;
                padding: 0;
                box-shadow: 0 20px 60px rgba(0,0,0,.25);
                width: min(520px, 95vw);
                background: #fff;
            }
            [popover]::backdrop {
                background: rgba(0,0,0,.45);
                backdrop-filter: blur(3px);
            }
            .popover-inner { padding: 28px 32px 24px; }
            .popover-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .popover-header h2 { margin: 0; font-size: 1.2rem; }
            .popover-close {
                background: none; border: none;
                font-size: 1.4rem; cursor: pointer;
                color: #64748b; line-height: 1;
            }
            .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
            .form-group { display: flex; flex-direction: column; gap: 5px; }
            .form-group.full-width { grid-column: 1 / -1; }
            .form-group label { font-size: .82rem; font-weight: 600; color: #374151; }
            .form-group input, .form-group select, .form-group textarea {
                padding: 9px 12px;
                border: 1.5px solid #d1d5db;
                border-radius: 8px;
                font-size: .9rem;
                font-family: inherit;
                transition: border-color .2s;
            }
            .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
                outline: none; border-color: #2563eb;
            }
            .form-group textarea { min-height: 90px; resize: vertical; }
            .form-actions { display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px; }

            /* Popover confirmar eliminación */
            .confirm-body { text-align: center; padding: 32px 28px; }
            .confirm-body .confirm-icon { font-size: 3rem; margin-bottom: 12px; }
            .confirm-body h2 { margin: 0 0 8px; font-size: 1.2rem; color: #111; }
            .confirm-body p  { margin: 0 0 24px; color: #64748b; font-size: .9rem; }
            .confirm-actions { display: flex; gap: 10px; justify-content: center; }
        </style>
    </head>
    <body>

        <nav class="topbar">
            <div>
                <div class="topbar-brand">ATS / Sistema de Reclutamiento</div>
                <div class="topbar-title">Grupo 10 — EPRO</div>
            </div>
            <div class="topbar-nav">
                <a href="index.jsp">Candidatos</a>
                <a href="svVacante" class="active">Vacantes</a>
            </div>
        </nav>

        <div class="page-wrapper">

            <% if (error != null) { %>
                <div class="alert alert-error">⚠ <%= escapeHtml(error) %></div>
            <% } %>
            <% if ("creada".equals(exito)) { %>
                <div class="alert alert-success">✔ Vacante creada correctamente.</div>
            <% } else if ("actualizada".equals(exito)) { %>
                <div class="alert alert-success">✔ Vacante actualizada correctamente.</div>
            <% } else if ("eliminada".equals(exito)) { %>
                <div class="alert alert-success">✔ Vacante eliminada correctamente.</div>
            <% } %>

            <div class="page-header">
                <div>
                    <h1>Gestión de Vacantes</h1>
                    <div class="subtitle">Administra las vacantes disponibles en el sistema.</div>
                </div>
                <button popovertarget="popover-crear" popovertargetaction="toggle"
                        class="btn btn-primary">＋ Nueva Vacante</button>
            </div>

            <!-- ══ POPOVER CREAR ══════════════════════════════════════════════ -->
            <div id="popover-crear" popover>
                <div class="popover-inner">
                    <div class="popover-header">
                        <h2>➕ Nueva Vacante</h2>
                        <button class="popover-close" popovertarget="popover-crear"
                                popovertargetaction="hide">✕</button>
                    </div>
                    <form method="POST" action="svVacante">
                        <input type="hidden" name="accion" value="crear">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Nombre del Puesto *</label>
                                <input type="text" name="nombre" placeholder="Ej. Desarrollador Web"
                                       maxlength="100" required>
                            </div>
                            <div class="form-group">
                                <label>Área / Departamento *</label>
                                <input type="text" name="area" placeholder="Ej. IT"
                                       maxlength="100" required>
                            </div>
                            <div class="form-group">
                                <label>Salario (USD) *</label>
                                <input type="number" name="Salario" placeholder="Ej. 1200.00"
                                       min="0" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label>Estado *</label>
                                <select name="estado" required>
                                    <option value="">-- Seleccionar --</option>
                                    <option value="ABIERTA">Abierta</option>
                                    <option value="CERRADA">Cerrada</option>
                                </select>
                            </div>
                            <div class="form-group full-width">
                                <label>Descripción *</label>
                                <textarea name="descripcion" placeholder="Requisitos, responsabilidades..."
                                          required></textarea>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-outline"
                                    popovertarget="popover-crear" popovertargetaction="hide">Cancelar</button>
                            <button type="submit" class="btn btn-primary">✔ Crear Vacante</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ══ POPOVER EDITAR ═════════════════════════════════════════════ -->
            <div id="popover-editar" popover>
                <div class="popover-inner">
                    <div class="popover-header">
                        <h2>✏ Editar Vacante</h2>
                        <button class="popover-close" popovertarget="popover-editar"
                                popovertargetaction="hide">✕</button>
                    </div>
                    <form method="POST" action="svVacante">
                        <input type="hidden" name="accion"    value="editar">
                        <input type="hidden" name="idVacante" id="edit-id">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Nombre del Puesto *</label>
                                <input type="text" name="nombre" id="edit-nombre"
                                       maxlength="100" required>
                            </div>
                            <div class="form-group">
                                <label>Área / Departamento *</label>
                                <input type="text" name="area" id="edit-area"
                                       maxlength="100" required>
                            </div>
                            <div class="form-group">
                                <label>Salario (USD) *</label>
                                <input type="number" name="Salario" id="edit-salario"
                                       min="0" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label>Estado *</label>
                                <select name="estado" id="edit-estado" required>
                                    <option value="">-- Seleccionar --</option>
                                    <option value="ABIERTA">Abierta</option>
                                    <option value="CERRADA">Cerrada</option>
                                </select>
                            </div>
                            <div class="form-group full-width">
                                <label>Descripción *</label>
                                <textarea name="descripcion" id="edit-descripcion" required></textarea>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-outline"
                                    popovertarget="popover-editar" popovertargetaction="hide">Cancelar</button>
                            <button type="submit" class="btn btn-primary">💾 Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ══ POPOVER CONFIRMAR ELIMINAR ════════════════════════════════ -->
            <div id="popover-eliminar" popover>
                <div class="confirm-body">
                    <div class="confirm-icon">🗑️</div>
                    <h2>¿Eliminar vacante?</h2>
                    <p id="confirm-texto">Esta acción no se puede deshacer.</p>
                    <form method="POST" action="svVacante">
                        <input type="hidden" name="accion"    value="eliminar">
                        <input type="hidden" name="idVacante" id="confirm-id">
                        <div class="confirm-actions">
                            <button type="button" class="btn btn-outline"
                                    popovertarget="popover-eliminar"
                                    popovertargetaction="hide">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Sí, eliminar</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ══ TABLA ══════════════════════════════════════════════════════ -->
            <div class="card">
                <div class="card-header">
                    <h2>Vacantes registradas</h2>
                    <span class="count-badge">
                        <%= vacantes != null ? vacantes.size() : 0 %> registros
                    </span>
                </div>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Puesto / Área</th>
                                <th>Salario</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (vacantes == null || vacantes.isEmpty()) { %>
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <div class="icon">📋</div>
                                        <p>No hay vacantes registradas aún.</p>
                                    </div>
                                </td>
                            </tr>
                        <% } else {
                               for (Vacante v : vacantes) { %>
                            <tr>
                                <td style="color:#94a3b8;font-size:.8rem;font-family:'IBM Plex Mono',monospace;">
                                    #<%= v.getIdVacante() %>
                                </td>
                                <td class="td-nombre">
                                    <strong><%= escapeHtml(v.getNombre()) %></strong>
                                    <small><%= escapeHtml(v.getArea()) %></small>
                                </td>
                                <td>
                                    <span class="salario">$<%= String.format("%,.2f", v.getSalario()) %></span>
                                </td>
                                <td style="max-width:260px;color:#475569;">
                                    <%= escapeHtml(v.getDescripcion().length() > 80
                                            ? v.getDescripcion().substring(0, 80) + "…"
                                            : v.getDescripcion()) %>
                                </td>
                                <td>
                                    <span class="badge <%= "ABIERTA".equals(v.getEstado()) ? "badge-abierta" : "badge-cerrada" %>">
                                        <%= v.getEstado() %>
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <button class="btn btn-warning btn-sm"
                                                onclick="abrirEditar(
                                                    '<%= v.getIdVacante() %>',
                                                    '<%= escapeJs(v.getNombre()) %>',
                                                    '<%= escapeJs(v.getArea()) %>',
                                                    '<%= v.getSalario() %>',
                                                    '<%= escapeJs(v.getDescripcion()) %>',
                                                    '<%= escapeJs(v.getEstado()) %>'
                                                )">
                                            ✏ Editar
                                        </button>
                                        <button class="btn btn-danger btn-sm"
                                                onclick="abrirEliminar('<%= v.getIdVacante() %>', '<%= escapeJs(v.getNombre()) %>')">
                                            🗑 Eliminar
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        <%   }
                           } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div><!-- /page-wrapper -->

        <script>
            function abrirEditar(id, nombre, area, salario, descripcion, estado) {
                document.getElementById('edit-id').value          = id;
                document.getElementById('edit-nombre').value      = nombre;
                document.getElementById('edit-area').value        = area;
                document.getElementById('edit-salario').value     = salario;
                document.getElementById('edit-descripcion').value = descripcion;
                document.getElementById('edit-estado').value      = estado;
                document.getElementById('popover-editar').showPopover();
            }

            function abrirEliminar(id, nombre) {
                document.getElementById('confirm-id').value  = id;
                document.getElementById('confirm-texto').textContent =
                    '¿Deseas eliminar la vacante "' + nombre + '"? Esta acción no se puede deshacer.';
                document.getElementById('popover-eliminar').showPopover();
            }
        </script>

        <%!
            private String escapeHtml(String s) {
                if (s == null) return "";
                return s.replace("&",  "&amp;")
                        .replace("<",  "&lt;")
                        .replace(">",  "&gt;")
                        .replace("\"", "&quot;")
                        .replace("'",  "&#39;");
            }
            private String escapeJs(String s) {
                if (s == null) return "";
                return s.replace("\\", "\\\\")
                        .replace("'",  "\\'")
                        .replace("\r", "")
                        .replace("\n", "\\n");
            }
        %>
    </body>
</html>