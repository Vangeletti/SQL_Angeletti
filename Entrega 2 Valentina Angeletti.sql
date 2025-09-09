-- CREACIÓN DE VISTAS
CREATE VIEW vista_clientes_servicios AS
SELECT 
    c.id_cliente,
    c.nombre_cliente,
    s.tipo_servicio,
    s.precio_sin_iva,
    s.precio_con_iva
FROM clientes c
JOIN servicios s ON c.id_cliente = s.id_cliente;

CREATE VIEW vista_costos_totales AS
SELECT 
    c.nombre_cliente,
    ca.cc,
    ca.recurso,
    ca.cantidad_horas,
    ca.valor_unitario,
    ca.valor_total
FROM clientes c
JOIN costos_asociados ca ON c.id_cliente = ca.id_cliente;

-- CREACIÓN DE FUNCIONES
DELIMITER $$
CREATE FUNCTION calcular_precio_total_cliente(idCliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(precio_con_iva) INTO total
    FROM servicios
    WHERE id_cliente = idCliente;
    RETURN total;
END $$
DELIMITER ;

-- CREACIÓN DE STORED PROCEDURES
DELIMITER $$
CREATE PROCEDURE insertar_servicio (
    IN idCliente INT,
    IN tipoServicio VARCHAR(100),
    IN precioSinIVA DECIMAL(10,2)
)
BEGIN
    DECLARE precioConIVA DECIMAL(10,2);
    SET precioConIVA = precioSinIVA * 1.21;

    INSERT INTO servicios (id_cliente, tipo_servicio, precio_sin_iva, precio_con_iva)
    VALUES (idCliente, tipoServicio, precioSinIVA, precioConIVA);
END $$
DELIMITER ;

-- CREACIÓN DE TRIGGERS
DELIMITER $$
CREATE TRIGGER trg_calcular_valor_total
BEFORE INSERT ON costos_asociados
FOR EACH ROW
BEGIN
    SET NEW.valor_total = NEW.cantidad_horas * NEW.valor_unitario;
END $$
DELIMITER ;

CREATE TABLE auditoria_precios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT NOT NULL,
    precio_sin_iva_viejo DECIMAL(10,2),
    precio_sin_iva_nuevo DECIMAL(10,2),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(100) DEFAULT NULL
);

DELIMITER $$

CREATE TRIGGER trg_auditar_cambios_precio_sin_iva
BEFORE UPDATE ON servicios
FOR EACH ROW
BEGIN
    IF OLD.precio_sin_iva <> NEW.precio_sin_iva THEN
        INSERT INTO auditoria_precios (
            id_servicio,
            precio_sin_iva_viejo,
            precio_sin_iva_nuevo,
            fecha_modificacion,
            usuario_modificacion)
            VALUES (
            OLD.id_servicio,
            OLD.precio_sin_iva,
            NEW.precio_sin_iva,
            NOW()
       ); 
       END IF;
END$$

DELIMITER ;

-- UPDATE servicios
-- SET 
    -- id_cliente = 1,  -- Suponiendo que este cliente existe
    -- tipo_servicio = 'Nuevo Servicio',  -- El tipo de servicio actual
   -- precio_sin_iva = 220000.00,
    -- precio_con_iva = 220000.00 * 1.21  -- Calculamos el precio con IVA
-- WHERE id_servicio = 1;
-- SELECT * from servicios; 

SELECT 
    id_auditoria,
    id_servicio,
    precio_sin_iva_viejo,
    precio_sin_iva_nuevo,
    fecha_modificacion,
    usuario_modificacion
FROM auditoria_precios
ORDER BY fecha_modificacion DESC;