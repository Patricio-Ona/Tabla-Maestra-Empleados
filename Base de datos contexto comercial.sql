use contextocomercial;
/*==============================================================*/
/* Table: AJUSTES                                               */
/*==============================================================*/
create table AJUSTES (
   AJUCODIGO            SERIAL               not null,
   EMPCODIGO            CHAR(7)              not null,
   AJUDESCRIPCION       CHAR(60)             not null,
   AJUFECHA             DATE                 not null,
   AJUCANTIDADTOTAL     NUMERIC(9,2)         null,
   constraint PK_AJUSTES primary key (AJUCODIGO)
);

/*==============================================================*/
/* Table: BONIFICACIONES                                        */
/*==============================================================*/
create table BONIFICACIONES (
   BONCODIGO            CHAR(5)              not null,
   BONDESCRIPCION       CHAR(30)             not null,
   BONVALOR             DECIMAL(7,2)         not null,
   constraint PK_BONIFICACIONES primary key (BONCODIGO)
);

/*==============================================================*/
/* Table: BXN                                                   */
/*==============================================================*/
create table BXN (
   BONCODIGO            CHAR(5)              not null,
   NOMCODIGO            CHAR(7)              not null,
   BXNVALOR             DECIMAL(7,2)         not null,
   BXNSTATUS            CHAR(3)              not null,
   constraint PK_BXN primary key (BONCODIGO, NOMCODIGO)
);

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
   CLICODIGO            CHAR(7)              not null,
   CLINOMBRE            CHAR(60)             not null,
   CLIIDENTIFICACION    CHAR(13)             not null,
   CLIDIRECCION         CHAR(60)             not null,
   CLITELEFONO          CHAR(10)             not null,
   CLICELULAR           CHAR(10)             not null,
   CLIEMAIL             CHAR(60)             null,
   CLITIPO              CHAR(3)              not null,
   CLISTATUS            CHAR(3)              not null,
   constraint PK_CLIENTES primary key (CLICODIGO)
);

/*==============================================================*/
/* Table: COMPRAS                                               */
/*==============================================================*/
create table COMPRAS (
   OCNUMERO             CHAR(9)              not null,
   PRVCODIGO            CHAR(7)              not null,
   OCFECHA              DATE                 not null,
   OCSUBTOTAL           NUMERIC(9,2)         not null,
   OCDESCUENTO          NUMERIC(9,2)         null,
   OCVALOR_IVA          NUMERIC(9,2)         null,
   OCVALOR_ICE          NUMERIC(9,2)         null,
   OCFORMAPAGO          CHAR(5)              not null,
   OCFACTURA_ASOCIADA   CHAR(30)             not null,
   OCSTATUS             CHAR(3)              null,
   constraint PK_COMPRAS primary key (OCNUMERO)
);


/*==============================================================*/
/* Table: DESCUENTOS                                            */
/*==============================================================*/
create table DESCUENTOS (
   DESCODIGO            CHAR(5)              not null,
   DESDESCRIPCION       CHAR(30)             not null,
   DESVALOR             DECIMAL(7,2)         not null,
   constraint PK_DESCUENTOS primary key (DESCODIGO)
);

/*==============================================================*/
/* Table: DXN                                                   */
/*==============================================================*/
create table DXN (
   NOMCODIGO            CHAR(7)              not null,
   DESCODIGO            CHAR(5)              not null,
   DXNVALOR             DECIMAL(7,2)         not null,
   DXNSTATUS            CHAR(3)              not null,
   constraint PK_DXN primary key (NOMCODIGO, DESCODIGO)
);

/*==============================================================*/
/* Table: EMPLEADOS                                             */
/*==============================================================*/
CREATE TABLE EMPLEADOS (
   EMPCODIGO            CHAR(7)              NOT NULL,
   EMPAPELLIDO1         CHAR(30)             NOT NULL,
   EMPAPELLIDO2         CHAR(30)             NULL,
   EMPNOMBRE1           CHAR(30)             NOT NULL,
   EMPNOMBRE2           CHAR(30)             NULL,
   EMPFECHANACIMIENTO   DATE                 NOT NULL,
   EMPSEXO              CHAR(1)              NOT NULL,
   EMPEMAIL             CHAR(60)             NOT NULL,
   EMPDIRECCION         CHAR(60)             NOT NULL,
   EMPTIPOSANGRE        CHAR(3)              NOT NULL,
   EMPSUELDO            NUMERIC(7,2)         NOT NULL,
   EMPBANCO             CHAR(30)             NOT NULL,
   EMPCUENTA            CHAR(20)             NOT NULL,
   EMPSTATUS            CHAR(3)              NOT NULL,
   EMPFOTO              LONGBLOB             NULL,
   CONSTRAINT PK_EMPLEADOS PRIMARY KEY (EMPCODIGO),
   CONSTRAINT CK_EMPPRIMER_APELLIDO CHECK (REGEXP_LIKE(EMPAPELLIDO1, '^[A-Za-zÁÉÍÓÚáéíóúÑñ. ]+$')),
   CONSTRAINT CK_EMPSEGUNDO_APELLIDO CHECK (EMPAPELLIDO2 IS NULL OR REGEXP_LIKE(EMPAPELLIDO2, '^[A-Za-zÁÉÍÓÚáéíóúÑñ. ]+$')),
   CONSTRAINT CK_EMPPRIMER_NOMBRE CHECK (REGEXP_LIKE(EMPNOMBRE1, '^[A-Za-zÁÉÍÓÚáéíóúÑñ. ]+$')),
   CONSTRAINT CK_EMPSEGUNDO_NOMBRE CHECK (EMPNOMBRE2 IS NULL OR REGEXP_LIKE(EMPNOMBRE2, '^[A-Za-zÁÉÍÓÚáéíóúÑñ. ]+$')),
   CONSTRAINT CK_EMPEMAIL_DOMINIO CHECK (REGEXP_LIKE(EMPEMAIL, '^[A-Za-z0-9._+-]+@puce\.edu\.ec$')),
   CONSTRAINT CK_EMPSUELDO_POSITIVO CHECK (EMPSUELDO >= 0),
   CONSTRAINT CK_EMPBANCO_VALIDO CHECK (UPPER(EMPBANCO) IN ('BANCO DEL PACÍFICO', 'BANCO PICHINCHA', 'BANCO GUAYAQUIL', 'BANCO DE LOJA', 'BANCO DEL AUSTRO', 'BANCO INTERNACIONAL', 'BANCO BOLIVARIANO', 'BANCO PRODUBANCO', 'BANCO DE MACHALA', 'BANCO SOLIDARIO', 'BANCO DE FOMENTO', 'BANCO PROCREDIT', 'BANCO AMAZONAS', 'BANCO DE GUAYAQUIL', 'BANCO DEL LITORAL', 'BANCO PROCREDIT')),
   CONSTRAINT CK_EMPCUENTA_CARACTERES CHECK (REGEXP_LIKE(EMPCUENTA, '^[^\W_]+$')),
   CONSTRAINT CK_EMPSTATUS_VALIDO CHECK (EMPSTATUS IN ('INA','ACT'))
);

