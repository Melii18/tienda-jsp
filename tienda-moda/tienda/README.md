# TIENDA MODA&Co — Proyecto JSP + MySQL

Tienda online de ropa y accesorios construida con **Java Servlets + JSP + MySQL**.

---

## 📁 Estructura del proyecto

```
tienda/
├── pom.xml                         ← Dependencias Maven
├── sql/
│   └── tienda_db.sql               ← Script de base de datos
└── src/main/
    ├── java/com/tienda/
    │   ├── dao/
    │   │   ├── DBConnection.java   ← Conexión MySQL
    │   │   ├── ProductoDAO.java    ← CRUD productos
    │   │   ├── UsuarioDAO.java     ← Login / registro
    │   │   └── CarritoDAO.java     ← Gestión carrito
    │   ├── model/
    │   │   ├── Producto.java
    │   │   └── Usuario.java
    │   └── servlet/
    │       ├── ProductoServlet.java  ← /productos, /producto
    │       ├── AuthServlet.java      ← /login, /registro, /logout
    │       └── CarritoServlet.java   ← /carrito
    └── webapp/
        ├── index.jsp               ← Página de inicio + hero
        ├── css/estilos.css         ← Estilos (tema luxury editorial)
        ├── js/app.js               ← Interactividad JS
        └── WEB-INF/
            ├── web.xml
            ├── includes/
            │   ├── header.jsp      ← Navbar reutilizable
            │   └── footer.jsp
            └── views/
                ├── catalogo.jsp    ← Listado con filtros
                ├── detalle.jsp     ← Detalle del producto
                ├── carrito.jsp     ← Carrito de compras
                ├── login.jsp
                ├── registro.jsp
                └── error.jsp
```

---

## ⚙️ Requisitos

| Herramienta | Versión mínima |
|-------------|----------------|
| Java JDK    | 11             |
| Apache Tomcat | 9 o 10       |
| MySQL       | 8.x            |
| Maven       | 3.8+           |

---

## 🚀 Pasos para ejecutar

### 1. Crear la base de datos

```sql
-- En MySQL Workbench o terminal:
source sql/tienda_db.sql
```

### 2. Configurar la conexión

Abre `src/main/java/com/tienda/dao/DBConnection.java` y ajusta:

```java
private static final String URL      = "jdbc:mysql://localhost:3306/tienda_moda?...";
private static final String USER     = "root";
private static final String PASSWORD = "tu_password";
```

### 3. Compilar y desplegar

```bash
mvn clean package
# Copia el WAR generado a Tomcat:
cp target/tienda-moda-1.0.war $TOMCAT_HOME/webapps/
# Inicia Tomcat
$TOMCAT_HOME/bin/startup.sh
```

### 4. Abrir en el navegador

```
http://localhost:8080/tienda-moda/
```

---

## 🔑 Credenciales de prueba

| Rol   | Email                    | Contraseña |
|-------|--------------------------|------------|
| Admin | admin@tiendamoda.com     | admin123   |

---

## 📋 Páginas disponibles

| URL                  | Descripción                    |
|----------------------|--------------------------------|
| `/`                  | Inicio con hero y destacados   |
| `/productos`         | Catálogo completo              |
| `/productos?q=texto` | Búsqueda                       |
| `/productos?cat=1`   | Filtro por categoría           |
| `/producto?id=N`     | Detalle del producto           |
| `/carrito`           | Carrito de compras             |
| `/login`             | Iniciar sesión                 |
| `/registro`          | Crear cuenta                   |
| `/logout`            | Cerrar sesión                  |

---

## 🎨 Identidad visual

- **Paleta**: Negro profundo `#0f0e0d`, Crema `#f7f3ee`, Oro `#c9a84c`
- **Tipografía**: Playfair Display (display) + DM Sans (cuerpo)
- **Estética**: Luxury Editorial — elegante, oscura y sofisticada

---

> ⚠️ **Nota de seguridad**: Este proyecto usa MD5 para contraseñas por simplicidad académica.
> En producción siempre usa **BCrypt** u otro algoritmo seguro.
