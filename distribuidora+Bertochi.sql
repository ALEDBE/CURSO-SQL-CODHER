-- Base de datos: Distribuidora
-- Proyecto Final - Entrega 1
-- ============================================

CREATE DATABASE distribuidora;
USE distribuidora;


-- Tabla: Localidades

CREATE TABLE localidades (
    id_localidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_localidad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL
);


-- Tabla: Clientes

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_razon_social VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(50),
    id_localidad INT,
    FOREIGN KEY (id_localidad) REFERENCES localidades(id_localidad)
);


-- Tabla: Vendedores

CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
   mail VARCHAR(20)
);


-- Tabla: Categorias

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100)
);


-- Tabla: Proveedores

CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(50)
);


-- Tabla: Articulos

CREATE TABLE articulos (
    id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    id_proveedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);


-- Tabla: Formas_Pago

CREATE TABLE formas_pago (
    id_forma_pago INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);


-- Tabla: Estados_Pedido

CREATE TABLE estados_pedido (
    id_estado_pedido INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);


-- Tabla: Pedidos

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    id_cliente INT,
    id_vendedor INT,
    id_forma_pago INT,
    id_estado_pedido INT,
    total DECIMAL(12,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_forma_pago) REFERENCES formas_pago(id_forma_pago),
    FOREIGN KEY (id_estado_pedido) REFERENCES estados_pedido(id_estado_pedido)
);


-- Tabla: Detalle_Pedido

CREATE TABLE detalle_pedido (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_articulo INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_articulo) REFERENCES articulos(id_articulo)
);

