# SQL_Angeletti
Base de Datos en SQL para empresa de seguridad


La base de datos se remite a una empresa de seguridad , donde existen procesos y tareas que pueden solucionarse o eficientizar con ayuda de SQL. Esta empresa actualiza los precios de sus servicios de acuerdo con cómo se estipule en cada contrato, pero el caso más común es según la actualización de paritarias del sector (existen y se utilizan 4 convenios diferentes según zonas geográficas). 
A su vez, cada servicio esta compuesto por más de un recurso, de modo que los mismos se categorizan en abono, valor hora de guardia, servicio de patrulla, soluciones de seguridad, garita, generador, etc. Además, es necesario contabilizar la cantidad de horas para que cada valor unitario se convierta en un valor final.

El proyecto consiste en crear una base de datos que contenga toda la información concatenada, ya que actualmente se encuentra dispersa en distintos archivos, para poder de esta manera generar reportes sobre cada cliente que contemplen tanto sus costos asociados, como su precio actual, adjudicando la responsabilidad a un supervisor y/o facturador y logrando así una mejor dinámica de resolución de problemas. La idea central y primordial es llevar un control del cliente en su totalidad para mantener los márgenes de rentabilidad con los que inicialmente se cotizó el servicio. Este control es muy importante debido a que la actualización de valores no es automática y depende de un acuerdo paritario. 

# 📋 Listado de Tablas y Descripción Detallada

---

## **1. clientes**
**Descripción:**  
Contiene la información básica de cada cliente de la empresa de seguridad, incluyendo sus datos de contacto y localización.

| Abreviatura   | Nombre completo              | Tipo de dato       | Tipo de clave | Descripción |
|---------------|------------------------------|--------------------|---------------|-------------|
| id_cliente    | Identificador de cliente     | INT AUTO_INCREMENT | PK            | Identificador único de cada cliente. |
| nombre_cliente| Nombre del cliente           | VARCHAR(100)       |               | Nombre legal o comercial del cliente. |
| cc            | Centro de costos             | VARCHAR(50)        |               | Código interno del centro de costos asignado al cliente. |
| email         | Correo electrónico           | VARCHAR(100)       |               | Dirección de email de contacto del cliente. |
| telefono      | Teléfono                     | VARCHAR(20)        |               | Número de teléfono del cliente. |
| representante | Representante comercial      | VARCHAR(100)       |               | Persona de contacto principal del cliente. |
| provincia     | Provincia                    | VARCHAR(50)        |               | Provincia donde se ubica el cliente. |

---

## **2. responsables**
**Descripción:**  
Registra los distintos responsables asociados a un cliente, diferenciando sus roles (comercial, operativo y administrativo).

| Abreviatura   | Nombre completo              | Tipo de dato       | Tipo de clave | Descripción |
|---------------|------------------------------|--------------------|---------------|-------------|
| id_responsable| Identificador de responsable | INT AUTO_INCREMENT | PK            | Identificador único del registro. |
| id_cliente    | Identificador de cliente     | INT                | FK            | Relaciona al responsable con un cliente en la tabla `clientes`. |
| negociador    | Responsable comercial        | VARCHAR(100)       |               | Persona encargada de las negociaciones con el cliente. |
| supervisor    | Supervisor operativo         | VARCHAR(100)       |               | Persona que supervisa las operaciones para el cliente. |
| facturador    | Responsable de facturación   | VARCHAR(100)       |               | Persona encargada de la facturación para el cliente. |

---

## **3. provincias**
**Descripción:**  
Contiene el listado de provincias donde opera la empresa, asegurando que los nombres sean únicos.

| Abreviatura      | Nombre completo           | Tipo de dato       | Tipo de clave | Descripción |
|------------------|---------------------------|--------------------|---------------|-------------|
| id_provincia     | Identificador de provincia| INT AUTO_INCREMENT | PK            | Identificador único de la provincia. |
| nombre_provincia | Nombre de la provincia    | VARCHAR(50)        | UNIQUE        | Nombre único de la provincia. |

---

## **4. actualizacion_precios**
**Descripción:**  
Registra las actualizaciones de precios de los servicios según la provincia y el tipo de ajuste salarial o contractual.

| Abreviatura      | Nombre completo                  | Tipo de dato       | Tipo de clave | Descripción |
|------------------|----------------------------------|--------------------|---------------|-------------|
| id_actualizacion | Identificador de actualización   | INT AUTO_INCREMENT | PK            | Identificador único del ajuste. |
| id_provincia     | Identificador de provincia       | INT                | FK            | Relaciona el ajuste con la provincia (tabla `provincias`). |
| CCT              | Convenio colectivo de trabajo    | VARCHAR(50)        |               | Tipo de convenio aplicable (guardias, etc.). |
| ajuste           | Tipo de ajuste                   | VARCHAR(50)        |               | Tipo de ajuste (ej: conformado, polinómica, apertura). |
| tipo_servicio    | Tipo de servicio                 | VARCHAR(100)       |               | Servicio afectado por el ajuste (guardia, patrulla, etc.). |

---

## **5. servicios**
**Descripción:**  
Lista los servicios que cada cliente contrata, incluyendo su tipo y el precio con y sin IVA.

| Abreviatura     | Nombre completo               | Tipo de dato       | Tipo de clave | Descripción |
|-----------------|--------------------------------|--------------------|---------------|-------------|
| id_servicio     | Identificador de servicio     | INT AUTO_INCREMENT | PK            | Identificador único del servicio. |
| id_cliente      | Identificador de cliente      | INT                | FK            | Relaciona el servicio con el cliente (tabla `clientes`). |
| tipo_servicio   | Tipo de servicio              | VARCHAR(100)       |               | Descripción del servicio (guardia fija, patrulla, etc.). |
| precio_sin_iva  | Precio sin IVA                | DECIMAL(10,2)      |               | Valor del servicio sin impuestos. |
| precio_con_iva  | Precio con IVA                | DECIMAL(10,2)      |               | Valor del servicio con IVA incluido. |

---

## **6. costos_asociados**
**Descripción:**  
Registra los costos adicionales relacionados con cada cliente y centro de costos, desglosando recursos, cantidad y valores.

| Abreviatura     | Nombre completo               | Tipo de dato       | Tipo de clave | Descripción |
|-----------------|--------------------------------|--------------------|---------------|-------------|
| id_costo        | Identificador de costo        | INT AUTO_INCREMENT | PK            | Identificador único del costo. |
| id_cliente      | Identificador de cliente      | INT                | FK            | Relaciona el costo con el cliente (tabla `clientes`). |
| cc              | Centro de costos              | VARCHAR(50)        |               | Código de centro de costos del cliente. |
| recurso         | Recurso                       | VARCHAR(100)       |               | Elemento o servicio que genera el costo (guardia, patrulla, generador, etc.). |
| cantidad_horas  | Cantidad de horas             | INT                |               | Número de horas asociadas al recurso. |
| valor_unitario  | Valor unitario                | DECIMAL(10,2)      |               | Precio unitario por hora o recurso. |
| valor_total     | Valor total                   | DECIMAL(10,2)      |  

Indice

[Creación base de datos](empresa_seguridad.sql)

[Creación de las tablas](empresa_seguridad.sql)

[Diagrama](ERD.png)
