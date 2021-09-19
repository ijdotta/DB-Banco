#-------------------------------------------------------------------------
# Carga de datos

use banco;

INSERT INTO ciudad VALUES (1, "n1");
INSERT INTO ciudad VALUES (2, "n2");
INSERT INTO ciudad VALUES (3, "n3");
INSERT INTO ciudad VALUES (4, "n4");

INSERT INTO sucursal VALUES (1, "n1", "d1", "1", 1);
INSERT INTO sucursal VALUES (2, "n2", "d2", "2", 2);
INSERT INTO sucursal VALUES (3, "n3", "d3", "3", 3);
INSERT INTO sucursal VALUES (4, "n4", "d4", "4", 4);

INSERT INTO empleado VALUES (1, "a1", "n1", "td1", 1, "d1", "t1", "c1", "p1", 1);
INSERT INTO empleado VALUES (2, "a2", "n2", "td2", 2, "d2", "t2", "c2", "p2", 2);
INSERT INTO empleado VALUES (3, "a3", "n3", "td3", 3, "d3", "t3", "c3", "p3", 3);
INSERT INTO empleado VALUES (4, "a4", "n4", "td4", 4, "d4", "t4", "c4", "p4", 4);

INSERT INTO cliente VALUES (1, "a1", "n1", "td1", 11, "d1", "t1", '1950-01-01');
INSERT INTO cliente VALUES (2, "a2", "n2", "td2", 22, "d2", "t2", '1950-01-02');
INSERT INTO cliente VALUES (3, "a3", "n3", "td3", 33, "d3", "t3", '1950-01-03');
INSERT INTO cliente VALUES (4, "a4", "n4", "td4", 44, "d4", "t4", '1950-01-04');

/*	falla, error con las key
INSERT INTO plazo_fijo VALUES (1, 1.1, '2000-01-01', '2000-02-01', 1.1, 1.1, 1);
INSERT INTO plazo_fijo VALUES (2, 2.2, '2000-01-02', '2000-02-02', 2.2, 2.2, 2);
INSERT INTO plazo_fijo VALUES (3, 3.3, '2000-01-03', '2000-02-03', 3.3, 3.3, 3);
INSERT INTO plazo_fijo VALUES (4, 4.4, '2000-01-04', '2000-02-04', 4.4, 4.4, 4);
*/