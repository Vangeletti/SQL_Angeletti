USE empresa_seguridad;


-- 1. Provincias
INSERT INTO provincias (nombre_provincia) VALUES
('Buenos Aires'),
('Córdoba'),
('Santa Fe'),
('Mendoza'),
('Neuquén');

-- 2. Clientes (Empresas de diferentes rubros)

INSERT INTO clientes (nombre_cliente, cc, email, telefono, representante, provincia) VALUES
('Frigorífico Patagonia S.A.', 'CC001', 'contacto@patagoniafrigo.com', '2901-123456', 'María López', 'Santa Fe'),
('Hospital San José', 'CC002', 'admin@sanjosehospital.org', '351-4567890', 'Dr. Jorge Paz', 'Córdoba'),
('TechNova Software', 'CC003', 'rrhh@technova.io', '011-2223344', 'Valeria Duarte', 'Buenos Aires'),
('Logística Andina', 'CC004', 'info@logisticaandina.com.ar', '0261-7788990', 'Martín Ramírez', 'Mendoza'),
('AgroCampo S.R.L.', 'CC005', 'ventas@agrocampo.com.ar', '299-4433221', 'Laura González', 'Neuquén');

-- 3. Responsables (por cliente)

INSERT INTO responsables (id_cliente, negociador, supervisor, facturador) VALUES
(1, 'Juan Pérez', 'Carlos Méndez', 'Ana Rivas'),
(2, 'Lucía Torres', 'Roberto Aguirre', 'Natalia Peña'),
(3, 'Marcos Beltrán', 'Gisela Acosta', 'Ezequiel Duarte'),
(4, 'Esteban Molina', 'Tamara Vidal', 'Soledad Rey'),
(5, 'Cintia Díaz', 'Federico Bravo', 'Lucas Ramírez');


-- 4. Actualización de Precios (Convenios por provincia)

INSERT INTO actualizacion_precios (id_provincia, CCT, ajuste, tipo_servicio) VALUES
(1, 'CCT UPSRA', 'Conformado', 'Guardia'),
(2, 'CCT SSIP', 'Polinómica', 'Patrulla'),
(3, 'CCT UPSRA', 'Conformado', 'Garita'),
(4, 'CCT UPSAP', 'Apertura', 'Generador'),
(5, 'CCT UPSAP', 'Conformado', 'Monitoreo');


-- 5. Servicios (uso el stored procedure para insertar)

CALL insertar_servicio(1, 'Guardia Fija 24hs', 200000.00);
CALL insertar_servicio(2, 'Patrulla Nocturna', 150000.00);
CALL insertar_servicio(3, 'Monitoreo Remoto', 100000.00);
CALL insertar_servicio(4, 'Servicio de Garita', 180000.00);
CALL insertar_servicio(5, 'Guardia Diurna', 120000.00);

SELECT * FROM servicios WHERE tipo_servicio = 'Monitoreo Remoto';

-- 6. Costos Asociados (activa el trigger para calcular valor_total)

INSERT INTO costos_asociados (id_cliente, cc, recurso, cantidad_horas, valor_unitario, valor_total) VALUES
(1, 'CC001', 'Guardia', 240, 750.00, 0),
(2, 'CC002', 'Patrulla', 180, 820.00, 0),
(3, 'CC003', 'Operador CCTV', 160, 700.00, 0),
(4, 'CC004', 'Garita', 220, 760.00, 0),
(5, 'CC005', 'Guardia Diurna', 200, 680.00, 0);

SELECT * FROM vista_clientes_servicios;
SELECT * FROM vista_costos_totales;
