package com.tienda.dao;

import com.tienda.model.Usuario;
import java.sql.*;

public class UsuarioDAO {

    public Usuario login(String email, String password) throws SQLException {
        // Usamos MD5 igual que el INSERT; en producción usar BCrypt
        String sql = "SELECT * FROM usuarios WHERE email=? AND password=MD5(?)";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    public boolean registrar(Usuario u) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre,email,password,rol) VALUES (?,?,MD5(?), 'cliente')";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean emailExiste(String email) throws SQLException {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT id FROM usuarios WHERE email=?")) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private Usuario mapear(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setNombre(rs.getString("nombre"));
        u.setEmail(rs.getString("email"));
        u.setRol(rs.getString("rol"));
        return u;
    }
}
