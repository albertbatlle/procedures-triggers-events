-- select * from categoria_bici;
SET foreign_key_checks = 0;

-- INSERTS avaries
INSERT INTO AVARIES (nom) VALUES ('Pinchadura');
INSERT INTO AVARIES (nom) VALUES ('Freno dañado');
INSERT INTO AVARIES (nom) VALUES ('Cadena rota');
INSERT INTO AVARIES (nom) VALUES ('Cambio averiado');
INSERT INTO AVARIES (nom) VALUES ('Manillar suelto');
INSERT INTO AVARIES (nom) VALUES ('Sillín roto');
INSERT INTO AVARIES (nom) VALUES ('Luz delantera averiada');
INSERT INTO AVARIES (nom) VALUES ('Luz trasera averiada');
INSERT INTO AVARIES (nom) VALUES ('Timbre roto');

-- INSERTS bicicletesINSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (1);
INSERT INTO BICICLETES (categoria_bici_id) VALUES (2);

-- INSERT usuaris
INSERT INTO USUARIS (dni_u, nom, cognom1, cognom2, mail, data_alta, compte_corrent, tarifa_id) VALUES ('12345678A', 'Juan', 'Pérez', 'García', 'juan.perez@example.com', '2023-05-01', '1234567890', 1);
INSERT INTO USUARIS (dni_u, nom, cognom1, cognom2, mail, data_alta, compte_corrent, tarifa_id) VALUES ('87654321B', 'María', 'Gómez', 'Fernández', 'maria.gomez@example.com', '2023-06-15', '0987654321', 2);
INSERT INTO USUARIS (dni_u, nom, cognom1, cognom2, mail, data_alta, compte_corrent, tarifa_id) VALUES ('45678912C', 'Pedro', 'Martínez', 'Sánchez', 'pedro.martinez@example.com', '2023-07-01', '5678901234', 1);
INSERT INTO USUARIS (dni_u, nom, cognom1, cognom2, mail, data_alta, compte_corrent, tarifa_id) VALUES ('23456789D', 'Laura', 'Jiménez', 'Ruiz', 'laura.jimenez@example.com', '2023-08-20', '2345678901', 2);
INSERT INTO USUARIS (dni_u, nom, cognom1, cognom2, mail, data_alta, compte_corrent, tarifa_id) VALUES ('98765432E', 'Carlos', 'Hernández', 'Díaz', 'carlos.hernandez@example.com', '2023-09-10', '9876543210', 1);

-- INSERTS personal
INSERT INTO PERSONAL (dni_p, nom, cognom1, cognom2, compte_corrent, districte_id, CATEGORIA_PERSONAL_id) VALUES ('12345678A', 'Juan', 'Pérez', 'García', '1234567890', 1, 1);
INSERT INTO PERSONAL (dni_p, nom, cognom1, cognom2, compte_corrent, districte_id, CATEGORIA_PERSONAL_id) VALUES ('87654321B', 'María', 'Gómez', 'Fernández', '0987654321', 2, 2);
INSERT INTO PERSONAL (dni_p, nom, cognom1, cognom2, compte_corrent, districte_id, CATEGORIA_PERSONAL_id) VALUES ('45678912C', 'Pedro', 'Martínez', 'Sánchez', '5678901234', 3, 1);
INSERT INTO PERSONAL (dni_p, nom, cognom1, cognom2, compte_corrent, districte_id, CATEGORIA_PERSONAL_id) VALUES ('23456789D', 'Laura', 'Jiménez', 'Ruiz', '2345678901', 4, 2);
INSERT INTO PERSONAL (dni_p, nom, cognom1, cognom2, compte_corrent, districte_id, CATEGORIA_PERSONAL_id) VALUES ('98765432E', 'Carlos', 'Hernández', 'Díaz', '9876543210', 5, 1);

-- INSERTS categoria_personal
INSERT INTO CATEGORIA_PERSONAL (nom) VALUES ('Técnico de Mantenimiento');
INSERT INTO CATEGORIA_PERSONAL (nom) VALUES ('Supervisor');
INSERT INTO CATEGORIA_PERSONAL (nom) VALUES ('Administrativo');
INSERT INTO CATEGORIA_PERSONAL (nom) VALUES ('Gerente');
INSERT INTO CATEGORIA_PERSONAL (nom) VALUES ('Coordinador de Operaciones');

