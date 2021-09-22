#-------------------------------------------------------------------------
# Carga de datos

use banco;

INSERT INTO ciudad VALUES (1, "nomCiudad1");
INSERT INTO ciudad VALUES (2, "nomCiudad2");
INSERT INTO ciudad VALUES (3, "nomCiudad3");
INSERT INTO ciudad VALUES (4, "nomCiudad4");

INSERT INTO sucursal VALUES (1, "nomSucursal1", "dirSucursal1", "telSucursal1", "horario1", 1);
INSERT INTO sucursal VALUES (2, "nomSucursal2", "dirSucursal2", "telSucursal2", "horario2", 2);
INSERT INTO sucursal VALUES (3, "nomSucursal3", "dirSucursal3", "telSucursal3", "horario3", 3);
INSERT INTO sucursal VALUES (4, "nomSucursal4", "dirSucursal4", "telSucursal4", "horario4", 4);

INSERT INTO empleado VALUES (1, "apEmpleado1", "nombreEmpleado1", "td1", 1, "dirEmpleado1", "telEmpleado1", "cargo1", "pw1", 1);
INSERT INTO empleado VALUES (2, "apEmpleado2", "nombreEmpleado2", "td2", 2, "dirEmpleado2", "telEmpleado2", "cargo2", "pw2", 2);
INSERT INTO empleado VALUES (3, "apEmpleado3", "nombreEmpleado3", "td3", 3, "dirEmpleado3", "telEmpleado3", "cargo3", "pw3", 3);
INSERT INTO empleado VALUES (4, "apEmpleado4", "nombreEmpleado4", "td4", 4, "dirEmpleado4", "telEmpleado4", "cargo4", "pw4", 4);

INSERT INTO cliente VALUES (1, "apCliente1", "nomCliente1", "td1", 11, "dirCliente1", "telCliente1", '1950-01-01');
INSERT INTO cliente VALUES (2, "apCliente2", "nomCliente2", "td2", 22, "dirCliente2", "telCliente2", '1950-01-02');
INSERT INTO cliente VALUES (3, "apCliente3", "nomCliente3", "td3", 33, "dirCliente3", "telCliente3", '1950-01-03');
INSERT INTO cliente VALUES (4, "apCliente4", "nomCliente4", "td4", 44, "dirCliente4", "telCliente4", '1950-01-04');

INSERT INTO plazo_fijo VALUES (1, 1.1, '2000-01-01', '2000-02-01', 1.1, 1.1, 1);
INSERT INTO plazo_fijo VALUES (2, 2.2, '2000-01-02', '2000-02-02', 2.2, 2.2, 2);
INSERT INTO plazo_fijo VALUES (3, 3.3, '2000-01-03', '2000-02-03', 3.3, 3.3, 3);
INSERT INTO plazo_fijo VALUES (4, 4.4, '2000-01-04', '2000-02-04', 4.4, 4.4, 4);

INSERT INTO tasa_plazo_fijo VALUES (1, 1.1, 1.2, 1.3);
INSERT INTO tasa_plazo_fijo VALUES (2, 2.1, 2.2, 2.3);
INSERT INTO tasa_plazo_fijo VALUES (3, 3.1, 3.2, 3.3);
INSERT INTO tasa_plazo_fijo VALUES (4, 4.1, 4.2, 4.3);

INSERT INTO plazo_cliente VALUES (1,1);
INSERT INTO plazo_cliente VALUES (2,2);
INSERT INTO plazo_cliente VALUES (3,3);
INSERT INTO plazo_cliente VALUES (4,4);

INSERT INTO prestamo VALUES (1, '1942-01-01', 1, 1000.11, 1.1, 1.1, 100.11, 1, 1);
INSERT INTO prestamo VALUES (2, '1942-01-02', 2, 2000.22, 2.2, 2.2, 200.22, 2, 2);
INSERT INTO prestamo VALUES (3, '1942-01-03', 3, 3000.33, 3.3, 3.3, 300.33, 3, 3);
INSERT INTO prestamo VALUES (4, '1942-01-04', 4, 4000.44, 4.4, 4.4, 400.44, 4, 4);

