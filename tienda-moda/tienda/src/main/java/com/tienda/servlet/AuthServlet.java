package com.tienda.servlet;

import com.tienda.dao.UsuarioDAO;
import com.tienda.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/registro", "/logout"})
public class AuthServlet extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/logout".equals(path)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        String vista = "/login".equals(path) ? "/WEB-INF/views/login.jsp" : "/WEB-INF/views/registro.jsp";
        req.getRequestDispatcher(vista).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/login".equals(path)) {
            String email    = req.getParameter("email");
            String password = req.getParameter("password");
            try {
                Usuario u = dao.login(email, password);
                if (u != null) {
                    req.getSession().setAttribute("usuario", u);
                    resp.sendRedirect(req.getContextPath() + "/");
                } else {
                    req.setAttribute("error", "Email o contraseña incorrectos.");
                    req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                throw new ServletException(e);
            }

        } else if ("/registro".equals(path)) {
            String nombre   = req.getParameter("nombre");
            String email    = req.getParameter("email");
            String password = req.getParameter("password");
            try {
                if (dao.emailExiste(email)) {
                    req.setAttribute("error", "El email ya está registrado.");
                    req.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(req, resp);
                    return;
                }
                Usuario u = new Usuario();
                u.setNombre(nombre);
                u.setEmail(email);
                u.setPassword(password);
                dao.registrar(u);
                req.setAttribute("exito", "¡Registro exitoso! Ya puedes iniciar sesión.");
                req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
    }
}
