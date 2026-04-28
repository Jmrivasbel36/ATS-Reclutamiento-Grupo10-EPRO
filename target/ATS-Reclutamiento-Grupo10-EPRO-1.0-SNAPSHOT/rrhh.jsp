<%@ page import="com.ats.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel RRHH</title>
    <style>
        body { margin:0; font-family:Arial, sans-serif; background:linear-gradient(135deg,#0f172a,#2563eb); color:#fff; }
        .wrap { max-width:1000px; margin:40px auto; padding:24px; }
        .top { display:flex; justify-content:space-between; align-items:center; gap:16px; }
        .card { background:rgba(255,255,255,.12); backdrop-filter: blur(6px); border-radius:18px; padding:28px; margin-top:24px; }
        a.btn { background:#fff; color:#1d4ed8; text-decoration:none; padding:12px 18px; border-radius:10px; font-weight:bold; }
        ul { line-height:1.9; }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="top">
            <div>
                <h1>Panel de RRHH</h1>
                <p>Bienvenido, <strong><%= usuario.getNombre() %></strong>.</p>
            </div>
            <a class="btn" href="<%= request.getContextPath() %>/logout">Cerrar sesión</a>
        </div>

        <div class="card">
            <h2>Información de sesión</h2>
            <p><strong>Usuario:</strong> <%= usuario.getUsuario() %></p>
            <p><strong>Rol:</strong> <%= usuario.getRol() %></p>
        </div>

        <div class="card">
            <h2>Acciones disponibles para RRHH</h2>
            <ul>
                <li>Gestionar vacantes y candidatos.</li>
                <li>Consultar reportes del proceso de reclutamiento.</li>
                <li>Asignar candidatos a entrevistas.</li>
            </ul>
        </div>
    </div>
</body>
</html>
