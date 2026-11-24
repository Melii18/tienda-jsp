<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<% request.setAttribute("pageTitle", "Mi Carrito"); %>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<section class="seccion">
  <h1 class="seccion-titulo" style="margin-bottom:2rem;">
    <i class="fa-solid fa-bag-shopping" style="color:var(--oro);margin-right:.5rem;"></i>
    Mi Carrito
  </h1>

  <c:choose>
    <c:when test="${empty items}">
      <div class="carrito-vacio">
        <div class="icono">🛍️</div>
        <h2 style="font-family:var(--fuente-display);margin-bottom:.5rem;">Tu carrito está vacío</h2>
        <p style="color:var(--gris);margin-bottom:1.5rem;">Agrega productos para comenzar tu compra.</p>
        <a href="${pageContext.request.contextPath}/productos" class="btn btn-oro">Ir al catálogo</a>
      </div>
    </c:when>
    <c:otherwise>
      <div style="display:grid;grid-template-columns:1fr 320px;gap:2.5rem;align-items:start;">

        <!-- Tabla -->
        <div>
          <table class="carrito-tabla">
            <thead>
              <tr>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <c:set var="total" value="0"/>
              <c:forEach var="item" items="${items}">
                <c:set var="subtotal" value="${item.precio * item.cantidad}"/>
                <c:set var="total"    value="${total + subtotal}"/>
                <tr>
                  <td>
                    <div style="display:flex;align-items:center;gap:1rem;">
                      <img class="carrito-prod-img"
                           src="https://source.unsplash.com/140x180/?fashion&sig=${item.prodId}"
                           alt="${item.nombre}"/>
                      <div>
                        <a href="${pageContext.request.contextPath}/producto?id=${item.prodId}"
                           style="font-family:var(--fuente-display);font-weight:700;">${item.nombre}</a>
                      </div>
                    </div>
                  </td>
                  <td>$<fmt:formatNumber value="${item.precio}" pattern="#,##0"/></td>
                  <td>${item.cantidad}</td>
                  <td><strong>$<fmt:formatNumber value="${subtotal}" pattern="#,##0"/></strong></td>
                  <td>
                    <form action="${pageContext.request.contextPath}/carrito" method="post">
                      <input type="hidden" name="accion"    value="eliminar"/>
                      <input type="hidden" name="carritoId" value="${item.carritoId}"/>
                      <button type="submit" style="background:none;border:none;cursor:pointer;color:var(--gris);font-size:1.1rem;" title="Eliminar">
                        <i class="fa-solid fa-trash-can"></i>
                      </button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <!-- Vaciar -->
          <div style="margin-top:1rem;">
            <form action="${pageContext.request.contextPath}/carrito" method="post"
                  onsubmit="return confirmarVaciar()">
              <input type="hidden" name="accion" value="vaciar"/>
              <button type="submit" class="btn btn-sm" style="border:1.5px solid var(--gris-clr);color:var(--gris);">
                <i class="fa-solid fa-trash"></i> Vaciar carrito
              </button>
            </form>
          </div>
        </div>

        <!-- Resumen -->
        <div style="background:var(--blanco);border-radius:10px;padding:2rem;box-shadow:var(--sombra);position:sticky;top:80px;">
          <h2 style="font-family:var(--fuente-display);font-size:1.3rem;margin-bottom:1.5rem;">Resumen del pedido</h2>

          <div style="display:flex;justify-content:space-between;margin-bottom:.7rem;font-size:.9rem;color:var(--gris);">
            <span>Subtotal</span>
            <span>$<fmt:formatNumber value="${total}" pattern="#,##0"/></span>
          </div>
          <div style="display:flex;justify-content:space-between;margin-bottom:.7rem;font-size:.9rem;color:var(--gris);">
            <span>Envío</span>
            <span style="color:#27ae60;">${total >= 150000 ? 'Gratis' : '$12.000'}</span>
          </div>
          <hr style="border:none;border-top:1.5px solid var(--gris-clr);margin:1rem 0;"/>
          <div style="display:flex;justify-content:space-between;font-size:1.15rem;font-weight:700;margin-bottom:1.5rem;">
            <span>Total</span>
            <span>$<fmt:formatNumber value="${total >= 150000 ? total : total + 12000}" pattern="#,##0"/></span>
          </div>

          <button class="btn btn-oro btn-full" onclick="mostrarToast('¡Funcionalidad de pago próximamente!','exito')">
            <i class="fa-solid fa-credit-card"></i> Proceder al pago
          </button>
          <a href="${pageContext.request.contextPath}/productos" class="btn btn-sm btn-full"
             style="margin-top:.8rem;border:1.5px solid var(--gris-clr);justify-content:center;">
            Seguir comprando
          </a>
        </div>

      </div>
    </c:otherwise>
  </c:choose>
</section>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