DROP TABLE EMPLEADOS;
/*==============================================================*/
/* Table: FACTURAS                                              */
/*==============================================================*/
create table FACTURAS (
   FACNUMERO            CHAR(9)              not null,
   CLICODIGO            CHAR(7)              not null,
   FACFECHA             DATE                 not null,
   FACSUBTOTAL          NUMERIC(9,2)         not null,
   FACDESCUENTO         NUMERIC(9,2)         null,
   FACIVA               NUMERIC(9,2)         null,
   FACICE               NUMERIC(9,2)         null,
   FACFORMAPAGO         CHAR(5)              not null,
   FACSTATUS            CHAR(3)              not null,
   constraint PK_FACTURAS primary key (FACNUMERO)
);

/*==============================================================*/
/* Table: INGRESOS                                              */
/*==============================================================*/
create table INGRESOS (
   INGCODIGO            SERIAL               not null,
   EMPCODIGO            CHAR(7)              not null,
   INGDESCRIPCION       CHAR(30)             not null,
   INGFECHA             DATE                 not null,
   INGCANTIDADTOTAL     NUMERIC(9,2)         null,
   INGREFERENCIA        CHAR(60)             null,
   constraint PK_INGRESOS primary key (INGCODIGO)
);

/*==============================================================*/
/* Table: NOMINAS                                               */
/*==============================================================*/
create table NOMINAS (
   NOMCODIGO            CHAR(7)              not null,
   EMPCODIGO            CHAR(7)              not null,
   NOMANIO              CHAR(4)              not null,
   NOMMES               CHAR(2)              not null,
   NOMFECHAINICIAL      DATE                 not null,
   NOMFECHAFINAL        DATE                 not null,
   NOMSTATUS            CHAR(3)              not null,
   constraint PK_NOMINAS primary key (NOMCODIGO)
);

/*==============================================================*/
/* Table: PRODUCTOS                                             */
/*==============================================================*/
create table PRODUCTOS (
   PROCODIGO            CHAR(9)              not null,
   PRODESCRIPCION       CHAR(50)             not null,
   PROUNIDADMEDIDA      CHAR(3)              not null,
   PROSALDOINICIAL      DECIMAL(9,2)         not null,
   PROINGRESOS          DECIMAL(9,2)         not null,
   PROEGRESOS           NUMERIC(9,2)         not null,
   PROAJUSTES           NUMERIC(9,2)         not null,
   PROSALDOFINAL        NUMERIC(9,2)         not null,
   PROCOSTOUM           NUMERIC(7,2)         not null,
   PROPRECIOUM          NUMERIC(7,2)         not null,
   PROSTATUS            CHAR(3)              not null,
   constraint PK_PRODUCTOS primary key (PROCODIGO)
);

/*==============================================================*/
/* Table: PROVEEDORES                                           */
/*==============================================================*/
create table PROVEEDORES (
   PRVCODIGO            CHAR(7)              not null,
   PRVNOMBRE            CHAR(30)             not null,
   PRVIDENTIFICACION    CHAR(10)             not null,
   PRVDIRECCION         CHAR(60)             not null,
   PRVTELEFONO          CHAR(10)             null,
   PRVCELULAR           CHAR(10)             null,
   PRVEMAIL             CHAR(60)             null,
   PRVTIPO              CHAR(3)              not null,
   PRVSTATUS            CHAR(3)              not null,
   constraint PK_PROVEEDORES primary key (PRVCODIGO)
);


/*==============================================================*/
/* Table: PXA                                                   */
/*==============================================================*/
create table PXA (
   AJUCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXACANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXA primary key (AJUCODIGO, PROCODIGO)
);


/*==============================================================*/
/* Table: PXF                                                   */
/*==============================================================*/
create table PXF (
   FACNUMERO            CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXFCANTIDAD          NUMERIC(9,2)         not null,
   PXFVALOR             NUMERIC(7,2)         not null,
   PXFSUBTOTAL          NUMERIC(9,2)         not null,
   PXFSTATUS            CHAR(3)              not null,
   constraint PK_PXF primary key (FACNUMERO, PROCODIGO)
);


/*==============================================================*/
/* Table: PXI                                                   */
/*==============================================================*/
create table PXI (
   INGCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXICANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXI primary key (INGCODIGO, PROCODIGO)
);


