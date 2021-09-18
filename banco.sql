-- Creación de la base de datos:
CREATE DATABASE banco;
USE banco

-- USUARIOS:

-- Eliminar usuario vacío
DROP USER ''@'localhost';
#-------------------------------------------------------------------------
# Creación Tablas para las entidades

/*
    REEMPLAZAR LOS INT (y cualquier otro tipo de dato) POR EL DE MENOR REPRESENTACIÓN
    POSIBLE.
    Por ejemplo, si legajo tiene 4 cifras y TINY INT es suficiente, entonces no usar INT

    Type	Storage (Bytes)	Minimum Value Signed	Minimum Value Unsigned	Maximum Value Signed	Maximum Value Unsigned
    (Type, Bytes, Min_signed, Max_signed, min_unsigned, max_unsigned)
    TINYINT	1	-128	0	127	255
    SMALLINT	2	-32768	0	32767	65535
    MEDIUMINT	3	-8388608	0	8388607	16777215
    INT	4	-2147483648	0	2147483647	4294967295
    BIGINT	8	-263	0	263-1	264-1
*/

CREATE TABLE ciudad (
  cod_postal INT(4) UNSIGNED NOT NULL,
  nombre VARCHAR(20),

  CONSTRAINT pk_ciudad
  PRIMARY KEY (cod_postal)

) ENGINE=InnoDB;

CREATE TABLE sucursal (
  nro_suc INT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL,
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  horario VARCHAR(20) NOT NULL,
  cod_postal INT(4) UNSIGNED NOT NULL,

  CONSTRAINT pk_sucursal
  PRIMARY KEY (nro_suc),

  CONSTRAINT FK_sucursal_ciudad
  FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE empleado (
  legajo INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  apellido VARCHAR(20) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  tipo_doc VARCHAR(20) NOT NULL,
  nro_doc INT(8) UNSIGNED NOT NULL,
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  cargo VARCHAR(20) NOT NULL,
  password CHAR(32) NOT NULL,
  nro_suc INT(3) UNSIGNED NOT NULL,

  CONSTRAINT pk_empleado
  PRIMARY KEY (legajo),

  CONSTRAINT FK_empleado_sucursal
  FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cliente(
  nro_cliente INT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  apellido VARCHAR(20) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  tipo_doc VARCHAR(20) NOT NULL,
  nro_doc INT(8) UNSIGNED NOT NULL, -- es un natural?
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  fecha_nac DATE NOT NULL,

  CONSTRAINT pk_cliente
  PRIMARY KEY (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE plazo_fijo (
  nro_plazo INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  capital FLOAT(15, 2) NOT NULL DEFAULT 0,
  tasa_interes FLOAT(5, 2) NOT NULL DEFAULT 0,
  interes FLOAT(9, 2) NOT NULL DEFAULT 0,
  nro_suc INT(3) UNSIGNED NOT NULL,

  CONSTRAINT pk_plazo_fijo
  PRIMARY KEY (nro_plazo),

  CONSTRAINT FK_plazo_fijo_sucursal
  FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE tasa_plazo_fijo (
  periodo INT(3) UNSIGNED NOT NULL,
  monto_inf FLOAT(6, 2) NOT NULL DEFAULT 0,
  monto_sup FLOAT(15, 2) NOT NULL DEFAULT 0,
  tasa FLOAT(3, 2) NOT NULL DEFAULT 0,

  CONSTRAINT pk_tasa_plazo_fijo
  PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;

CREATE TABLE plazo_cliente (
  nro_plazo INT(8) UNSIGNED NOT NULL,
  nro_cliente INT(5) UNSIGNED NOT NULL,

  CONSTRAINT FK_plazo_cliente_plazo_fijo
  FOREIGN KEY (nro_plazo) REFERENCES plazo_fijo(nro_plazo)
     ON DELETE RESTRICT ON UPDATE RESTRICT,

  CONSTRAINT FK_plazo_cliente_cliente
  FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)
    ON DELETE RESTRICT ON UPDATE RESTRICT

) ENGINE=InnoDB;

CREATE TABLE prestamo (
  nro_prestamo INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  cant_meses INT(2) UNSIGNED NOT NULL,
  monto FLOAT(14, 2) NOT NULL DEFAULT 0, 
  tasa_interes FLOAT(3, 2) NOT NULL DEFAULT 0, 
  valor_cuota FLOAT(10, 2) NOT NULL DEFAULT 0, 
  legajo INT(4) UNSIGNED NOT NULL,
  nro_cliente INT(5) UNSIGNED NOT NULL,

  CONSTRAINT pk_prestamo
  PRIMARY KEY (nro_prestamo),

  CONSTRAINT FK_prestamo_empleado
  FOREIGN KEY (legajo) REFERENCES empleado(legajo)
    ON DELETE RESTRICT ON UPDATE CASCADE,

  CONSTRAINT FK_plazo_cliente_cliente
  FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)
    ON DELETE RESTRICT ON UPDATE CASCADE
  
) ENGINE=InnoDB;

CREATE TABLE pago (
  nro_prestamo INT(8) UNSIGNED NOT NULL,
  nro_pago INT(2) UNSIGNED NOT NULL,

  CONSTRAINT pk_pago
  PRIMARY KEY (nro_pago),

  CONSTRAINT FK_pago_prestamo
  FOREIGN KEY (nro_prestamo) REFERENCES prestamo(nro_prestamo)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE tasa_prestamo (
  periodo INT(3) UNSIGNED NOT NULL,
  monto_inf FLOAT(10, 2) NOT NULL DEFAULT 0, 
  monto_sup FLOAT(15, 2) NOT NULL DEFAULT 0, 
  tasa FLOAT(5, 2) NOT NULL DEFAULT 0, 

  CONSTRAINT pk_tasa_prestamo
  PRIMARY KEY (periodo, monto_inf, monto_sup)
  
) ENGINE=InnoDB;

CREATE TABLE caja_ahorro (
  nro_ca INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  cbu INT(18) UNSIGNED NOT NULL,
  saldo FLOAT(15, 2) UNSIGNED NOT NULL DEFAULT 0,

  CONSTRAINT pk_caja_ahorro
  PRIMARY KEY (nro_ca)

) ENGINE=InnoDB;

CREATE TABLE caja (
 cod_caja INT UNSIGNED(5) NOT NULL,
 
 CONSTRAINT pk_caja
 PRIMARY KEY (cod_caja)
 
) ENGINE=InnoDB;

CREATE TABLE ventanilla(
 cod_caja INT UNSIGNED(5) NOT NULL, 
 nro_suc INT UNSIGNED(3) NOT NULL,
 
 CONSTRAINT pk_ventanilla
 PRIMARY KEY (cod_caja),
 
 CONSTRAINT FK_ventanilla_caja
 FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_ventanilla_sucursal
 FOREIGN KEY (nro_suc) REFERENCES sucursal (nro_suc) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;


CREATE TABLE atm(
 cod_caja INT UNSIGNED(5) NOT NULL, 
 cod_postal INT UNSIGNED(4) NOT NULL,
 direccion VARCHAR(69) NOT NULL,
 
 CONSTRAINT pk_atm
 PRIMARY KEY (cod_caja),
 
 CONSTRAINT FK_atm_caja
 FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_atm_ciudad
 FOREIGN KEY (cod_postal) REFERENCES ciudad (cod_postal) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;


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