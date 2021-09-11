-- Creación de la base de datos:
CREATE DATABASE banco;
USE banco

-- TABLAS:

-- USUARIOS:

-- Eliminar usuario vacío
DROP USER ''@'localhost';
#-------------------------------------------------------------------------
# Creación Tablas para las entidades

CREATE TABLE transaccion(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 fecha DATE NOT NULL,
 hora TIME NOT NULL,
 monto DECIMAL(9,2) NOT NULL,
 
 CONSTRAINT pk_transaccion
 PRIMARY KEY (nro_trans),
 
) ENGINE=InnoDB;


CREATE TABLE debito(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 descripcion VARCHAR(69) NOT NULL,
 nro_cliente INT UNSIGNED(5) NOT NULL,
 nro_ca INT UNSIGNED(8) NOT NULL,
 
 CONSTRAINT pk_debito
 PRIMARY KEY (nro_trans),

 CONSTRAINT FK_debito_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion(nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
  
 CONSTRAINT FK_debito_cliente
 FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_debito_caja_ahorro
 FOREIGN KEY (nro_ca) REFERENCES caja_ahorro (nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
 
) ENGINE=InnoDB;


CREATE TABLE transaccion_por_caja(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 cod_caja INT UNSIGNED(5) NOT NULL,
 
 CONSTRAINT pk_transaccion_por_caja
 PRIMARY KEY (nro_trans),
 
 CONSTRAINT FK_transaccion_por_caja_transaccion
 FOREIGN KEY (nro_trans) REFERENCES transaccion (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_transaccion_por_caja_caja_ahorro
 FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
 
) ENGINE=InnoDB;

CREATE TABLE deposito(
 nro_trans INT UNSIGNED(10) NOT NULL, 
 nro_ca INT UNSIGNED(8) NOT NULL,
 
 CONSTRAINT pk_deposito
 PRIMARY KEY (nro_trans),

 CONSTRAINT FK_deposito_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_deposito_caja_ahorro
 FOREIGN KEY (nro_ca) REFERENCES caja_ahorro (nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
 
) ENGINE=InnoDB;


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