/*==============================================================*/
/* Table: PXO                                                   */
/*==============================================================*/
create table PXO (
   OCNUMERO             CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXCCANTIDAD          NUMERIC(9,2)         not null,
   PXCVALOR             NUMERIC(7,2)         not null,
   PXCSUBTOTAL          NUMERIC(9,2)         not null,
   PXCSTATUS            CHAR(3)              not null,
   constraint PK_PXO primary key (OCNUMERO, PROCODIGO)
);

/*==============================================================*/
/* Table: PXS                                                   */
/*==============================================================*/
create table PXS (
   SALCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXSCANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXS primary key (SALCODIGO, PROCODIGO)
);

/*==============================================================*/
/* Table: SALIDAS                                               */
/*==============================================================*/
create table SALIDAS (
   SALCODIGO            SERIAL               not null,
   EMPCODIGO            CHAR(7)              not null,
   SALDESCRIPCION       CHAR(30)             not null,
   SALFECHA             DATE                 not null,
   SALCANTIDADTOTAL     NUMERIC(9,2)         null,
   SALREFERENCIA        CHAR(60)             null,
   constraint PK_SALIDAS primary key (SALCODIGO)
);

insert into PRODUCTOS (PROCODIGO, PRODESCRIPCION, PROUNIDADMEDIDA, PROSALDOINICIAL, PROINGRESOS, PROEGRESOS, PROAJUSTES, PROSALDOFINAL, PROCOSTOUM, PROPRECIOUM, PROSTATUS) 
values 
('P-0001', 'CEREAL TRIGO ENTERO', 'QQ ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0002', 'MORA FRUTO COMPLETO', 'CAJ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0003', 'CARNE DE CERDO CON HUESO', 'KG ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0004', 'SARDINAS EN CONSERVA', 'PAQ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0005', 'LECHE LÍQUIDA PASTEURIZADA', 'LIT', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0006', 'ATÚN EN CONSERVA', 'UNI', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0007', 'JUGO DE NARANJA', 'LIT', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0008', 'HARINA DE TRIGO', 'KG ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0009', 'ARROZ BLANCO', 'QQ ', 0, 0, 0, 0, 0, 1, 2, 'ACT'),
('P-0010', 'FRIJOLES NEGROS', 'KG ', 0, 0, 0, 0, 0, 1, 2, 'ACT');

insert into EMPLEADOS (EMPCODIGO, EMPAPELLIDO1, EMPAPELLIDO2, EMPNOMBRE1, EMPNOMBRE2, EMPFECHANACIMIENTO, EMPSEXO, EMPEMAIL, EMPDIRECCION, EMPTIPOSANGRE, EMPSUELDO, EMPBANCO, EMPCUENTA, EMPSTATUS) 
values 
('EMP-111', 'CONDOR', 'CRUZ', 'JAVIER', 'WILFRIDO', '1965-09-04', 'M', 'jwcondor@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-222', 'ARCOS', 'VILLAGOMEZ', 'SUYANA', 'FABIOLA', '1975-06-14', 'F', 'sarcos@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-333', 'CASTRO', 'DE LA CRUZ', 'FABIAN', 'IGNACIO', '1985-03-24', 'M', 'fcastro@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-444', 'MASAPANTA', 'LIZ', 'SUSANA', 'MARGARITA', '1995-12-14', 'F', 'smasapanta@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-555', 'CANDO', 'CANDO', 'WILSON', 'ALFREDO', '2005-09-04', 'M', 'wcando@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-666', 'CHICAIZA', 'VALLADARES', 'ROSA', 'ELVIA', '2015-06-14', 'F', 'rechicaiza@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-777', 'PEREZ', 'GONZALEZ', 'JUAN', 'CARLOS', '1980-05-22', 'M', 'jperez@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-888', 'GARCIA', 'RODRIGUEZ', 'ANA', 'MARIA', '1990-07-18', 'F', 'agarcia@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-999', 'LOPEZ', 'MARTINEZ', 'MIGUEL', 'ANGEL', '1972-11-30', 'M', 'mlopez@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT'),
('EMP-100', 'RAMIREZ', 'HERRERA', 'CARMEN', 'JOSEFINA', '1998-02-25', 'F', 'cramirez@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');

insert into PROVEEDORES (PRVCODIGO, PRVNOMBRE, PRVIDENTIFICACION, PRVDIRECCION, PRVTELEFONO, PRVCELULAR, PRVEMAIL, PRVTIPO, PRVSTATUS) 
values 
('PRV-010', 'CORPORACION FAVORITA C.A.', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '02-2996500', '0992996500', 'ventas@favorita.com.ec', 'JUR', 'ACT'),
('PRV-020', 'CORPORACION EL ROSADO SA.', '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador', '02-2980980', '0992996500', 'ventas@elrosado.com.ec', 'JUR', 'ACT'),
('PRV-030', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador', '04-2322000', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT'),
('PRV-040', 'ECUACORRIENTE S. A.', '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '04-6005238', '0992996500', 'ventas@ecuacorriente.ec', 'JUR', 'ACT'),
('PRV-050', 'DINADEC S.A.', '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '04-5004040', '0992996500', 'ventas@danec.ec', 'JUR', 'ACT'),
('PRV-060', 'DISTRIBUIDORA FARMACEUTI', '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador', '04-5004040', '0992996500', 'ventas@difare.com.ec', 'JUR', 'ACT'),
('PRV-070', 'COMERCIAL ESTRADA', '1502996507', 'Av. de la Prensa y Occidental Quito - Ecuador', '02-2796500', '0992796500', 'ventas@estrada.com.ec', 'JUR', 'ACT'),
('PRV-080', 'FERRETERIA CENTRO', '1602996508', 'Calle 12 de Octubre y Tarqui Cuenca - Ecuador', '07-2796500', '0992796500', 'ventas@ferrecentr.com.ec', 'JUR', 'ACT'),
('PRV-090', 'IMPORTADORA ANDINA', '1702996509', 'Av. 10 de Agosto y Colón Quito - Ecuador', '02-2696500', '0992696500', 'ventas@importandina.com.ec', 'JUR', 'ACT'),
('PRV-100', 'CONSTRUCCIONES MODERNAS', '1802996510', 'Av. América y Naciones Unidas Quito - Ecuador', '02-2596500', '0992596500', 'ventas@construmod.com.ec', 'JUR', 'ACT');

insert into CLIENTES (CLICODIGO, CLINOMBRE, CLIIDENTIFICACION, CLIDIRECCION, CLITELEFONO, CLICELULAR, CLIEMAIL, CLITIPO, CLISTATUS) 
values 
('CLI-001', 'CORPORACION FAVORITA C.A.', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '02-2996500', '0992996500', 'ventas@favorita.com.ec', 'JUR', 'ACT'),
('CLI-002', 'CÓNDOR JAVIER', '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador', '02-2980980', '0992996500', 'ventas@elrosado.com.ec', 'NAT', 'ACT'),
('CLI-003', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador', '04-2322000', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT'),
('CLI-004', 'PAMELA CORTEZ', '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '04-6005238', '0992996500', 'ventas@ecuacorriente.ec', 'NAT', 'ACT'),
('CLI-005', 'DINADEC S.A.', '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '04-5004040', '0992996500', 'ventas@danec.ec', 'JUR', 'ACT'),
('CLI-006', 'VERONICA ANTONELA FRITZ', '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador', '04-5004040', '0992996500', 'ventas@difare.com.ec', 'NAT', 'ACT'),
('CLI-007', 'JUAN PEREZ', '1702996507', 'Av. de la Prensa y Occidental Quito - Ecuador', '02-2796500', '0992796500', 'ventas@juanperez.com.ec', 'NAT', 'ACT'),
('CLI-008', 'ANA MARIA GARCIA', '0702996508', 'Calle 12 de Octubre y Tarqui Cuenca - Ecuador', '07-2796500', '0992796500', 'ventas@anamaria.com.ec', 'NAT', 'ACT'),
('CLI-009', 'MIGUEL ANGEL LOPEZ', '1402996509', 'Av. 10 de Agosto y Colón Quito - Ecuador', '02-2696500', '0992696500', 'ventas@miguelopez.com.ec', 'NAT', 'ACT'),
('CLI-010', 'CARMEN JOSEFINA RAMIREZ', '1602996510', 'Av. América y Naciones Unidas Quito - Ecuador', '02-2596500', '0992596500', 'ventas@carmenramirez.com.ec', 'NAT', 'ACT');

insert into NOMINAS  values ('NOM0001', 'EMP-111', '   4', ' 2', '1-1-1', '1017-9-6', '  0');
insert into NOMINAS  values ('NOM0002', 'EMP-555', '    ', ' 3', '927-10-8', '1376-11-7', '  1');
insert into NOMINAS  values ('NOM0003', 'EMP-111', '   0', ' 4', '1556-7-23', '1-1-1', '  2');
insert into NOMINAS  values ('NOM0004', 'EMP-333', '   1', '  ', '448-7-4', '1571-7-11', '  3');
insert into NOMINAS  values ('NOM0005', 'EMP-555', '   2', ' 0', '1945-8-8', '341-4-12', '  4');
insert into NOMINAS  values ('NOM0006', 'EMP-222', '   3', ' 1', '1105-7-15', '613-10-29', '   ');

insert into BONIFICACIONES  values ('B1010', 'Fondo de Reserva Mensualizado', 145);
insert into BONIFICACIONES  values ('B1020', 'Bono 20 anios de servicio', 200);
insert into BONIFICACIONES  values ('B1030', 'Bono 25 anios de servicio', 250);
insert into BONIFICACIONES  values ('B1040', 'Bono 30 anios de servicio', 300);
insert into BONIFICACIONES  values ('B1050', 'Bono publicación scopus', 500);
insert into BONIFICACIONES  values ('B1060', 'Bono horas extra', 100);

insert into DESCUENTOS  values ('D2010', 'Aporte Personal IESS', 333);
insert into DESCUENTOS  values ('D2020', 'Aporte Personal FIDEICOMISO', 555);
insert into DESCUENTOS  values ('D2030', 'Aporte Personal Seguro Cancer', 444);
insert into DESCUENTOS  values ('D2040', 'Aporte Personal Seguro Medico', 111);
insert into DESCUENTOS  values ('D2050', 'Aporte Personal Seguro de Vida', 10);
insert into DESCUENTOS  values ('D2060', 'Aporte APPUCE', 28);

insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1010', 'NOM0001', 1, '  4');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1020', 'NOM0002', 5, '   ');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1030', 'NOM0003', 2, '  0');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1040', 'NOM0004', 3, '  1');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1050', 'NOM0005', 4, '  2');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1060', 'NOM0006', 0, '  3');

insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0001', 'D2010', 2, '   ');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0002', 'D2020', 4, '  0');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0003', 'D2030', 3, '  1');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0004', 'D2040', 1, '  2');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0005', 'D2050', 0, '  3');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0006', 'D2060', 5, '  4');

