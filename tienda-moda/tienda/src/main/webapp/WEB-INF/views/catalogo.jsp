<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<% request.setAttribute("pageTitle", "Catálogo"); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<section class="seccion">
  <p class="seccion-subtitulo">TIENDA MODA&amp;Co</p>
  <h1 class="seccion-titulo">Catálogo Completo</h1>

  <!-- ── Filtros ─────────────────────────────────────── -->
  <form class="filtros" action="${pageContext.request.contextPath}/productos" method="get">
    <input type="text" name="q" placeholder="🔍  Buscar producto..."
           value="${busqueda}" oninput="busquedaLocal(this.value)"/>
    <select name="cat" onchange="this.form.submit()">
      <option value="">Todas las categorías</option>
      <option value="1" ${catSeleccionada == 1 ? 'selected' : ''}>Camisas</option>
      <option value="2" ${catSeleccionada == 2 ? 'selected' : ''}>Pantalones</option>
      <option value="3" ${catSeleccionada == 3 ? 'selected' : ''}>Vestidos</option>
      <option value="4" ${catSeleccionada == 4 ? 'selected' : ''}>Accesorios</option>
      <option value="5" ${catSeleccionada == 5 ? 'selected' : ''}>Calzado</option>
    </select>
    <button type="submit" class="btn btn-oro btn-sm">Buscar</button>
    <a href="${pageContext.request.contextPath}/productos" class="btn btn-sm" style="border:1.5px solid #d4cfc9;">Limpiar</a>
  </form>

  <!-- ── Grid ───────────────────────────────────────── -->
  <c:choose>
    <c:when test="${empty productos}">
      <div style="text-align:center;padding:4rem 0;color:var(--gris);">
        <div style="font-size:3rem;margin-bottom:1rem;">🕵️</div>
        <p>No encontramos productos que coincidan.</p>
        <a href="${pageContext.request.contextPath}/productos" class="btn btn-negro" style="margin-top:1.5rem;">Ver todos</a>
      </div>
    </c:when>
    <c:otherwise>
      <p style="color:var(--gris);font-size:.85rem;margin-bottom:1.5rem;">
        ${productos.size()} resultado<c:if test="${productos.size() != 1}">s</c:if>
      </p>
      <div class="grid-productos">
        <c:forEach var="p" items="${productos}">
          <div class="card" data-nombre="${p.nombre}" data-cat="${p.categoriaId}">
            <a href="${pageContext.request.contextPath}/producto?id=${p.id}">
              <div class="card-img">
                <img src="https://source.unsplash.com/400x530/?fashion,style&sig=${p.id}"
                     alt="${p.nombre}" loading="lazy"/>
                <c:if test="${p.destacado}">
                  <span class="card-badge">Destacado</span>
                </c:if>
                <div class="card-acciones">
                  <span class="btn btn-oro btn-sm btn-full">Ver producto</span>
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
    </c:otherwise>
  </c:choose>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
