<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"     prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"      prefix="fmt" %>
<%
    request.setAttribute("pageTitle", "Inicio");
    // Cargar productos destacados
    java.util.List<com.tienda.model.Producto> destacados = null;
    try {
        destacados = new com.tienda.dao.ProductoDAO().listarDestacados();
    } catch (Exception e) {
        destacados = java.util.Collections.emptyList();
    }
    request.setAttribute("destacados", destacados);
%>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<!-- ── HERO ──────────────────────────────────────────── -->
<section class="hero">
  <div class="hero-texto">
    <p class="hero-eyebrow fade-up">Nueva Colección 2024</p>
    <h1 class="hero-titulo fade-up fade-up-delay-1">
      Estilo que <em>define</em><br>quién eres
    </h1>
    <p class="hero-sub fade-up fade-up-delay-2">
      Piezas cuidadosamente seleccionadas para cada momento. Moda con propósito, elegancia sin esfuerzo.
    </p>
    <div style="display:flex;gap:1rem;" class="fade-up fade-up-delay-3">
      <a href="${pageContext.request.contextPath}/productos" class="btn btn-oro">
        <i class="fa-solid fa-arrow-right"></i> Ver catálogo
      </a>
      <a href="${pageContext.request.contextPath}/productos?cat=3" class="btn btn-outline">
        Vestidos
      </a>
    </div>
  </div>
  <div class="hero-imagen">
    <img src="https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=900&q=80"
         alt="Colección 2024" />
  </div>
</section>

<!-- ── CATEGORÍAS ─────────────────────────────────────── -->
<section class="seccion">
  <p class="seccion-subtitulo">EXPLORAR POR</p>
  <h2 class="seccion-titulo">Categorías</h2>
  <div class="chips" style="margin-top:1.5rem;">
    <a href="${pageContext.request.contextPath}/productos" class="chip">Todos</a>
    <a href="${pageContext.request.contextPath}/productos?cat=1" class="chip">Camisas</a>
    <a href="${pageContext.request.contextPath}/productos?cat=2" class="chip">Pantalones</a>
    <a href="${pageContext.request.contextPath}/productos?cat=3" class="chip">Vestidos</a>
    <a href="${pageContext.request.contextPath}/productos?cat=4" class="chip">Accesorios</a>
    <a href="${pageContext.request.contextPath}/productos?cat=5" class="chip">Calzado</a>
  </div>
</section>

<!-- ── DESTACADOS ─────────────────────────────────────── -->
<section class="seccion" style="padding-top:0;">
  <p class="seccion-subtitulo">LO MÁS POPULAR</p>
  <h2 class="seccion-titulo">Productos Destacados</h2>

  <div class="grid-productos" style="margin-top:2rem;">
    <c:forEach var="p" items="${destacados}">
      <div class="card" data-nombre="${p.nombre}" data-cat="${p.categoriaId}">
        <a href="${pageContext.request.contextPath}/producto?id=${p.id}">
          <div class="card-img">
            <img src="https://source.unsplash.com/400x530/?fashion,clothing&sig=${p.id}"
                 alt="${p.nombre}" loading="lazy"/>
            <span class="card-badge">Destacado</span>
            <div class="card-acciones">
              <a href="${pageContext.request.contextPath}/producto?id=${p.id}"
                 class="btn btn-oro btn-sm btn-full">Ver producto</a>
            </div>
          </div>
        </a>
        <div class="card-body">
          <p class="card-categoria">${p.categoriaNombre}</p>
          <p class="card-nombre">${p.nombre}</p>
          <p class="card-precio">
            <span class="moneda">$</span>
            <fmt:formatNumber value="${p.precio}" pattern="#,##0"/>
          </p>
        </div>
      </div>
    </c:forEach>
  </div>

  <div style="text-align:center;margin-top:2.5rem;">
    <a href="${pageContext.request.contextPath}/productos" class="btn btn-negro">
      Ver todo el catálogo <i class="fa-solid fa-arrow-right"></i>
    </a>
  </div>
</section>

<!-- ── BANNER INFORMATIVO ─────────────────────────────── -->
<section class="seccion seccion-oscura">
  <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:2rem;text-align:center;">
    <div>
      <div style="font-size:2rem;color:var(--oro);margin-bottom:.6rem;"><i class="fa-solid fa-truck-fast"></i></div>
      <h3 style="font-family:var(--fuente-display);margin-bottom:.4rem;">Envío Rápido</h3>
      <p style="color:#9e968d;font-size:.88rem;">Entrega en 24–48 horas a todo el país</p>
    </div>
    <div>
      <div style="font-size:2rem;color:var(--oro);margin-bottom:.6rem;"><i class="fa-solid fa-rotate-left"></i></div>
      <h3 style="font-family:var(--fuente-display);margin-bottom:.4rem;">30 Días de Cambio</h3>
      <p style="color:#9e968d;font-size:.88rem;">Si no te queda, lo cambiamos sin problema</p>
    </div>
    <div>
      <div style="font-size:2rem;color:var(--oro);margin-bottom:.6rem;"><i class="fa-solid fa-lock"></i></div>
      <h3 style="font-family:var(--fuente-display);margin-bottom:.4rem;">Pago Seguro</h3>
      <p style="color:#9e968d;font-size:.88rem;">Plataforma cifrada y 100% confiable</p>
    </div>
    <div>
      <div style="font-size:2rem;color:var(--oro);margin-bottom:.6rem;"><i class="fa-solid fa-headset"></i></div>
      <h3 style="font-family:var(--fuente-display);margin-bottom:.4rem;">Soporte 24/7</h3>
      <p style="color:#9e968d;font-size:.88rem;">Siempre disponibles para ayudarte</p>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