insert into INGRESOS values (5, 'EMP-111', '398CROUREDDM115PH16M43TRJ2 75B', '443-11-28', 0, '31W4IIA74J4LBI91QPLUG YCIJGAWBEPFNYY5TRPUH8BTUAELI1315RX93 4');
insert into INGRESOS values (1, 'EMP-222', '0DWW3OW5DAP7T3KM 1XQI1MOECRCU ', '1-1-1', 1, 'AY33I3UUN1OWWROWT44GERG5WA6YVRIMUG59BY5KT6O7QKWM2YPT40MW0X2 ');
insert into INGRESOS values (0, 'EMP-555', 'H9ME19XKLDMS6WFSKF73Y39W0PIP7R', '759-10-13', 2, '71M69ONKVN8L7YDQIKNQ0V2E LLCRPL4CQI66RGN9L6VBHKO00SHA64M G I');
insert into INGRESOS values (4, 'EMP-222', '8K 51430R3OQ7GHAQDHURKQHI KXAW', '273-10-28', 5, 'SYLW2RC11IF57P2BF2CG0YGIIOGYFDT6BAP99 V9H1CQN8838LXUU8KLDU1 ');
insert into INGRESOS values (3, 'EMP-222', 'QKY59G9J44QONMLEHNWEX8YIRUV22I', '1504-9-26', 3, 'Y03J5RN029EGTYUP3LE5ERDR0JDJNBUM  4WAO26AH5UET8Q XD7T2 7O5I ');
insert into INGRESOS values (2, 'EMP-222', 'MWL4O8DAOABWE DX4KUV76FVD7X9VT', '1171-9-6', 4, 'OQ07W3MS14IMX9FORD3X1HRH7O6IGES RQF2YUJYW0D84HYQBUQ726WO8HF3');

