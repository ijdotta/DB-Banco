-- Creación de la base de datos:
CREATE DATABASE banco;
USE banco

-- TABLAS:

-- USUARIOS:

-- Eliminar usuario vacío
DROP USER ''@'localhost';
#-------------------------------------------------------------------------
# Creación Tablas para las entidades

CREATE TABLE extraccion(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 nro_cliente INT UNSIGNED(5) NOT NULL, 
 nro_ca INT UNSIGNED(8) NOT NULL,
 
 CONSTRAINT pk_extraccion
 PRIMARY KEY (nro_trans),
 
 CONSTRAINT FK_extraccion_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_extraccion_cliente_ca
 FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca (nro_cliente, nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;


CREATE TABLE transferencia(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 nro_cliente INT UNSIGNED(5) NOT NULL, 
 origen INT UNSIGNED(8) NOT NULL,
 destino INT UNSIGNED(8) NOT NULL,
 
 CONSTRAINT pk_transferencia 
 PRIMARY KEY (nro_trans),
 
 CONSTRAINT FK_transferencia_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_transferencia_cliente
 FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_transferencia_origen 
 FOREIGN KEY (origen) REFERENCES caja_ahorro (nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_transferencia_destino
 FOREIGN KEY (destino) REFERENCES caja_ahorro (nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
 
) ENGINE=InnoDB;