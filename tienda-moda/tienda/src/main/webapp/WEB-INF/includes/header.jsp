<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Badge del carrito
    com.tienda.model.Usuario usuarioNav = (com.tienda.model.Usuario) session.getAttribute("usuario");
    int badgeCarrito = 0;
    if (usuarioNav != null) {
        try {
            badgeCarrito = new com.tienda.dao.CarritoDAO().contarItems(usuarioNav.getId());
        } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Tienda Moda — <%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Bienvenido" %></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="nav-logo">MODA<span>&amp;Co</span></a>

  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/">Inicio</a>
    <a href="${pageContext.request.contextPath}/productos">Catálogo</a>
    <a href="${pageContext.request.contextPath}/productos?cat=1">Camisas</a>
    <a href="${pageContext.request.contextPath}/productos?cat=3">Vestidos</a>
    <a href="${pageContext.request.contextPath}/productos?cat=4">Accesorios</a>
  </div>

  <div class="nav-acciones">
    <% if (usuarioNav != null) { %>
      <span style="color:#9e968d;font-size:.82rem;">Hola, <%= usuarioNav.getNombre().split(" ")[0] %></span>
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Salir</a>
    <% } else { %>
      <a href="${pageContext.request.contextPath}/login"   class="btn btn-outline btn-sm">Entrar</a>
      <a href="${pageContext.request.contextPath}/registro" class="btn btn-oro btn-sm">Registrarse</a>
    <% } %>

    <a href="${pageContext.request.contextPath}/carrito" class="btn-carrito" title="Mi carrito">
      <i class="fa-solid fa-bag-shopping"></i>
      <% if (badgeCarrito > 0) { %>
        <span class="badge-carrito"><%= badgeCarrito %></span>
      <% } %>
    </a>
  </div>
</nav>
