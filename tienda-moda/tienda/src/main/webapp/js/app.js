/* ══════════════════════════════════════════════════════════
   TIENDA MODA — JavaScript principal
   ══════════════════════════════════════════════════════════ */

// ── Cantidad en detalle de producto ──────────────────────
function cambiarCantidad(delta) {
  const input = document.getElementById('cantidad');
  if (!input) return;
  let val = parseInt(input.value) + delta;
  const max = parseInt(input.max) || 99;
  input.value = Math.min(Math.max(1, val), max);
}

// ── Animación de tarjetas al entrar en viewport ───────────
function animarTarjetas() {
  const cards = document.querySelectorAll('.card');
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        entry.target.style.animation = `fadeUp .55s ease ${i * 0.07}s forwards`;
        entry.target.style.opacity = '0';
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });
  cards.forEach(c => observer.observe(c));
}

// ── Notificación toast ────────────────────────────────────
function mostrarToast(mensaje, tipo = 'exito') {
  const t = document.createElement('div');
  t.className = `toast toast-${tipo}`;
  t.textContent = mensaje;
  t.style.cssText = `
    position:fixed; bottom:2rem; right:2rem; z-index:9999;
    background:${tipo==='exito'?'#0f0e0d':'#c0392b'};
    color:#f7f3ee; padding:.9rem 1.5rem; border-radius:6px;
    font-size:.88rem; box-shadow:0 8px 30px rgba(0,0,0,.3);
    transform:translateY(80px); opacity:0;
    transition: all .35s cubic-bezier(.34,1.56,.64,1);
    border-left:4px solid ${tipo==='exito'?'#c9a84c':'#e74c3c'};
  `;
  document.body.appendChild(t);
  requestAnimationFrame(() => {
    t.style.transform = 'translateY(0)';
    t.style.opacity   = '1';
  });
  setTimeout(() => {
    t.style.transform = 'translateY(80px)';
    t.style.opacity   = '0';
    setTimeout(() => t.remove(), 400);
  }, 3000);
}

// ── Confirmación de vaciar carrito ────────────────────────
function confirmarVaciar() {
  return confirm('¿Vaciar todo el carrito? Esta acción no se puede deshacer.');
}

// ── Búsqueda en vivo (filtro frontend sobre tarjetas) ─────
function busquedaLocal(q) {
  const lower = q.toLowerCase();
  document.querySelectorAll('.card[data-nombre]').forEach(card => {
    const nombre = card.dataset.nombre.toLowerCase();
    card.style.display = nombre.includes(lower) ? '' : 'none';
  });
}

// ── Filtro por categoría vía chips ────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  animarTarjetas();

  // Chips de categoría
  document.querySelectorAll('.chip[data-cat]').forEach(chip => {
    chip.addEventListener('click', () => {
      document.querySelectorAll('.chip').forEach(c => c.classList.remove('activo'));
      chip.classList.add('activo');
      const cat = chip.dataset.cat;
      document.querySelectorAll('.card[data-cat]').forEach(card => {
        card.style.display = (cat === 'todos' || card.dataset.cat === cat) ? '' : 'none';
      });
    });
  });

  // Botones de cantidad
  document.querySelectorAll('.qty-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      cambiarCantidad(btn.dataset.delta === '+' ? 1 : -1);
    });
  });

  // Auto-ocultar alertas
  document.querySelectorAll('.alerta').forEach(a => {
    setTimeout(() => {
      a.style.transition = 'opacity .5s';
      a.style.opacity    = '0';
      setTimeout(() => a.remove(), 500);
    }, 4000);
  });

  // Menú hamburguesa (móvil)
  const hamburger = document.getElementById('hamburger');
  const mobileNav = document.getElementById('mobile-nav');
  if (hamburger && mobileNav) {
    hamburger.addEventListener('click', () => {
      mobileNav.classList.toggle('abierto');
    });
  }
});
