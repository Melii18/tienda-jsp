package com.tienda.servlet;

import com.tienda.dao.ProductoDAO;
import com.tienda.model.Producto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/productos", "/producto"})
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/producto".equals(path)) {
            // Detalle de un producto
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                Producto p = dao.obtenerPorId(id);
                req.setAttribute("producto", p);
                req.getRequestDispatcher("/WEB-INF/views/detalle.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new ServletException(e);
            }

        } else {
            // Catálogo / búsqueda / filtro por categoría
            try {
                List<Producto> productos;
                String busqueda = req.getParameter("q");
                String catParam = req.getParameter("cat");

                if (busqueda != null && !busqueda.isBlank()) {
                    productos = dao.buscar(busqueda);
                    req.setAttribute("busqueda", busqueda);
                } else if (catParam != null && !catParam.isBlank()) {
                    productos = dao.listarPorCategoria(Integer.parseInt(catParam));
                    req.setAttribute("catSeleccionada", Integer.parseInt(catParam));
                } else {
                    productos = dao.listarTodos();
                }

                req.setAttribute("productos", productos);
                req.getRequestDispatcher("/WEB-INF/views/catalogo.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
    }
}