insert into FACTURAS values ('FAC-001', 'CLI-001', '215-6-12', 4, 3, 5, 2, 'KUS0N', '  3');
insert into FACTURAS values ('FAC-002', 'CLI-001', '1-1-1', 3, 5, 1, 4, 'S6US3', '   ');
insert into FACTURAS values ('FAC-003', 'CLI-005', '1569-8-23', 2, 4, 3, 3, '07VBH', '  1');

insert into PXF values ('FAC-001', 'P-0001', 2, 3, 4, '  1');
insert into PXF values ('FAC-001', 'P-0002', 0, 4, 5, '  2');
insert into PXF values ('FAC-002', 'P-0003', 1, 5, 2, '  3');
insert into PXF values ('FAC-002', 'P-0004', 3, 1, 0, '  4');
insert into PXF values ('FAC-003', 'P-0005', 4, 0, 3, '   ');
insert into PXF values ('FAC-003', 'P-0006', 5, 2, 1, '  0');

insert into PXO values ('OC202301', 'P-0001', 5, 5, 4, '  2');
insert into PXO values ('OC202301', 'P-0002', 0, 3, 2, '  3');
insert into PXO values ('OC0002', 'P-0003', 4, 4, 5, '  4');
insert into PXO values ('OC0002', 'P-0004', 1, 1, 0, '   ');
insert into PXO values ('OC-003', 'P-0005', 2, 0, 3, '  0');
insert into PXO values ('OC-003', 'P-0006', 3, 2, 1, '  1');
INSERT INTO pxo VALUES ('OC00100', 'P-0007', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00006', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00007', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00008', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00009', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC000010', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00010', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00011', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00012', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00013', 'P-0008', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00014', 'P-0009', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00015', 'P-0010', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00016', 'P-0011', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00017', 'P-0012', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00018', 'P-0013', 6, 2, 7, ' 1');
INSERT INTO pxo VALUES ('OC00019', 'P-0014', 6, 2, 7, ' 1');



insert into PXI values (5, 'P-0001', 1);
insert into PXI values (1, 'P-0002', 5);
insert into PXI values (0, 'P-0003', 4);
insert into PXI values (4, 'P-0004', 3);
insert into PXI values (3, 'P-0005', 2);
insert into PXI values (2, 'P-0006', 0);

insert into SALIDAS values (2, 'EMP-111', 'PDYXLBATFWT3P1VDAHXPET3E8SCF8X', '1507-12-12', 5, 'AC21NWQ HYLII0VU7 RKWDPTB3JG5PL4PQTXW3DFEU1C5TD42C0C2TQ6M82S');
insert into SALIDAS values (1, 'EMP-333', 'GT19G  JJ3LG1L72BP3KQ4LOT5I945', '1809-6-21', 0, '8HNRJV2W1LX5ANE6LC0HLN HC8OUIE6LECCN9M90IRJT6SBSEW51JGUHX8JG');
insert into SALIDAS values (5, 'EMP-555', '61MEW45WVMHK7PGEOTA I91QM49664', '1-1-1', 1, 'FAN6111THO52B6OHLLUA7SS85J NPSK255MTQNTWNI41C2VXFHGB7MD 6GSS');
insert into SALIDAS values (4, 'EMP-111', 'EWNWLG3KBVLPGO5F 55UOUQRPX8VW3', '413-4-7', 2, '8 LBA3UYFRKCF21WEWXWJ814687VYU95TUU WPI0SOFUOE4QJF8O5QJYFC2H');
insert into SALIDAS values (0, 'EMP-444', 'VE AQ XHJXCLPQMV1K 7G8JMD4P676', '881-4-21', 3, 'V9WO17NODPYLA3439 VBQ7S6LWO2P7HKROR7AT05KHBHWBBB 6VYX LXDH9 ');
insert into SALIDAS values (3, 'EMP-444', '1E7YE9QCLJY3BK607U7HU6FKR6K3SP', '1115-12-29', 4, 'NWRL3MG88F4YVN0RYOXH3NHM0 E9VK7P15MVI206CK5H3UXJTMA3MCT7E9O1');

