<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("pageTitle", "Crear Cuenta"); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div class="auth-wrap">
  <div class="auth-card fade-up">
    <h1 class="auth-titulo">Crear cuenta</h1>
    <p class="auth-sub">Únete a la comunidad MODA&amp;Co</p>

    <c:if test="${not empty error}">
      <div class="alerta alerta-error"><i class="fa-solid fa-circle-xmark"></i> ${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/registro" method="post">
      <div class="campo">
        <label for="nombre">Nombre completo</label>
        <input type="text" id="nombre" name="nombre" required placeholder="Tu Nombre"/>
      </div>
      <div class="campo">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required placeholder="tucorreo@ejemplo.com"/>
      </div>
      <div class="campo">
        <label for="password">Contraseña</label>
        <input type="password" id="password" name="password" required placeholder="Mínimo 6 caracteres" minlength="6"/>
      </div>
      <button type="submit" class="btn btn-oro btn-full" style="margin-top:.5rem;">
        Crear mi cuenta
      </button>
    </form>

    <p style="text-align:center;margin-top:1.5rem;font-size:.88rem;color:var(--gris);">
      ¿Ya tienes cuenta?
      <a href="${pageContext.request.contextPath}/login" style="color:var(--oro);font-weight:500;">Inicia sesión</a>
    </p>
  </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
