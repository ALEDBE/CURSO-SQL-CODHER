USE distribuidora;

   -- VISTAS


CREATE VIEW vw_detalle_pedidos AS
SELECT 
    p.id_pedido,
    p.fecha_pedido,
    c.nombre,
    c.apellido_razon_social,
    a.nombre AS articulo,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
INNER JOIN articulos a ON dp.id_articulo = a.id_articulo;

CREATE VIEW vw_stock_articulos AS
SELECT 
    a.id_articulo,
    a.nombre,
    c.nombre_categoria,
    a.stock
FROM articulos a
INNER JOIN categorias c 
ON a.id_categoria = c.id_categoria;

CREATE VIEW vw_total_pedidos_por_cliente AS
SELECT 
    c.id_cliente,
    c.nombre,
    c.apellido_razon_social,
    SUM(dp.cantidad * dp.precio_unitario) AS total_comprado
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.id_cliente, c.nombre, c.apellido_razon_social;

-- FUNCIONES 
DELIMITER //

CREATE FUNCTION fn_calcular_subtotal(
    p_cantidad INT,
    p_precio DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_cantidad * p_precio;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION fn_total_pedido(
    p_id_pedido INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);

    SELECT SUM(cantidad * precio_unitario)
    INTO total
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    RETURN IFNULL(total,0);
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_stock_disponible(
    p_id_articulo INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock_actual INT;

    SELECT stock
    INTO stock_actual
    FROM articulos
    WHERE id_articulo = p_id_articulo;

    RETURN stock_actual;
END //

DELIMITER ;

-- STORED PROCEDURES
DELIMITER //

CREATE PROCEDURE sp_actualizar_stock(
    IN p_id_articulo INT,
    IN p_nuevo_stock INT
)
BEGIN
    UPDATE articulos
    SET stock = p_nuevo_stock
    WHERE id_articulo = p_id_articulo;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_reporte_pedidos_por_fecha(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT *
    FROM pedidos
    WHERE fecha_pedido 
    BETWEEN p_fecha_inicio AND p_fecha_fin;
END //

DELIMITER ;

-- TRIGGERS

-- Trigger 1: Descontar stock al registrar detalle

DELIMITER //

CREATE TRIGGER tr_descontar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE articulos
    SET stock = stock - NEW.cantidad
    WHERE id_articulo = NEW.id_articulo;
END //

DELIMITER ;

-- Trigger 2: Evitar stock negativo

DELIMITER //

CREATE TRIGGER tr_evitar_stock_negativo
BEFORE UPDATE ON articulos
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente';
    END IF;
END //

DELIMITER ;