insert into AJUSTES values (1, 'EMP-111', 'Ajuste por inundación 01', '867-4-25', 3);
insert into AJUSTES values (2, 'EMP-444', 'Ajuste por inundación 02', '1-1-1', 2);
insert into AJUSTES values (3, 'EMP-222', 'Ajuste por inundación 03', '473-2-27', 5);

insert into PXA values (1, 'P-0001', 4);
insert into PXA values (1, 'P-0002', 0);
insert into PXA values (1, 'P-0003', 3);
insert into PXA values (2, 'P-0004', 1);
insert into PXA values (2, 'P-0005', 5);
insert into PXA values (2, 'P-0006', 2);

insert into PXS values (2, 'P-0001', 4);
insert into PXS values (1, 'P-0002', 1);
insert into PXS values (5, 'P-0003', 2);
insert into PXS values (4, 'P-0004', 0);
insert into PXS values (0, 'P-0005', 5);
insert into PXS values (3, 'P-0006', 3);

INSERT INTO COMPRAS (OCNUMERO, PRVCODIGO, OCFECHA, OCSUBTOTAL, OCDESCUENTO, OCVALOR_IVA, OCVALOR_ICE, OCFORMAPAGO, OCFACTURA_ASOCIADA, OCSTATUS)
VALUES
('OC00001', 'PRV-001', '2023-03-14', 235.50, NULL, 15.25, NULL, 'EFECT', 'FAC00001', 'ACT'),
('OC00002', 'PRV-002', '2023-04-26', 198.75, 10.00, 12.50, NULL, 'EFECT', 'FAC00002', 'INA'),
('OC00003', 'PRV-003', '2023-02-08', 420.00, 25.00, 21.00, NULL, 'EFECT', 'FAC00003', 'ACT'),
('OC00004', 'PRV-004', '2023-05-19', 675.25, NULL, 30.50, NULL, 'EFECT', 'FAC00004', 'INA'),
('OC00005', 'PRV-005', '2023-01-22', 312.80, 15.50, 18.75, NULL, 'EFECT', 'FAC00005', 'ACT'),
('OC00006', 'PRV-006', '2023-07-03', 580.00, 20.00, 25.75, 3.50, 'EFECT', 'FAC00006', 'INA'),
('OC00007', 'PRV-007', '2023-08-14', 150.00, 8.25, 9.00, NULL, 'EFECT', 'FAC00007', 'ACT'),
('OC00008', 'PRV-008', '2023-06-28', 825.50, 30.00, 45.25, NULL, 'EFECT', 'FAC00008', 'INA'),
('OC00009', 'PRV-009', '2023-09-01', 432.75, 22.50, 20.75, NULL, 'EFECT', 'FAC00009', 'ACT'),
('OC00010', 'PRV-010', '2023-10-11', 760.00, NULL, 35.00, NULL, 'EFECT', 'FAC00010', 'INA'),
('OC00011', 'PRV-011', '2023-12-25', 285.30, 12.75, 15.25, NULL, 'EFECT', 'FAC00011', 'ACT'),
('OC00012', 'PRV-012', '2023-11-08', 510.25, 25.00, 22.50, NULL, 'EFECT', 'FAC00012', 'INA'),
('OC00013', 'PRV-013', '2023-09-14', 620.00, 18.50, 30.75, 5.25, 'EFECT', 'FAC00013', 'ACT'),
('OC00014', 'PRV-014', '2023-03-28', 175.00, 9.25, 8.50, NULL, 'EFECT', 'FAC00014', 'INA'),
('OC00015', 'PRV-015', '2023-07-09', 910.50, 35.00, 42.25, NULL, 'EFECT', 'FAC00015', 'ACT'),
('OC00016', 'PRV-016', '2023-02-03', 382.75, NULL, 17.50, NULL, 'EFECT', 'FAC00016', 'INA'),
('OC00017', 'PRV-017', '2023-04-16', 425.60, 20.50, 18.75, NULL, 'EFECT', 'FAC00017', 'ACT'),
('OC00018', 'PRV-018', '2023-05-29', 690.00, 30.00, 35.25, NULL, 'EFECT', 'FAC00018', 'INA'),
('OC00019', 'PRV-019', '2023-08-02', 315.25, 15.75, 12.50, NULL, 'EFECT', 'FAC00019', 'ACT'),
('OC00020', 'PRV-020', '2023-10-15', 865.00, NULL, 40.00, NULL, 'EFECT', 'FAC00020', 'INA'),
('OC00021', 'PRV-021', '2023-12-03', 250.80, 12.25, 14.50, NULL, 'EFECT', 'FAC00021', 'ACT'),
('OC00022', 'PRV-022', '2023-11-06', 490.25, 24.50, 23.00, NULL, 'EFECT', 'FAC00022', 'INA'),
('OC00023', 'PRV-023', '2023-09-18', 610.00, 19.75, 31.25, 4.75, 'EFECT', 'FAC00023', 'ACT'),
('OC00024', 'PRV-024', '2023-01-31', 198.50, 10.00, 9.50, NULL, 'EFECT', 'FAC00024', 'INA'),
('OC00025', 'PRV-025', '2023-07-12', 930.75, 40.00, 45.75, NULL, 'EFECT', 'FAC00025', 'ACT'),
('OC00026', 'PRV-026', '2023-03-15', 352.25, NULL, 16.25, NULL, 'EFECT', 'FAC00026', 'INA'),
('OC00027', 'PRV-027', '2023-05-28', 438.00, 22.00, 19.75, NULL, 'EFECT', 'FAC00027', 'ACT'),
('OC00028', 'PRV-028', '2023-08-10', 710.50, 32.00, 38.50, NULL, 'EFECT', 'FAC00028', 'INA'),
('OC00029', 'PRV-029', '2023-10-24', 365.75, 17.50, 15.00, NULL, 'EFECT', 'FAC00029', 'ACT'),
('OC00030', 'PRV-030', '2023-12-12', 800.00, NULL, 37.50, NULL, 'EFECT', 'FAC00030', 'INA'),
('OC00031', 'PRV-031', '2023-01-19', 215.30, 11.75, 10.50, NULL, 'EFECT', 'FAC00031', 'ACT'),
('OC00032', 'PRV-032', '2023-11-02', 540.25, 27.00, 25.75, NULL, 'EFECT', 'FAC00032', 'INA'),
('OC00033', 'PRV-033', '2023-09-20', 630.00, 21.50, 33.25, 6.00, 'EFECT', 'FAC00033', 'ACT'),
('OC00034', 'PRV-034', '2023-04-06', 195.00, 10.25, 9.25, NULL, 'EFECT', 'FAC00034', 'INA'),
('OC00035', 'PRV-035', '2023-07-18', 980.25, 45.00, 47.75, NULL, 'EFECT', 'FAC00035', 'ACT'),
('OC00036', 'PRV-036', '2023-02-11', 412.50, NULL, 18.75, NULL, 'EFECT', 'FAC00036', 'INA'),
('OC00037', 'PRV-037', '2023-04-24', 455.60, 25.00, 20.50, NULL, 'EFECT', 'FAC00037', 'ACT'),
('OC00038', 'PRV-038', '2023-06-06', 720.00, 32.50, 40.25, NULL, 'EFECT', 'FAC00038', 'INA'),
('OC00039', 'PRV-039', '2023-08-19', 375.25, 16.00, 14.00, NULL, 'EFECT', 'FAC00039', 'ACT'),
('OC00040', 'PRV-040', '2023-10-03', 895.00, NULL, 42.50, NULL, 'EFECT', 'FAC00040', 'INA'),
('OC00041', 'PRV-041', '2023-12-21', 225.80, 13.50, 16.25, NULL, 'EFECT', 'FAC00041', 'ACT'),
('OC00042', 'PRV-042', '2023-11-05', 550.25, 28.00, 27.50, NULL, 'EFECT', 'FAC00042', 'ACT'),
('OC00043', 'PRV-043', '2023-09-23', 650.00, 23.75, 34.25, 7.00, 'EFECT', 'FAC00043', 'INA'),
('OC00044', 'PRV-044', '2023-03-07', 192.50, 11.50, 9.00, NULL, 'EFECT', 'FAC00044', 'ACT'),
('OC00045', 'PRV-045', '2023-05-18', 495.80, 27.50, 21.25, NULL, 'EFECT', 'FAC00045', 'INA'),
('OC00046', 'PRV-046', '2023-08-01', 275.25, 14.25, 12.75, NULL, 'EFECT', 'FAC00046', 'ACT'),
('OC00047', 'PRV-047', '2023-10-14', 800.00, NULL, 37.50, NULL, 'EFECT', 'FAC00047', 'INA'),
('OC00048', 'PRV-048', '2023-12-28', 205.30, 12.75, 10.50, NULL, 'EFECT', 'FAC00048', 'ACT'),
('OC00049', 'PRV-049', '2023-11-09', 580.25, 29.00, 25.75, NULL, 'EFECT', 'FAC00049', 'INA'),
('OC00050', 'PRV-050', '2023-09-22', 670.00, 22.50, 35.25, 8.50, 'EFECT', 'FAC00050', 'ACT'),
('OC00051', 'PRV-051', '2023-04-03', 165.00, 8.75, 8.00, NULL, 'EFECT', 'FAC00051', 'INA'),
('OC00052', 'PRV-052', '2023-07-17', 945.50, 42.50, 49.75, NULL, 'EFECT', 'FAC00052', 'ACT'),
('OC00053', 'PRV-053', '2023-02-10', 392.75, NULL, 18.00, NULL, 'EFECT', 'FAC00053', 'INA'),
('OC00054', 'PRV-054', '2023-04-22', 475.60, 24.50, 22.50, NULL, 'EFECT', 'FAC00054', 'ACT'),
('OC00055', 'PRV-055', '2023-06-05', 740.00, 34.00, 39.75, NULL, 'EFECT', 'FAC00055', 'INA'),
('OC00056', 'PRV-056', '2023-08-18', 395.25, 17.50, 15.25, NULL, 'EFECT', 'FAC00056', 'ACT'),
('OC00057', 'PRV-057', '2023-10-04', 915.00, NULL, 43.50, NULL, 'EFECT', 'FAC00057', 'INA'),
('OC00058', 'PRV-058', '2023-12-22', 235.80, 14.00, 16.75, NULL, 'EFECT', 'FAC00058', 'ACT'),
('OC00059', 'PRV-059', '2023-11-01', 550.25, 27.50, 26.00, NULL, 'EFECT', 'FAC00059', 'INA'),
('OC00060', 'PRV-060', '2023-09-21', 640.00, 22.00, 33.75, 9.25, 'EFECT', 'FAC00060', 'ACT'),
('OC00061', 'PRV-061', '2023-03-06', 182.50, 10.75, 8.75, NULL, 'EFECT', 'FAC00061', 'INA'),
('OC00062', 'PRV-062', '2023-05-17', 485.80, 26.75, 21.00, NULL, 'EFECT', 'FAC00062', 'ACT'),
('OC00063', 'PRV-063', '2023-07-31', 265.25, 13.75, 12.50, NULL, 'EFECT', 'FAC00063', 'INA'),
('OC00064', 'PRV-064', '2023-10-13', 780.00, NULL, 36.75, NULL, 'EFECT', 'FAC00064', 'ACT'),
('OC00065', 'PRV-065', '2023-12-27', 195.30, 12.25, 10.25, NULL, 'EFECT', 'FAC00065', 'INA'),
('OC00066', 'PRV-066', '2023-11-08', 570.25, 28.50, 25.50, NULL, 'EFECT', 'FAC00066', 'ACT'),
('OC00067', 'PRV-067', '2023-09-24', 660.00, 24.25, 35.50, 8.75, 'EFECT', 'FAC00067', 'INA'),
('OC00068', 'PRV-068', '2023-04-02', 155.00, 8.25, 7.75, NULL, 'EFECT', 'FAC00068', 'ACT'),
('OC00069', 'PRV-069', '2023-07-16', 930.50, 42.00, 48.50, NULL, 'EFECT', 'FAC00069', 'INA'),
('OC00070', 'PRV-070', '2023-02-09', 382.75, NULL, 17.75, NULL, 'EFECT', 'FAC00070', 'ACT'),
('OC00071', 'PRV-071', '2023-04-21', 465.60, 24.00, 22.25, NULL, 'EFECT', 'FAC00071', 'INA'),
('OC00072', 'PRV-072', '2023-06-04', 735.00, 33.50, 39.25, NULL, 'EFECT', 'FAC00072', 'ACT'),
('OC00073', 'PRV-073', '2023-08-17', 385.25, 17.00, 15.00, NULL, 'EFECT', 'FAC00073', 'INA'),
('OC00074', 'PRV-074', '2023-10-05', 925.00, NULL, 44.00, NULL, 'EFECT', 'FAC00074', 'ACT'),
('OC00075', 'PRV-075', '2023-12-23', 245.80, 14.50, 17.00, NULL, 'EFECT', 'FAC00075', 'INA'),
('OC00076', 'PRV-076', '2023-11-07', 560.25, 28.00, 26.25, NULL, 'EFECT', 'FAC00076', 'ACT'),
('OC00077', 'PRV-077', '2023-09-25', 650.00, 24.50, 36.00, 9.75, 'EFECT', 'FAC00077', 'INA'),
('OC00078', 'PRV-078', '2023-03-05', 180.50, 10.50, 8.50, NULL, 'EFECT', 'FAC00078', 'ACT'),
('OC00079', 'PRV-079', '2023-05-16', 495.00, 27.00, 20.75, NULL, 'EFECT', 'FAC00079', 'INA'),
('OC00080', 'PRV-080', '2023-07-30', 260.25, 13.50, 12.25, NULL, 'EFECT', 'FAC00080', 'ACT'),
('OC00081', 'PRV-081', '2023-10-12', 760.00, NULL, 35.75, NULL, 'EFECT', 'FAC00081', 'ACT'),
('OC00082', 'PRV-082', '2023-12-26', 185.30, 11.25, 10.75, NULL, 'EFECT', 'FAC00082', 'INA'),
('OC00083', 'PRV-083', '2023-11-06', 540.25, 27.00, 25.75, NULL, 'EFECT', 'FAC00083', 'ACT'),
('OC00084', 'PRV-084', '2023-09-26', 630.00, 23.00, 34.75, 9.00, 'EFECT', 'FAC00084', 'INA'),
('OC00085', 'PRV-085', '2023-04-01', 160.00, 8.50, 7.50, NULL, 'EFECT', 'FAC00085', 'ACT'),
('OC00086', 'PRV-086', '2023-07-15', 915.50, 41.50, 48.25, NULL, 'EFECT', 'FAC00086', 'INA'),
('OC00087', 'PRV-087', '2023-02-08', 372.75, NULL, 17.25, NULL, 'EFECT', 'FAC00087', 'ACT'),
('OC00088', 'PRV-088', '2023-04-20', 455.60, 23.75, 21.75, NULL, 'EFECT', 'FAC00088', 'INA'),
('OC00089', 'PRV-089', '2023-06-03', 730.00, 33.00, 38.75, NULL, 'EFECT', 'FAC00089', 'ACT'),
('OC00090', 'PRV-090', '2023-08-16', 380.25, 16.75, 14.75, NULL, 'EFECT', 'FAC00090', 'INA'),
('OC00091', 'PRV-091', '2023-10-03', 895.00, NULL, 42.50, NULL, 'EFECT', 'FAC00091', 'ACT'),
('OC00092', 'PRV-092', '2023-12-21', 225.80, 13.50, 16.25, NULL, 'EFECT', 'FAC00092', 'INA'),
('OC00093', 'PRV-093', '2023-11-04', 560.25, 28.00, 26.50, NULL, 'EFECT', 'FAC00093', 'ACT'),
('OC00094', 'PRV-094', '2023-09-27', 680.00, 25.00, 36.50, 9.25, 'EFECT', 'FAC00094', 'INA'),
('OC00095', 'PRV-095', '2023-03-04', 175.50, 10.25, 8.25, NULL, 'EFECT', 'FAC00095', 'ACT'),
('OC00096', 'PRV-096', '2023-05-15', 490.00, 26.25, 20.50, NULL, 'EFECT', 'FAC00096', 'INA'),
('OC00097', 'PRV-097', '2023-07-29', 255.25, 13.25, 12.00, NULL, 'EFECT', 'FAC00097', 'ACT'),
('OC00098', 'PRV-098', '2023-10-11', 740.00, NULL, 34.75, NULL, 'EFECT', 'FAC00098', 'INA'),
('OC00099', 'PRV-099', '2023-12-25', 215.80, 13.00, 15.50, NULL, 'EFECT', 'FAC00099', 'ACT'),
('OC00100', 'PRV-100', '2023-11-03', 570.25, 28.50, 26.75, NULL, 'EFECT', 'FAC00100', 'INA');
