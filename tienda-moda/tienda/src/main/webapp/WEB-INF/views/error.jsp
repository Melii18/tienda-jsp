<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<% request.setAttribute("pageTitle", "Página no encontrada"); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div style="min-height:70vh;display:flex;align-items:center;justify-content:center;text-align:center;padding:2rem;">
  <div>
    <div style="font-family:var(--fuente-display);font-size:8rem;font-weight:700;color:var(--gris-clr);line-height:1;">404</div>
    <h1 style="font-family:var(--fuente-display);font-size:2rem;margin-bottom:.8rem;">Página no encontrada</h1>
    <p style="color:var(--gris);margin-bottom:2rem;">La página que buscas no existe o fue movida.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-oro">Ir al inicio</a>
  </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
