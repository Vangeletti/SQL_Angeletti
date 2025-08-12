-- Crear la base de datos
CREATE DATABASE empresa_seguridad;
USE empresa_seguridad;

-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    cc VARCHAR(50), -- Centro de costos
    email VARCHAR(100),
    telefono VARCHAR(20),
    representante VARCHAR(100),
    provincia VARCHAR(50) NOT NULL
);
SELECT * FROM empresa_seguridad.clientes; 

-- Tabla de responsables
CREATE TABLE responsables (
    id_responsable INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    negociador VARCHAR(100),  -- Responsable comercial
    supervisor VARCHAR(100),  -- Supervisor operativo
    facturador VARCHAR(100),  -- Facturador/a
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
SELECT * FROM empresa_seguridad.responsables;
CREATE TABLE provincias (
    id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nombre_provincia VARCHAR(50) NOT NULL UNIQUE
);
-- Tabla de información de actualización de precios
-- Relacionada con provincia del cliente
CREATE TABLE actualizacion_precios (
    id_actualizacion INT AUTO_INCREMENT PRIMARY KEY,
    id_provincia INT NOT NULL,
    CCT VARCHAR(50), -- Convenio de guardias
    ajuste VARCHAR(50), -- Tipo de ajuste (conformado, polinómica, apertura)
    tipo_servicio VARCHAR(100),
    FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
);

-- Tabla de servicios con sus precios
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_servicio VARCHAR(100) NOT NULL,
    precio_sin_iva DECIMAL(10,2),
    precio_con_iva DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla de costos asociados por cliente y centro de costos
CREATE TABLE costos_asociados (
    id_costo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    cc VARCHAR(50), -- Centro de costos del cliente
    recurso VARCHAR(100), -- Ej: valor hora guardia, patrulla, garita, generador
    cantidad_horas INT,
    valor_unitario DECIMAL(10,2),
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
