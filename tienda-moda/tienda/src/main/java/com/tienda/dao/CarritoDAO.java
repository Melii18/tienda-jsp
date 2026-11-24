package com.tienda.dao;

import com.tienda.model.Producto;
import java.sql.*;
import java.util.*;

public class CarritoDAO {

    /** Devuelve los ítems del carrito junto con la info del producto */
    public List<Map<String, Object>> obtenerCarrito(int usuarioId) throws SQLException {
        String sql = "SELECT c.id as carrito_id, c.cantidad, " +
                     "p.id as prod_id, p.nombre, p.precio, p.imagen_url " +
                     "FROM carrito c JOIN productos p ON c.producto_id = p.id " +
                     "WHERE c.usuario_id = ?";
        List<Map<String, Object>> items = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> item = new LinkedHashMap<>();
                    item.put("carritoId",  rs.getInt("carrito_id"));
                    item.put("cantidad",   rs.getInt("cantidad"));
                    item.put("prodId",     rs.getInt("prod_id"));
                    item.put("nombre",     rs.getString("nombre"));
                    item.put("precio",     rs.getBigDecimal("precio"));
                    item.put("imagenUrl",  rs.getString("imagen_url"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    public void agregarOActualizar(int usuarioId, int productoId, int cantidad) throws SQLException {
        String check = "SELECT id, cantidad FROM carrito WHERE usuario_id=? AND producto_id=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(check)) {
            ps.setInt(1, usuarioId);
            ps.setInt(2, productoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int nuevaCant = rs.getInt("cantidad") + cantidad;
                    try (PreparedStatement up = cn.prepareStatement(
                            "UPDATE carrito SET cantidad=? WHERE id=?")) {
                        up.setInt(1, nuevaCant);
                        up.setInt(2, rs.getInt("id"));
                        up.executeUpdate();
                    }
                } else {
                    try (PreparedStatement ins = cn.prepareStatement(
                            "INSERT INTO carrito (usuario_id,producto_id,cantidad) VALUES (?,?,?)")) {
                        ins.setInt(1, usuarioId);
                        ins.setInt(2, productoId);
                        ins.setInt(3, cantidad);
                        ins.executeUpdate();
                    }
                }
            }
        }
    }

    public void eliminar(int carritoId) throws SQLException {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM carrito WHERE id=?")) {
            ps.setInt(1, carritoId);
            ps.executeUpdate();
        }
    }

    public void vaciar(int usuarioId) throws SQLException {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM carrito WHERE usuario_id=?")) {
            ps.setInt(1, usuarioId);
            ps.executeUpdate();
        }
    }

    public int contarItems(int usuarioId) throws SQLException {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(
                     "SELECT COALESCE(SUM(cantidad),0) FROM carrito WHERE usuario_id=?")) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
}
