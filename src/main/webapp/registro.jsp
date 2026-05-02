<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro | ATS Reclutamiento</title>
    <link rel="stylesheet" href="./CSS/login.css">
    <style>
        .role-group {
            display: flex;
            gap: 12px;
            margin-top: 4px;
        }
        .role-card {
            flex: 1;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 14px 12px;
            cursor: pointer;
            transition: border-color .2s, background .2s;
            text-align: center;
        }
        .role-card input[type="radio"] { display: none; }
        .role-card .role-icon { font-size: 1.8rem; margin-bottom: 6px; }
        .role-card .role-name { font-weight: 700; font-size: .9rem; color: #1e293b; }
        .role-card .role-desc { font-size: .75rem; color: #64748b; margin-top: 3px; }
        .role-card:has(input:checked) {
            border-color: #2563eb;
            background: #eff6ff;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-left">
            <div class="tag">ATS RECLUTAMIENTO · REGISTRO</div>
            <h1>Crea tu cuenta en el sistema</h1>
            <p>Elige tu rol dentro del proceso de reclutamiento y accede
               a las funcionalidades correspondientes.</p>
            <div class="feature">✔ RRHH: gestión completa de vacantes y candidatos</div>
            <div class="feature">✔ Entrevistador: evaluación y seguimiento de candidatos</div>
        </div>
        <div class="login-right">
            <div class="form-box">
                <h2>Crear cuenta</h2>
                <div class="subtext">Completa los datos para registrarte</div>

                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <div class="alert-error"><%= error %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/registro" method="post">
                    <div class="input-group">
                        <label for="usuario">Usuario</label>
                        <input type="text" id="usuario" name="usuario"
                               placeholder="Ej. maria.garcia" required
                               minlength="3" maxlength="50">
                    </div>
                    <div class="input-group">
                        <label for="clave">Contraseña</label>
                        <input type="password" id="clave" name="clave"
                               placeholder="Mínimo 6 caracteres" required minlength="6">
                    </div>
                    <div class="input-group">
                        <label>Rol *</label>
                        <div class="role-group">
                            <label class="role-card">
                                <input type="radio" name="rol" value="RRHH" required>
                                <div class="role-icon">🧑‍💼</div>
                                <div class="role-name">RRHH</div>
                                <div class="role-desc">Gestión de vacantes y candidatos</div>
                            </label>
                            <label class="role-card">
                                <input type="radio" name="rol" value="ENTREVISTADOR">
                                <div class="role-icon">🎙️</div>
                                <div class="role-name">Entrevistador</div>
                                <div class="role-desc">Evaluación de candidatos</div>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn-login" style="margin-top:20px;">
                        Crear cuenta
                    </button>
                </form>

                <div class="register-link">
                    ¿Ya tienes cuenta?
                    <a href="${pageContext.request.contextPath}/login.jsp">Iniciar sesión</a>
                </div>

                <div class="footer-text">© 2026 Sistema ATS de Reclutamiento</div>
            </div>
        </div>
    </div>
</body>
</html>