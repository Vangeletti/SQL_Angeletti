# SQL_Angeletti
Base de Datos en SQL para empresa de seguridad 

La base de datos se remite a una empresa de seguridad , donde existen procesos y tareas que pueden solucionarse o eficientizar con ayuda de SQL. Esta empresa actualiza los precios de sus servicios de acuerdo con cómo se estipule en cada contrato, pero el caso más común es según la actualización de paritarias del sector (existen y se utilizan 4 convenios diferentes según zonas geográficas). 

A su vez, cada servicio esta compuesto por más de un recurso, de modo que los mismos se categorizan en abono, valor hora de guardia, servicio de patrulla, soluciones de seguridad, garita, generador, etc. Además, es necesario contabilizar la cantidad de horas para que cada valor unitario se convierta en un valor final.
El proyecto consiste en crear una base de datos que contenga toda la información concatenada, ya que actualmente se encuentra dispersa en distintos archivos, para poder de esta manera generar reportes sobre cada cliente que contemplen tanto sus costos asociados, como su precio actual, adjudicando la responsabilidad a un supervisor y/o facturador y logrando así una mejor dinámica de resolución de problemas. La idea central y primordial es llevar un control del cliente en su totalidad para mantener los márgenes de rentabilidad con los que inicialmente se cotizó el servicio. Este control es muy importante debido a que la actualización de valores no es automática y depende de un acuerdo paritario. 

 La primera tabla hace referencia a la información del cliente y de contacto. Su clave primaria será el nombre del cliente (id_cliente). Luego se incorporan los siguientes campos:
•	Centro de Costos (cc)
•	Correo (email)
•	Teléfono de contacto (teléfono)
•	Nombre del contacto (representante)
•	Provincia (provincia)

La segunda tabla concentra todos los responsables de las distintas áreas de la empresa que tienen a cargo el cliente en cuestión. Los campos de esta tabla serian:
•	Responsable comercial (negociador)
•	Supervisor Operativo (supervisor)
•	Facturador/a (facturador)

La tercer tabla hace referencia a la información de actualización del precio del cliente. Su clave foránea es la provincia  y luego sus campos son:
•	Convenio de guardias pertenecientes a ese servicio (CCT)
•	Tipo de ajuste, ya que existe conformado, polinómica y apertura de costos (ajuste)
•	Tipo de servicio 

Cuarta tabla: resume en una misma el tipo de servicio con sus respectivos precios.
•	Cliente
•	Tipo de servicio 
•	Precio s/iva
•	Precio c/iva

Para el desarrollo de la entrega final se pensó en una quinta tabla que contemplara los costos asociados del servicio que se atribuyen al cliente y a su centro de costos en particular. 
