<%@ page import="com.ats.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    if ("RRHH".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/rrhh/inicio.jsp");
        return;
    }

    if ("ENTREVISTADOR".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/entrevistador/inicio.jsp");
        return;
    }

    response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
%>
