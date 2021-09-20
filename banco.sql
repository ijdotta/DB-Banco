-- Creación de la base de datos:
CREATE DATABASE banco;
USE banco;

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
    (Type, Bytes, Min_signed, min_unsigned, max_signed, max_unsigned)
    TINYINT	1	-128	0	127	255
    SMALLINT	2	-32768	0	32767	65535
    MEDIUMINT	3	-8388608	0	8388607	16777215
    INT	4	-2147483648	0	2147483647	4294967295
    BIGINT	8	-263	0	263-1	264-1
*/

/*
    * VERIFICAR POSIBLES RELACIONES FALTANTES (Como Tarjeta_CLç)
    * VERIFICAR EN LAS RELACIONES QUE SOLO PUSIMOS FK SI NO HACE FALTA UNA PK
*/

CREATE TABLE ciudad (
  cod_postal SMALLINT(4) UNSIGNED NOT NULL,
  nombre VARCHAR(20) NOT NULL,

  CONSTRAINT pk_ciudad
  PRIMARY KEY (cod_postal)

) ENGINE=InnoDB;

CREATE TABLE sucursal (
  nro_suc SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL,
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  horario VARCHAR(20) NOT NULL,
  cod_postal SMALLINT(4) UNSIGNED NOT NULL,

  CONSTRAINT pk_sucursal
  PRIMARY KEY (nro_suc),

  CONSTRAINT FK_sucursal_ciudad
  FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE empleado (
  legajo SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  apellido VARCHAR(20) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  tipo_doc VARCHAR(20) NOT NULL,
  nro_doc INT(8) UNSIGNED NOT NULL, 
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  cargo VARCHAR(20) NOT NULL,
  password CHAR(32) NOT NULL,
  nro_suc SMALLINT(3) UNSIGNED NOT NULL,

  CONSTRAINT pk_empleado
  PRIMARY KEY (legajo),

  CONSTRAINT FK_empleado_sucursal
  FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE cliente(
  nro_cliente INT(5) UNSIGNED NOT NULL AUTO_INCREMENT, -- podría usarse MEDIUMINT (pero no creo que convenga por compatibilidad con otras implementaciones de SQL)
  apellido VARCHAR(20) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  tipo_doc VARCHAR(20) NOT NULL,
  nro_doc INT(8) UNSIGNED NOT NULL, 
  direccion VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  fecha_nac DATE NOT NULL,

  CONSTRAINT pk_cliente
  PRIMARY KEY (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE plazo_fijo (
  nro_plazo INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  capital DECIMAL(16, 2) UNSIGNED NOT NULL DEFAULT 0,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,  
  tasa_interes DECIMAL(4, 2) UNSIGNED NOT NULL DEFAULT 0,
  interes DECIMAL(16, 2) UNSIGNED NOT NULL DEFAULT 0,
  nro_suc SMALLINT(3) UNSIGNED NOT NULL,

  CONSTRAINT pk_plazo_fijo
  PRIMARY KEY (nro_plazo),

  CONSTRAINT FK_plazo_fijo_sucursal
  FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE tasa_plazo_fijo (
  periodo SMALLINT(3) UNSIGNED NOT NULL,
  monto_inf DECIMAL(16, 2) UNSIGNED NOT NULL DEFAULT 0,
  monto_sup DECIMAL(16, 2) UNSIGNED NOT NULL DEFAULT 0,
  tasa DECIMAL(4, 2) UNSIGNED NOT NULL DEFAULT 0,

  CONSTRAINT pk_tasa_plazo_fijo
  PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;

CREATE TABLE plazo_cliente (
  nro_plazo INT(8) UNSIGNED NOT NULL,
  nro_cliente INT(5) UNSIGNED NOT NULL, -- posible: MEDIUMINT

  CONSTRAINT pk_plazo_cliente
  PRIMARY KEY (nro_plazo, nro_cliente),

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
  cant_meses SMALLINT(2) UNSIGNED NOT NULL, -- pòsible TINYINT
  monto DECIMAL(10, 2) UNSIGNED NOT NULL DEFAULT 0, 
  tasa_interes DECIMAL(4, 2) UNSIGNED NOT NULL DEFAULT 0, 
  interes DECIMAL(9, 2) UNSIGNED NOT NULL DEFAULT 0, 
  valor_cuota DECIMAL(9, 2) UNSIGNED NOT NULL DEFAULT 0, 
  legajo SMALLINT(4) UNSIGNED NOT NULL, 
  nro_cliente INT(5) UNSIGNED NOT NULL, -- posible MEDIUMINT

  CONSTRAINT pk_prestamo
  PRIMARY KEY (nro_prestamo),

  CONSTRAINT FK_prestamo_empleado
  FOREIGN KEY (legajo) REFERENCES empleado(legajo)
    ON DELETE RESTRICT ON UPDATE CASCADE,

  CONSTRAINT FK_prestamo_cliente
  FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)
    ON DELETE RESTRICT ON UPDATE CASCADE
  
) ENGINE=InnoDB;

CREATE TABLE pago (
  nro_prestamo INT(8) UNSIGNED NOT NULL,
  nro_pago SMALLINT(2) UNSIGNED NOT NULL, -- posible TINYINT
  fecha_venc DATE NOT NULL,
  fecha_pago DATE,

  CONSTRAINT pk_pago
  PRIMARY KEY (nro_prestamo, nro_pago),

  CONSTRAINT FK_pago_prestamo
  FOREIGN KEY (nro_prestamo) REFERENCES prestamo(nro_prestamo)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE tasa_prestamo (
  periodo SMALLINT(3) UNSIGNED NOT NULL,
  monto_inf DECIMAL(10, 2) UNSIGNED NOT NULL DEFAULT 0, 
  monto_sup DECIMAL(10, 2) UNSIGNED NOT NULL DEFAULT 0, 
  tasa DECIMAL(4, 2) UNSIGNED NOT NULL DEFAULT 0, 

  CONSTRAINT pk_tasa_prestamo
  PRIMARY KEY (periodo, monto_inf, monto_sup)
  
) ENGINE=InnoDB;

CREATE TABLE caja_ahorro (
  nro_ca INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  cbu BIGINT(18) UNSIGNED NOT NULL,
  saldo DECIMAL(16, 2) UNSIGNED NOT NULL DEFAULT 0,

  CONSTRAINT pk_caja_ahorro
  PRIMARY KEY (nro_ca)

) ENGINE=InnoDB;

CREATE TABLE cliente_ca (
  nro_cliente INT(5) UNSIGNED NOT NULL,
  nro_ca INT(8) UNSIGNED NOT NULL,

  CONSTRAINT pk_cliente_ca
  PRIMARY KEY (nro_cliente, nro_ca),

  CONSTRAINT FK_cliente_ca_cliente
  FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)
    ON DELETE RESTRICT ON UPDATE CASCADE,

  CONSTRAINT FK_cliente_caja_ahorro
  FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE tarjeta(
  nro_tarjeta BIGINT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  pin CHAR(32) NOT NULL,
  cvt CHAR(32) NOT NULL,
  fecha_venc DATE NOT NULL,
  nro_cliente INT(5) UNSIGNED NOT NULL,
  nro_ca INT(8) UNSIGNED NOT NULL,

  CONSTRAINT pk_tarjeta
  PRIMARY KEY (nro_tarjeta),

  CONSTRAINT FK_tarjeta_cliente_ca_cliente
  FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca)
    ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE caja (
 cod_caja INT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
 
 CONSTRAINT pk_caja
 PRIMARY KEY (cod_caja)
 
) ENGINE=InnoDB;

CREATE TABLE ventanilla(
 cod_caja INT(5) UNSIGNED NOT NULL, 
 nro_suc SMALLINT(3) UNSIGNED NOT NULL,
 
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
 cod_caja INT(5) UNSIGNED NOT NULL, 
 cod_postal SMALLINT(4) UNSIGNED NOT NULL,
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
 nro_trans INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 fecha DATE NOT NULL,
 hora TIME NOT NULL,
 monto DECIMAL(16,2) UNSIGNED NOT NULL,
 
 CONSTRAINT pk_transaccion
 PRIMARY KEY (nro_trans)
 
) ENGINE=InnoDB;


CREATE TABLE debito(
 nro_trans INT(10) UNSIGNED NOT NULL, -- BIGINT? 
 descripcion TEXT,
 nro_cliente INT(5) UNSIGNED NOT NULL,
 nro_ca INT(8) UNSIGNED NOT NULL,
 
 CONSTRAINT pk_debito
 PRIMARY KEY (nro_trans),

 CONSTRAINT FK_debito_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion(nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
  
 CONSTRAINT FK_debito_cliente_ca
 FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;


CREATE TABLE transaccion_por_caja(
 nro_trans INT(10) UNSIGNED NOT NULL, -- BIGINT? 
 cod_caja INT(5) UNSIGNED NOT NULL,
 
 CONSTRAINT pk_transaccion_por_caja
 PRIMARY KEY (nro_trans),
 
 CONSTRAINT FK_transaccion_por_caja_transaccion
 FOREIGN KEY (nro_trans) REFERENCES transaccion (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_transaccion_por_caja_caja_ahorro
 FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;

CREATE TABLE deposito(
 nro_trans INT(10) UNSIGNED NOT NULL, -- BIGINT?
 nro_ca INT(8) UNSIGNED NOT NULL,
 
 CONSTRAINT pk_deposito
 PRIMARY KEY (nro_trans),

 CONSTRAINT FK_deposito_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
 CONSTRAINT FK_deposito_caja_ahorro
 FOREIGN KEY (nro_ca) REFERENCES caja_ahorro (nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;


CREATE TABLE extraccion(
 nro_trans INT(10) UNSIGNED NOT NULL, -- BIGINT?
 nro_cliente INT(5) UNSIGNED NOT NULL, 
 nro_ca INT(8) UNSIGNED NOT NULL,
 
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
 nro_trans INT(10) UNSIGNED NOT NULL, -- BIGINT?
 nro_cliente INT(5) UNSIGNED NOT NULL, 
 origen INT(8) UNSIGNED NOT NULL,
 destino INT(8) UNSIGNED NOT NULL,
 
 CONSTRAINT pk_transferencia 
 PRIMARY KEY (nro_trans),
 
 CONSTRAINT FK_transferencia_transaccion_por_caja 
 FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_transferencia_cliente
 FOREIGN KEY (nro_cliente, origen) REFERENCES cliente_ca(nro_cliente, nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE,
   
CONSTRAINT FK_transferencia_destino
 FOREIGN KEY (destino) REFERENCES caja_ahorro(nro_ca) 
   ON DELETE RESTRICT ON UPDATE CASCADE
 
) ENGINE=InnoDB;

#-------------------------------------------------------------------------
# Creación de vistas

CREATE VIEW trans_caja_ahorro AS
SELECT G.nro_ca,  G.saldo , G.nro_trans, G.fecha, G.hora, G.tipo, G.monto, G.cod_caja, H.nro_cliente, H.tipo_doc, H.nro_doc, H.nombre, H.apellido, destino
FROM 	(
			(	SELECT A.nro_ca, A.saldo, F.nro_trans, F.fecha, F.hora, F.monto, F.nro_cliente, F.destino, F.tipo, F.cod_caja
				FROM	(
							(	SELECT nro_ca, saldo	FROM caja_ahorro) as A
							inner JOIN
							
								(	SELECT B.nro_trans, B.fecha, B.hora, B.monto, E.cod_caja, E.nro_cliente, E.nro_ca, E.destino, E.tipo
									FROM 
								
										((	SELECT nro_trans, fecha, hora, monto	FROM transaccion) AS B
									
											inner JOIN						
										
											(
												SELECT C.nro_trans, C.nro_cliente, C.nro_ca, C.destino, C.tipo, D.cod_caja
												FROM
													(	(SELECT nro_trans, nro_cliente, nro_ca, NULL AS destino, "debito" AS tipo FROM debito)
														union
														(SELECT nro_trans, nro_cliente, nro_ca, NULL AS destino, "extraccion" AS tipo FROM extraccion)
														union
														(SELECT nro_trans, nro_cliente, origen as nro_ca, destino, "transferencia" AS tipo FROM transferencia)
														union
														(SELECT nro_trans, NULL AS nro_cliente, nro_ca, NULL AS destino, "deposito" AS tipo FROM deposito)	
													) AS C
													
													LEFT JOIN
													
													(SELECT nro_trans, cod_caja FROM transaccion_por_caja) AS D	ON C.nro_trans = D.nro_trans
												
											) AS E ON B.nro_trans = E.nro_trans
										) 
								) AS F ON A.nro_ca = F.nro_ca
							)
				) AS G
				
				INNER JOIN 
				
				(SELECT nro_cliente, tipo_doc, nro_doc, nombre, apellido FROM cliente) AS H ON G.nro_cliente = H.nro_cliente
			);
			
#-------------------------------------------------------------------------
# Creación de usuarios y otorgamiento de privilegios 

/* usuario admin */
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

/* usuario empleado */
CREATE USER 'empleado'@'%' IDENTIFIED BY 'empleado';
GRANT SELECT ON banco.empleado TO 'empleado'@'%';
GRANT SELECT ON banco.sucursal TO 'empleado'@'%';
GRANT SELECT ON banco.tasa_plazo_fijo TO 'empleado'@'%';
GRANT SELECT ON banco.tasa_prestamo TO 'empleado'@'%';

GRANT SELECT, INSERT ON banco.prestamo TO 'empleado'@'%';
GRANT SELECT, INSERT ON banco.plazo_fijo TO 'empleado'@'%';
GRANT SELECT, INSERT ON banco.plazo_cliente TO 'empleado'@'%';
GRANT SELECT, INSERT ON banco.caja_ahorro TO 'empleado'@'%';
GRANT SELECT, INSERT ON banco.tarjeta TO 'empleado'@'%';

GRANT SELECT, INSERT, UPDATE ON banco.cliente_ca TO 'empleado'@'%';
GRANT SELECT, INSERT, UPDATE ON banco.cliente TO 'empleado'@'%';
GRANT SELECT, INSERT, UPDATE ON banco.pago TO 'empleado'@'%';

/* usuario atm */
CREATE USER 'atm'@'%' IDENTIFIED BY 'atm';
GRANT SELECT ON banco.trans_caja_ahorro TO 'atm'@'%';

GRANT SELECT, UPDATE ON banco.tarjeta TO 'atm'@'%';