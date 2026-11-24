<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("pageTitle", "Iniciar Sesión"); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div class="auth-wrap">
  <div class="auth-card fade-up">
    <h1 class="auth-titulo">Bienvenido</h1>
    <p class="auth-sub">Inicia sesión en tu cuenta</p>

    <c:if test="${not empty error}">
      <div class="alerta alerta-error"><i class="fa-solid fa-circle-xmark"></i> ${error}</div>
    </c:if>
    <c:if test="${not empty exito}">
      <div class="alerta alerta-exito"><i class="fa-solid fa-circle-check"></i> ${exito}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="campo">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required placeholder="tucorreo@ejemplo.com"/>
      </div>
      <div class="campo">
        <label for="password">Contraseña</label>
        <input type="password" id="password" name="password" required placeholder="••••••••"/>
      </div>
      <button type="submit" class="btn btn-oro btn-full" style="margin-top:.5rem;">
        Iniciar sesión
      </button>
    </form>

    <p style="text-align:center;margin-top:1.5rem;font-size:.88rem;color:var(--gris);">
      ¿No tienes cuenta?
      <a href="${pageContext.request.contextPath}/registro" style="color:var(--oro);font-weight:500;">Regístrate aquí</a>
    </p>
  </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
