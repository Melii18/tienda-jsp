<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<% request.setAttribute("pageTitle", ((com.tienda.model.Producto)request.getAttribute("producto")).getNombre()); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<section class="seccion">
  <a href="${pageContext.request.contextPath}/productos"
     style="display:inline-flex;align-items:center;gap:.5rem;color:var(--gris);font-size:.85rem;margin-bottom:2rem;">
    <i class="fa-solid fa-arrow-left"></i> Volver al catálogo
  </a>

  <div class="detalle-grid">

    <!-- Imagen -->
    <div class="detalle-img">
      <img src="https://source.unsplash.com/700x930/?fashion,clothing&sig=${producto.id}"
           alt="${producto.nombre}"/>
    </div>

    <!-- Info -->
    <div class="detalle-info">
      <p class="detalle-cat">${producto.categoriaNombre}</p>
      <h1 class="detalle-nombre">${producto.nombre}</h1>

      <p class="detalle-precio">
        $<fmt:formatNumber value="${producto.precio}" pattern="#,##0"/>
      </p>

      <p class="detalle-desc">${producto.descripcion}</p>

      <p class="detalle-stock ${producto.stock == 0 ? 'agotado' : ''}">
        <c:choose>
          <c:when test="${producto.stock == 0}">⚠ Agotado</c:when>
          <c:when test="${producto.stock < 5}">⚡ ¡Últimas ${producto.stock} unidades!</c:when>
          <c:otherwise>✓ En stock (${producto.stock} disponibles)</c:otherwise>
        </c:choose>
      </p>

      <c:if test="${producto.stock > 0}">
        <form action="${pageContext.request.contextPath}/carrito" method="post">
          <input type="hidden" name="accion"     value="agregar"/>
          <input type="hidden" name="productoId" value="${producto.id}"/>

          <div class="qty-control">
            <button type="button" class="qty-btn" data-delta="-">−</button>
            <span class="qty-num">
              <input type="number" id="cantidad" name="cantidad"
                     value="1" min="1" max="${producto.stock}"
                     style="width:3rem;text-align:center;border:1.5px solid #d4cfc9;border-radius:4px;padding:.3rem;font-size:1rem;"/>
            </span>
            <button type="button" class="qty-btn" data-delta="+">+</button>
          </div>

          <c:choose>
            <c:when test="${sessionScope.usuario != null}">
              <button type="submit" class="btn btn-oro btn-full">
                <i class="fa-solid fa-bag-shopping"></i> Agregar al carrito
              </button>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/login" class="btn btn-negro btn-full">
                <i class="fa-solid fa-lock"></i> Inicia sesión para comprar
              </a>
            </c:otherwise>
          </c:choose>
        </form>
      </c:if>

      <!-- Info adicional -->
      <div style="margin-top:2rem;border-top:1px solid var(--gris-clr);padding-top:1.5rem;display:flex;flex-direction:column;gap:.7rem;">
        <div style="display:flex;gap:.8rem;align-items:center;color:var(--gris);font-size:.85rem;">
          <i class="fa-solid fa-truck-fast" style="color:var(--oro);width:18px;"></i>
          Envío gratis en compras mayores a $150.000
        </div>
        <div style="display:flex;gap:.8rem;align-items:center;color:var(--gris);font-size:.85rem;">
          <i class="fa-solid fa-rotate-left" style="color:var(--oro);width:18px;"></i>
          Cambios y devoluciones en 30 días
        </div>
        <div style="display:flex;gap:.8rem;align-items:center;color:var(--gris);font-size:.85rem;">
          <i class="fa-solid fa-shield-halved" style="color:var(--oro);width:18px;"></i>
          Pago 100% seguro y protegido
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
