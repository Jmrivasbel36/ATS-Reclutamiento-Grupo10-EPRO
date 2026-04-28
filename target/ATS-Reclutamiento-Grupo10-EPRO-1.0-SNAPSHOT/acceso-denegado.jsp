<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso denegado</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f3f4f6; display:flex; justify-content:center; align-items:center; min-height:100vh; margin:0; }
        .card { background:#fff; padding:40px; border-radius:16px; box-shadow:0 10px 25px rgba(0,0,0,.12); max-width:520px; width:90%; text-align:center; }
        h1 { color:#b91c1c; }
        a { display:inline-block; margin-top:20px; text-decoration:none; background:#2563eb; color:#fff; padding:12px 20px; border-radius:10px; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Acceso denegado</h1>
        <p>No tienes permisos para acceder a esta sección del sistema.</p>
        <a href="<%= request.getContextPath() %>/bienvenida.jsp">Ir al inicio</a>
    </div>
</body>
</html>
