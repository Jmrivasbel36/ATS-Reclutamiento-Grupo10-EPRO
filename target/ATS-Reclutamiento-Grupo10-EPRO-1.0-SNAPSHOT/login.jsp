<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | ATS Reclutamiento</title>
    <link rel="stylesheet" href="./CSS/login.css">
</head>
<body>
    <div class="login-container">
        <div class="login-left">
            <div class="tag">ATS RECLUTAMIENTO · RRHH</div>
            <h1>Gestiona talento con una experiencia moderna</h1>
            <p>Sistema de reclutamiento y selección de personal diseñado para
               optimizar el seguimiento de candidatos, entrevistas y procesos
               de contratación dentro del área de recursos humanos.</p>
            <div class="feature">✔ Autenticación con sesión activa</div>
            <div class="feature">✔ Control de acceso mediante filtros</div>
            <div class="feature">✔ Roles definidos: RRHH y Entrevistador</div>
        </div>
        <div class="login-right">
            <div class="form-box">
                <h2>Iniciar sesión</h2>
                <div class="subtext">Ingresa tus credenciales para continuar</div>

                <%-- Mensaje de registro exitoso --%>
                <% if ("1".equals(request.getParameter("registrado"))) { %>
                    <div class="alert-success">✔ Usuario registrado. Ahora puedes iniciar sesión.</div>
                <% } %>

                <%-- Error de login --%>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <div class="alert-error"><%= error %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="input-group">
                        <label for="usuario">Usuario</label>
                        <input type="text" id="usuario" name="usuario"
                               placeholder="Ingresa tu usuario" required>
                    </div>
                    <div class="input-group">
                        <label for="clave">Contraseña</label>
                        <input type="password" id="clave" name="clave"
                               placeholder="Ingresa tu contraseña" required>
                    </div>
                    <button type="submit" class="btn-login">Entrar al sistema</button>
                </form>

                <div class="register-link">
                    ¿No tienes cuenta?
                    <a href="${pageContext.request.contextPath}/registro.jsp">Registrarse</a>
                </div>

                <div class="footer-text">© 2026 Sistema ATS de Reclutamiento</div>
            </div>
        </div>
    </div>
</body>
</html>