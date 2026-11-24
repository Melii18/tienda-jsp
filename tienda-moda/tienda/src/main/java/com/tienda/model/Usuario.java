package com.tienda.model;

public class Usuario {
    private int id;
    private String nombre;
    private String email;
    private String password;
    private String rol;

    public Usuario() {}

    public int getId()                       { return id; }
    public void setId(int id)                { this.id = id; }

    public String getNombre()                { return nombre; }
    public void setNombre(String nombre)     { this.nombre = nombre; }

    public String getEmail()                 { return email; }
    public void setEmail(String email)       { this.email = email; }

    public String getPassword()              { return password; }
    public void setPassword(String pw)       { this.password = pw; }

    public String getRol()                   { return rol; }
    public void setRol(String rol)           { this.rol = rol; }

    public boolean isAdmin()                 { return "admin".equals(rol); }
}