-- INSERTS nomines
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-07-01', 1, 1);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-07-01', 2, 2);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-07-01', 1, 3);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-07-01', 2, 4);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-07-01', 1, 5);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-08-01', 1, 1);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-08-01', 2, 2);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-08-01', 1, 3);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-08-01', 2, 4);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-08-01', 1, 5);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-09-01', 1, 1);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-09-01', 2, 2);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-09-01', 1, 3);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-09-01', 2, 4);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-09-01', 1, 5);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-10-01', 1, 1);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-10-01', 2, 2);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-10-01', 1, 3);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-10-01', 2, 4);
INSERT INTO NOMINES (data_nomina, salaris_id, PERSONAL_id) VALUES ('2023-10-01', 1, 5);

-- INSERTS lloguer
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 10:00:00', '2023-07-01 10:15:00', 1, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 11:00:00', '2023-07-01 11:30:00', 2, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 12:00:00', '2023-07-01 12:45:00', 3, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 13:00:00', '2023-07-01 13:20:00', 4, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 14:00:00', '2023-07-01 14:30:00', 5, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 10:00:00', '2023-07-02 10:45:00', 1, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 11:00:00', '2023-07-02 11:30:00', 2, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 12:00:00', '2023-07-02 12:15:00', 3, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 13:00:00', '2023-07-02 13:40:00', 4, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 14:00:00', '2023-07-02 14:25:00', 5, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 10:00:00', '2023-07-03 10:30:00', 1, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 11:00:00', '2023-07-03 11:35:00', 2, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 12:00:00', '2023-07-03 12:20:00', 3, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 13:00:00', '2023-07-03 13:50:00', 4, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 14:00:00', '2023-07-03 14:15:00', 5, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 10:00:00', '2023-07-04 10:40:00', 1, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 11:00:00', '2023-07-04 11:25:00', 2, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 12:00:00', '2023-07-04 12:30:00', 3, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 13:00:00', '2023-07-04 13:10:00', 4, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 14:00:00', '2023-07-04 14:35:00', 5, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-05 10:00:00', '2023-07-05 10:20:00', 1, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-05 11:00:00', '2023-07-05 11:40:00', 2, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-05 12:00:00', '2023-07-05 12:25:00', 3, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-05 13:00:00', '2023-07-05 13:30:00', 4, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-05 14:00:00', '2023-07-05 14:50:00', 5, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-06 10:00:00', '2023-07-06 10:35:00', 1, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-06 11:00:00', '2023-07-06 11:20:00', 2, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-06 12:00:00', '2023-07-06 12:45:00', 3, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-06 13:00:00', '2023-07-06 13:15:00', 4, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-06 14:00:00', '2023-07-06 14:30:00', 5, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 10:00:00', '2023-07-01 10:15:00', 375, 222, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 11:00:00', '2023-07-01 11:30:00', 128, 366, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 12:00:00', '2023-07-01 12:45:00', 400, 89, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 13:00:00', '2023-07-01 13:20:00', 78, 66, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 14:00:00', '2023-07-01 14:30:00', 178, 202, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 10:00:00', '2023-07-02 10:45:00', 366, 323, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 11:00:00', '2023-07-02 11:30:00', 199, 375, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 12:00:00', '2023-07-02 12:15:00', 222, 128, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 13:00:00', '2023-07-02 13:40:00', 366, 400, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 14:00:00', '2023-07-02 14:25:00', 89, 78, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 10:00:00', '2023-07-03 10:30:00', 66, 178, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 11:00:00', '2023-07-03 11:35:00', 202, 366, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 12:00:00', '2023-07-03 12:20:00', 323, 199, 0.05);

-- INSERTS facturacio
INSERT INTO FACTURACIO (data_factura, cost_total) VALUES ('2023-07-01 00:00:00', 25.50);
INSERT INTO FACTURACIO (data_factura, cost_total) VALUES ('2023-07-15 00:00:00', 42.75);
INSERT INTO FACTURACIO (data_factura, cost_total) VALUES ('2023-08-01 00:00:00', 31.20);
INSERT INTO FACTURACIO (data_factura, cost_total) VALUES ('2023-08-15 00:00:00', 18.90);
INSERT INTO FACTURACIO (data_factura, cost_total) VALUES ('2023-09-01 00:00:00', 37.80);

