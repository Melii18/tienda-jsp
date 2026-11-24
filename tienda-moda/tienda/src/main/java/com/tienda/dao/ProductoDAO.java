package com.tienda.dao;

import com.tienda.model.Producto;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // ── Listar todos ──────────────────────────────────────────
    public List<Producto> listarTodos() throws SQLException {
        String sql = "SELECT p.*, c.nombre AS cat_nombre " +
                     "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id " +
                     "ORDER BY p.creado_en DESC";
        return ejecutarListado(sql);
    }

    // ── Listar destacados ─────────────────────────────────────
    public List<Producto> listarDestacados() throws SQLException {
        String sql = "SELECT p.*, c.nombre AS cat_nombre " +
                     "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id " +
                     "WHERE p.destacado = 1 LIMIT 8";
        return ejecutarListado(sql);
    }

    // ── Buscar por categoría ──────────────────────────────────
    public List<Producto> listarPorCategoria(int categoriaId) throws SQLException {
        String sql = "SELECT p.*, c.nombre AS cat_nombre " +
                     "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id " +
                     "WHERE p.categoria_id = ? ORDER BY p.nombre";
        List<Producto> lista = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    // ── Buscar por texto ──────────────────────────────────────
    public List<Producto> buscar(String termino) throws SQLException {
        String sql = "SELECT p.*, c.nombre AS cat_nombre " +
                     "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id " +
                     "WHERE p.nombre LIKE ? OR p.descripcion LIKE ? ORDER BY p.nombre";
        List<Producto> lista = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            String t = "%" + termino + "%";
            ps.setString(1, t);
            ps.setString(2, t);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    // ── Obtener por id ────────────────────────────────────────
    public Producto obtenerPorId(int id) throws SQLException {
        String sql = "SELECT p.*, c.nombre AS cat_nombre " +
                     "FROM productos p LEFT JOIN categorias c ON p.categoria_id = c.id " +
                     "WHERE p.id = ?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    // ── Insertar ──────────────────────────────────────────────
    public boolean insertar(Producto p) throws SQLException {
        String sql = "INSERT INTO productos (nombre,descripcion,precio,stock,imagen_url,categoria_id,destacado) VALUES (?,?,?,?,?,?,?)";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setBigDecimal(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagenUrl());
            ps.setInt(6, p.getCategoriaId());
            ps.setBoolean(7, p.isDestacado());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Actualizar ────────────────────────────────────────────
    public boolean actualizar(Producto p) throws SQLException {
        String sql = "UPDATE productos SET nombre=?,descripcion=?,precio=?,stock=?,imagen_url=?,categoria_id=?,destacado=? WHERE id=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setBigDecimal(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagenUrl());
            ps.setInt(6, p.getCategoriaId());
            ps.setBoolean(7, p.isDestacado());
            ps.setInt(8, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Eliminar ──────────────────────────────────────────────
    public boolean eliminar(int id) throws SQLException {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM productos WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Helpers ───────────────────────────────────────────────
    private List<Producto> ejecutarListado(String sql) throws SQLException {
        List<Producto> lista = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) lista.add(mapear(rs));
        }
        return lista;
    }

    private Producto mapear(ResultSet rs) throws SQLException {
        Producto p = new Producto();
        p.setId(rs.getInt("id"));
        p.setNombre(rs.getString("nombre"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setPrecio(rs.getBigDecimal("precio"));
        p.setStock(rs.getInt("stock"));
        p.setImagenUrl(rs.getString("imagen_url"));
        p.setCategoriaId(rs.getInt("categoria_id"));
        p.setCategoriaNombre(rs.getString("cat_nombre"));
        p.setDestacado(rs.getBoolean("destacado"));
        return p;
    }
}
