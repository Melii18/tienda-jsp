package com.tienda.model;

import java.math.BigDecimal;

public class Producto {
    private int id;
    private String nombre;
    private String descripcion;
    private BigDecimal precio;
    private int stock;
    private String imagenUrl;
    private int categoriaId;
    private String categoriaNombre;
    private boolean destacado;

    public Producto() {}

    // ── Getters & Setters ─────────────────────────────────────
    public int getId()                         { return id; }
    public void setId(int id)                  { this.id = id; }

    public String getNombre()                  { return nombre; }
    public void setNombre(String nombre)       { this.nombre = nombre; }

    public String getDescripcion()             { return descripcion; }
    public void setDescripcion(String d)       { this.descripcion = d; }

    public BigDecimal getPrecio()              { return precio; }
    public void setPrecio(BigDecimal precio)   { this.precio = precio; }

    public int getStock()                      { return stock; }
    public void setStock(int stock)            { this.stock = stock; }

    public String getImagenUrl()               { return imagenUrl; }
    public void setImagenUrl(String url)       { this.imagenUrl = url; }

    public int getCategoriaId()                { return categoriaId; }
    public void setCategoriaId(int cid)        { this.categoriaId = cid; }

    public String getCategoriaNombre()         { return categoriaNombre; }
    public void setCategoriaNombre(String cn)  { this.categoriaNombre = cn; }

    public boolean isDestacado()               { return destacado; }
    public void setDestacado(boolean d)        { this.destacado = d; }
}
