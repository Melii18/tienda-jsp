-- ============================================================
--  TIENDA MODA -- Base de datos MySQL
-- ============================================================

CREATE DATABASE IF NOT EXISTS tienda_moda
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tienda_moda;

-- ─── CATEGORÍAS ──────────────────────────────────────────────
CREATE TABLE categorias (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255),
  imagen_url  VARCHAR(255)
) ENGINE=InnoDB;

-- ─── PRODUCTOS ───────────────────────────────────────────────
CREATE TABLE productos (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(150) NOT NULL,
  descripcion  TEXT,
  precio       DECIMAL(10,2) NOT NULL,
  stock        INT          NOT NULL DEFAULT 0,
  imagen_url   VARCHAR(255),
  categoria_id INT,
  destacado    TINYINT(1)   DEFAULT 0,
  creado_en    DATETIME     DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
) ENGINE=InnoDB;

-- ─── USUARIOS ────────────────────────────────────────────────
CREATE TABLE usuarios (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  email        VARCHAR(150) NOT NULL UNIQUE,
  password     VARCHAR(255) NOT NULL,
  rol          ENUM('cliente','admin') DEFAULT 'cliente',
  creado_en    DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ─── PEDIDOS ─────────────────────────────────────────────────
CREATE TABLE pedidos (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT NOT NULL,
  total        DECIMAL(10,2) NOT NULL,
  estado       ENUM('pendiente','procesando','enviado','entregado','cancelado') DEFAULT 'pendiente',
  direccion    VARCHAR(300),
  creado_en    DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- ─── DETALLE PEDIDO ──────────────────────────────────────────
CREATE TABLE detalle_pedido (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id   INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad    INT NOT NULL,
  precio_unit DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (pedido_id)   REFERENCES pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
) ENGINE=InnoDB;

-- ─── CARRITO (sesión persistente) ───────────────────────────
CREATE TABLE carrito (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id  INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad    INT NOT NULL DEFAULT 1,
  agregado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id)  REFERENCES usuarios(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
) ENGINE=InnoDB;

-- ─── DATOS DE PRUEBA ─────────────────────────────────────────
INSERT INTO categorias (nombre, descripcion, imagen_url) VALUES
('Camisas',    'Camisas y blusas para todas las ocasiones', 'img_cat_camisas.jpg'),
('Pantalones', 'Jeans, chinos y más',                       'img_cat_pantalones.jpg'),
('Vestidos',   'Vestidos casuales y de gala',               'img_cat_vestidos.jpg'),
('Accesorios', 'Bolsos, cinturones y joyería',              'img_cat_accesorios.jpg'),
('Calzado',    'Zapatos, sandalias y botas',                'img_cat_calzado.jpg');

INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url, categoria_id, destacado) VALUES
('Camisa Lino Premium',   'Camisa de lino 100% fresca y elegante', 89900,  50, 'p1.jpg', 1, 1),
('Blusa Floral Off',      'Blusa con estampado floral moderno',     65000,  30, 'p2.jpg', 1, 0),
('Jean Slim Fit',         'Jean elastizado corte slim',             129900, 40, 'p3.jpg', 2, 1),
('Pantalón Chino Beige',  'Chino de algodón clásico',               95000,  25, 'p4.jpg', 2, 0),
('Vestido Midi Negro',    'Vestido midi elegante para toda ocasión',145000, 20, 'p5.jpg', 3, 1),
('Vestido Casual Rayas',  'Fresco vestido de verano a rayas',        78000, 35, 'p6.jpg', 3, 0),
('Bolso Cuero Tote',      'Bolso de cuero genuino con correa',      199000, 15, 'p7.jpg', 4, 1),
('Cinturón Trenzado',     'Cinturón trenzado artesanal',             45000, 60, 'p8.jpg', 4, 0),
('Zapatillas Canvas',     'Zapatillas de lona cómodas y versátiles', 89000, 45, 'p9.jpg', 5, 1),
('Botas Chelsea',         'Botas Chelsea de cuero sintético',       175000, 18, 'p10.jpg',5, 0);

-- Admin por defecto  (password: admin123 — en prod usar hash)
INSERT INTO usuarios (nombre, email, password, rol) VALUES
('Administrador', 'admin@tiendamoda.com', MD5('admin123'), 'admin');
