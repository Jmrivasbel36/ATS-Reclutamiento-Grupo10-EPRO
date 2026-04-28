<%-- 
    Document   : index
    Created on : Apr 21, 2026, 4:21:35 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS | grupo 10</title>
    <link rel="stylesheet" href="./CSS/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <h1><i class="fas fa-briefcase"></i>ATS| Grupo 10</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="svVacante" class="active">Home</a></li>
                    <li><a href="./Vacantes.jsp">Publicar Trabajos</a></li>
                    <li><a href="./Candidato.jsp">Candidatos</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <a href="./login.jsp" class="btn btn-outline">Inicia Sesión</a>
                <a class="btn btn-primary">Registrar</a>
            </div>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1>Sistema De Gestión De Candidatos</h1>
                <p>Vacantes, pipeline de candidatos, evaluación, notas, adjuntos y reportes. Incluye roles.</p>
                <div class="search-box">
                    <div class="search-group">
                        <i class="fas fa-search"></i>
                        <input type="text" id="job-search" placeholder="Job title, keywords, or company">
                    </div>
                    <div class="search-group">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" id="location-search" placeholder="City, state, or remote">
                    </div>
                    <button class="btn btn-primary search-btn">Search Jobs</button>
                </div>
            </div>
        </div>
    </section>

    <section class="job-listings">
        <div class="container">
            <div class="filters-panel">
                <h3>Filters</h3>
                <div class="filter-group">
                    <h4>Job Type</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="job-type" value="full-time"> Full-time</label>
                        <label><input type="checkbox" name="job-type" value="part-time"> Part-time</label>
                        <label><input type="checkbox" name="job-type" value="contract"> Contract</label>
                        <label><input type="checkbox" name="job-type" value="internship"> Internship</label>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Experience Level</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="experience" value="entry"> Entry Level</label>
                        <label><input type="checkbox" name="experience" value="mid"> Mid Level</label>
                        <label><input type="checkbox" name="experience" value="senior"> Senior Level</label>
                        <label><input type="checkbox" name="experience" value="executive"> Executive</label>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Salary Range</h4>
                    <div class="range-slider">
                        <input type="range" min="30000" max="200000" value="30000" class="slider" id="salary-range">
                        <span id="salary-value">$30,000+</span>
                    </div>
                </div>
                <div class="filter-group">
                    <h4>Remote Options</h4>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="remote" value="remote"> Remote</label>
                        <label><input type="checkbox" name="remote" value="hybrid"> Hybrid</label>
                        <label><input type="checkbox" name="remote" value="onsite"> On-site</label>
                    </div>
                </div>
                <button class="btn btn-outline btn-block">Clear Filters</button>
            </div>

            <div class="jobs-container">
                <div class="jobs-header">
                    <h2>Vacantes Disponibles
                        <span id="job-count">
                            (<c:out value="${empty sessionScope.listaVacantes ? 0 : sessionScope.listaVacantes.size()}"/>)
                        </span>
                    </h2>
                    <div class="sort-options">
                        <label for="sort-by">Sort by:</label>
                        <select id="sort-by">
                            <option value="relevance">Relevance</option>
                            <option value="recent">Most Recent</option>
                            <option value="salary-high">Salary (High to Low)</option>
                            <option value="salary-low">Salary (Low to High)</option>
                        </select>
                    </div>
                </div>

                <div id="jobs-list">
                    <c:choose>
                        <c:when test="${empty sessionScope.listaVacantes}">
                            <div style="text-align:center; padding: 60px 20px; color: #888;">
                                <i class="fas fa-briefcase" style="font-size: 48px; margin-bottom: 16px; display:block;"></i>
                                <p>No hay vacantes disponibles en este momento.</p>
                                <a href="./Vacantes.jsp" class="btn btn-primary" style="margin-top:12px;">Publicar primera vacante</a>
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
                                                    <span style="background:#d1fae5; color:#065f46; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:600;">
                                                        <i class="fas fa-circle" style="font-size:8px;"></i> Activa
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#fee2e2; color:#991b1b; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:600;">
                                                        <i class="fas fa-circle" style="font-size:8px;"></i> <c:out value="${v.estado}"/>
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
                                            <span class="tag"><i class="fas fa-dollar-sign"></i>
                                                <fmt:formatNumber value="${v.salario}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                            </span>
                                        </div>
                                        <button class="btn btn-outline apply-btn">Ver Detalle</button>
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

    <%-- script.js eliminado: las cards ahora vienen del servidor --%>
</body>
</html>