-- INSERTS facturacio_has_usuaris
INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (1, 1);
#INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (1, 2);
INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (2, 3);
#INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (2, 4);
#INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (3, 1);
INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (3, 5);
#INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (4, 2);
INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (4, 3);
#INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (5, 4);
INSERT INTO FACTURACIO_has_USUARIS (FACTURACIO_id, USUARIS_id) VALUES (5, 5);

-- INSERTS lloguer
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 10:00:00', '2023-07-01 10:15:00', 1, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 11:00:00', '2023-07-01 11:30:00', 2, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 12:00:00', '2023-07-01 12:45:00', 3, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 13:00:00', '2023-07-01 13:20:00', 4, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-01 14:00:00', '2023-07-01 14:30:00', 5, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 10:00:00', '2023-07-02 10:45:00', 1, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 11:00:00', '2023-07-02 11:30:00', 2, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 12:00:00', '2023-07-02 12:15:00', 3, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 13:00:00', '2023-07-02 13:40:00', 4, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-02 14:00:00', '2023-07-02 14:25:00', 5, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 10:00:00', '2023-07-03 10:30:00', 1, 4, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 11:00:00', '2023-07-03 11:35:00', 2, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 12:00:00', '2023-07-03 12:20:00', 3, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 13:00:00', '2023-07-03 13:50:00', 4, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-03 14:00:00', '2023-07-03 14:15:00', 5, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 10:00:00', '2023-07-04 10:40:00', 1, 5, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 11:00:00', '2023-07-04 11:25:00', 2, 1, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 12:00:00', '2023-07-04 12:30:00', 3, 2, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 13:00:00', '2023-07-04 13:10:00', 4, 3, 0.05);
INSERT INTO LLOGUER (inici_lloguer, fi_lloguer, estacio_origen_id, estacio_final_id, tarifa_minutatge) VALUES ('2023-07-04 14:00:00', '2023-07-04 14:35:00', 5, 4, 0.05);

-- INSERTS bicicletes_has_lloguer
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (1, 1, 1);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (2, 2, 2);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (3, 3, 3);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (4, 4, 4);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (5, 5, 5);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (1, 6, 1);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (2, 7, 2);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (3, 8, 3);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (4, 9, 4);
INSERT INTO BICICLETES_has_LLOGUER (BICICLETES_id, LLOGUER_id, USUARIS_id) VALUES (5, 10, 5);

-- INSERTS salaris
INSERT INTO SALARIS (sou, CATEGORIA_PERSONAL_id) VALUES (1800.00, 1);
INSERT INTO SALARIS (sou, CATEGORIA_PERSONAL_id) VALUES (2200.00, 2);
INSERT INTO SALARIS (sou, CATEGORIA_PERSONAL_id) VALUES (1500.00, 3);
INSERT INTO SALARIS (sou, CATEGORIA_PERSONAL_id) VALUES (3000.00, 4);
INSERT INTO SALARIS (sou, CATEGORIA_PERSONAL_id) VALUES (2500.00, 5);

-- INSERTS manteniment
INSERT INTO MANTENIMENT (data_inici_reparacio, data_fi_reparacio, avaria_id, bicicleta_id) VALUES ('2023-05-01 10:00:00', '2023-05-01 12:30:00', 1, 1);
INSERT INTO MANTENIMENT (data_inici_reparacio, data_fi_reparacio, avaria_id, bicicleta_id) VALUES ('2023-05-05 08:15:00', '2023-05-05 09:45:00', 2, 27);
INSERT INTO MANTENIMENT (data_inici_reparacio, data_fi_reparacio, avaria_id, bicicleta_id) VALUES ('2023-05-10 14:20:00', '2023-05-10 15:10:00', 3, 312);
INSERT INTO MANTENIMENT (data_inici_reparacio, data_fi_reparacio, avaria_id, bicicleta_id) VALUES ('2023-05-15 11:00:00', '2023-05-15 13:00:00', 1, 22);
INSERT INTO MANTENIMENT (data_inici_reparacio, data_fi_reparacio, avaria_id, bicicleta_id) VALUES ('2023-05-20 09:30:00', '2023-05-20 10:45:00', 4, 19);


SET foreign_key_checks = 1;




-- select * from facturacio;
