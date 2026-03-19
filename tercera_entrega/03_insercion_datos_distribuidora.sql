/* ============================================
   SCRIPT 02 - INSERCIÓN DE DATOS
   PROYECTO DISTRIBUIDORA
============================================ */

/* LOCALIDADES */
INSERT INTO localidades VALUES
(1, 'Paraná', 'Entre Ríos'),
(2, 'Santa Fe', 'Santa Fe'),
(3, 'Córdoba', 'Córdoba');


/* CATEGORIAS */
INSERT INTO categorias VALUES
(1, 'Bebidas', 'Productos líquidos para consumo'),
(2, 'Alimentos', 'Productos comestibles'),
(3, 'Limpieza', 'Productos de higiene y limpieza');


/* PROVEEDORES */
INSERT INTO proveedores VALUES
(1, 'Coca Cola Distribuidora', '3435551111', 'contacto@coca.com'),
(2, 'Molinos Río de la Plata', '3435552222', 'ventas@molinos.com'),
(3, 'Procter & Gamble', '3435553333', 'info@pg.com');


/* VENDEDORES */
INSERT INTO vendedores VALUES
(1, 'Juan', 'Pérez', '3434441111', 1),
(2, 'Lucía', 'Gómez', '3434442222', 1);


/* CLIENTES */
INSERT INTO clientes VALUES
(1, 'Carlos', 'Ramírez', '3435558888', 'carlos@mail.com', 1),
(2, 'Supermercado', 'La Economía SRL', '3435559999', 'contacto@economia.com', 2);


/* ESTADOS PEDIDO */
INSERT INTO estados_pedido VALUES
(1, 'Pendiente'),
(2, 'Pagado'),
(3, 'Entregado');


/* FORMAS DE PAGO */
INSERT INTO formas_pago VALUES
(1, 'Efectivo'),
(2, 'Transferencia'),
(3, 'Tarjeta');


/* ARTICULOS */
INSERT INTO articulos VALUES
(1, 'Coca Cola 2L', 1500.00, 100, 1, 1),
(2, 'Harina 000', 800.00, 200, 2, 2),
(3, 'Detergente', 1200.00, 50, 3, 3);


/* PEDIDOS */
INSERT INTO pedidos VALUES
(1, '2025-06-01', 1, 1, 1, 2, 0),
(2, '2025-06-02', 2, 2, 2, 1, 0);


/* DETALLE PEDIDO */
INSERT INTO detalle_pedido VALUES
(1, 1, 1, 5, 1500.00),
(2, 1, 2, 10, 800.00),
(3, 2, 3, 3, 1200.00);