INSERT INTO pago VALUES (1, 1, '1980-01-01', '1969-01-01');
INSERT INTO pago VALUES (2, 2, '1980-01-02', '1969-01-02');
INSERT INTO pago VALUES (3, 3, '1980-01-03', '1969-01-03');
INSERT INTO pago VALUES (4, 4, '1980-01-04', '1969-01-04');

INSERT INTO tasa_prestamo VALUES (1, 1000, 10000, 1.1);
INSERT INTO tasa_prestamo VALUES (2, 2000, 20000, 2.2);
INSERT INTO tasa_prestamo VALUES (3, 3000, 30000, 3.3);
INSERT INTO tasa_prestamo VALUES (4, 4000, 40000, 4.4);

INSERT INTO caja_ahorro VALUES (1, 1111, 100000);
INSERT INTO caja_ahorro VALUES (2, 2222, 200000);
INSERT INTO caja_ahorro VALUES (3, 3333, 300000);
INSERT INTO caja_ahorro VALUES (4, 4444, 400000);

INSERT INTO cliente_ca VALUES (1,1);
INSERT INTO cliente_ca VALUES (2,2);
INSERT INTO cliente_ca VALUES (3,3);
INSERT INTO cliente_ca VALUES (4,4);

INSERT INTO tarjeta VALUES (1, "PIN1", "CVT1", '2031-01-01', 1, 1);
INSERT INTO tarjeta VALUES (2, "PIN2", "CVT2", '2031-01-02', 2, 2);
INSERT INTO tarjeta VALUES (3, "PIN3", "CVT3", '2031-01-03', 3, 3);
INSERT INTO tarjeta VALUES (4, "PIN4", "CVT4", '2031-01-04', 4, 4);

INSERT INTO caja VALUES (1);
INSERT INTO caja VALUES (2);
INSERT INTO caja VALUES (3);
INSERT INTO caja VALUES (4);

INSERT INTO ventanilla VALUES (1,1);
INSERT INTO ventanilla VALUES (2,2);
INSERT INTO ventanilla VALUES (3,3);
INSERT INTO ventanilla VALUES (4,4);

INSERT INTO atm VALUES (1, 1, "dirATM1");
INSERT INTO atm VALUES (2, 2, "dirATM2");
INSERT INTO atm VALUES (3, 3, "dirATM3");
INSERT INTO atm VALUES (4, 4, "dirATM4");

INSERT INTO transaccion VALUES (1, '2001-01-01', '01:01:01', 50.1);
INSERT INTO transaccion VALUES (2, '2001-01-02', '02:02:02', 50.2);
INSERT INTO transaccion VALUES (3, '2001-01-03', '03:03:03', 50.3);
INSERT INTO transaccion VALUES (4, '2001-01-04', '04:04:04', 50.4);
INSERT INTO transaccion VALUES (5, '2001-01-05', '05:05:05', 50.5);
INSERT INTO transaccion VALUES (6, '2001-01-06', '06:06:06', 50.6);
INSERT INTO transaccion VALUES (7, '2001-01-07', '07:07:07', 50.7);
INSERT INTO transaccion VALUES (8, '2001-01-08', '08:08:08', 50.8);

INSERT INTO debito VALUES (1, "compra de delfines exoticos", 1, 1);
INSERT INTO debito VALUES (2, "compra de plutonio radioactivo estable 99.99%", 2, 2);

INSERT INTO transaccion_por_caja VALUES (3,1);
INSERT INTO transaccion_por_caja VALUES (4,2);
INSERT INTO transaccion_por_caja VALUES (5,3);
INSERT INTO transaccion_por_caja VALUES (6,4);
INSERT INTO transaccion_por_caja VALUES (7,3);
INSERT INTO transaccion_por_caja VALUES (8,2);

INSERT INTO deposito VALUES (3, 3);
INSERT INTO deposito VALUES (4, 4);

INSERT INTO extraccion VALUES (5, 3, 3);
INSERT INTO extraccion VALUES (6, 2, 2);

INSERT INTO transferencia VALUES (7, 1, 1, 2);
INSERT INTO transferencia VALUES (8, 2, 2, 3);
