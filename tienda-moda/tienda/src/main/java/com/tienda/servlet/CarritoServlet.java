package com.tienda.servlet;

import com.tienda.dao.CarritoDAO;
import com.tienda.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    private final CarritoDAO dao = new CarritoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario u = (Usuario) req.getSession().getAttribute("usuario");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            List<Map<String, Object>> items = dao.obtenerCarrito(u.getId());
            req.setAttribute("items", items);
            req.getRequestDispatcher("/WEB-INF/views/carrito.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Usuario u = (Usuario) req.getSession().getAttribute("usuario");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String accion = req.getParameter("accion");
        try {
            switch (accion == null ? "" : accion) {
                case "agregar":
                    int prodId = Integer.parseInt(req.getParameter("productoId"));
                    int cant   = Integer.parseInt(req.getParameter("cantidad"));
                    dao.agregarOActualizar(u.getId(), prodId, cant);
                    resp.sendRedirect(req.getContextPath() + "/carrito");
                    break;
                case "eliminar":
                    int cid = Integer.parseInt(req.getParameter("carritoId"));
                    dao.eliminar(cid);
                    resp.sendRedirect(req.getContextPath() + "/carrito");
                    break;
                case "vaciar":
                    dao.vaciar(u.getId());
                    resp.sendRedirect(req.getContextPath() + "/carrito");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/carrito");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
