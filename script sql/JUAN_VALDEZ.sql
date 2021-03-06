CREATE TABLESPACE JUAN_VALDEZ
DATAFILE 'D:\USIL\CLASES\2018-02\Implementacion y gestion de bases de datos\guardados\bases_de_datos\JUAN_VALDEZ.DBF'
SIZE 100M;


CREATE TABLE Categoria
(
    categoria_id    NUMBER         PRIMARY KEY,
    nombre          VARCHAR(20)    NOT NULL,
    tipo            VARCHAR2(20)   NOT NULL,
    fecha_registro  DATE           NOT NULL,
    descripcion     VARCHAR2(250)   
);



CREATE TABLE Cliente 
(
    cliente_Id          NUMBER            PRIMARY KEY,
    nombre              VARCHAR2(25)      NOT NULL, 
    apel_mat            VARCHAR2(25)      NOT NULL,
    apel_pat            VARCHAR2(25)      NOT NULL,
    dni                 CHAR(8)           NOT NULL,
    telefono            CHAR(10),
    fecha_nacimiento    DATE,
    correo              VARCHAR2(50),
    tarjeta_id          NUMBER,
    CategoriaId         NUMBER            REFERENCES Categoria
);

CREATE TABLE Proveedor
(
    proveedor_id        NUMBER          PRIMARY KEY,
    nomb_comp           VARCHAR2(100)   NOT NULL,
    direccion           VARCHAR2(200)   NOT NULL,
    telefono            NUMBER          NOT NULL,
    correo              VARCHAR2(50)
);

CREATE TABLE Producto
(
producto_id NUMBER  PRIMARY KEY,
nombre      VARCHAR2(50)  NOT NULL,
precio      DECIMAL(10,2) NOT NULL,
descripcion VARCHAR2(100)  NOT NULL,
promocion   CHAR(10)      NULL
);

CREATE TABLE Bebida
(
    bebida_id       NUMBER          NOT NULL    REFERENCES Producto,
    tam             VARCHAR2(10)    NULL, --tamanio de presentacion
    temperatura     VARCHAR2(10)    ,   -- fria o caliente
    PRIMARY KEY(bebida_id)
);

CREATE TABLE Acompaniamiento
(
    acomp_id        NUMBER          NOT NULL    REFERENCES Producto,
    sabor           VARCHAR2(10)    , -- salado o dulce
    PRIMARY KEY(acomp_id)
);

CREATE TABLE Insumo
(
    insumo_id       NUMBER       PRIMARY KEY,
    nombre          VARCHAR2(30) NOT NULL,
    tipo            VARCHAR2(30) NOT NULL,
    costo_unidad    NUMBER       NOT NULL,
    cantidad        NUMBER       NOT NULL,
    proveedor_id    NUMBER       REFERENCES Proveedor
);


CREATE TABLE Lote
(
    lote_id             NUMBER      PRIMARY KEY,
    fecha_entrega       DATE        NOT NULL,
    fecha_vencimiento   DATE        NOT NULL,
    cantidad            NUMBER      NOT NULL,
    proveedor_id        NUMBER      REFERENCES Proveedor,
    acomp_id            NUMBER      REFERENCES Acompaniamiento
);


CREATE TABLE Bebida_Insumo
(
insumo_id       NUMBER  REFERENCES Insumo,
bebida_id       NUMBER  REFERENCES Bebida,
cantidad        DECIMAL, -- cuanto de un insumo contiene el producto
primary key(insumo_id,bebida_id)
);


CREATE TABLE Sucursal
(
sucursal_id     NUMBER          PRIMARY KEY,
pais            VARCHAR2(20)    NOT NULL,
region          VARCHAR2(20)    NOT NULL,
direccion       CHAR(30)        NOT NULL
);


CREATE TABLE Recibo
(
    recibo_id       NUMBER  PRIMARY KEY,
    precio_total    NUMBER  NOT NULL,
    fecha_venta     DATE    NOT NULL,
    cliente_id      NUMBER  REFERENCES Cliente,
    sucursal_id     NUMBER  NOT NULL REFERENCES Sucursal
);

CREATE TABLE Detalle_Recibo
(
    producto_id     NUMBER  NOT NULL    REFERENCES  Producto,
    recibo_id       NUMBER  NOT NULL    REFERENCES  Recibo,
    primary key(producto_id, recibo_id)
);

CREATE TABLE Trabajador
(
trabajador_id           NUMBER          PRIMARY KEY,
nombre                  VARCHAR2(25)    NOT NULL, 
apel_mat                VARCHAR2(25)    NOT NULL,
apel_pat                VARCHAR2(25)    NOT NULL,
dni                     CHAR(8)         NOT NULL,
puesto                  VARCHAR(50)     NOT NULL,
telefono                CHAR(8)         NOT NULL,
correo                  VARCHAR2(200),
direccion               VARCHAR2(200),
fecha_contratacion      DATE            NOT NULL,
edad                    NUMBER          NOT NULL
);

CREATE TABLE Administrativo
(
adminis_id  NUMBER  NOT NULL    REFERENCES  Trabajador,
PRIMARY KEY(adminis_id)
);

CREATE TABLE Administrativo_Sucursal
(
adminis_id  NUMBER  NOT NULL    REFERENCES  Administrativo,
sucursal_id NUMBER  NOT NULL    REFERENCES  Sucursal,
primary key(adminis_id, sucursal_id)
);

CREATE TABLE Operativo
(
operat_id   NUMBER  REFERENCES  Trabajador,
sucursal_id NUMBER  REFERENCES  Sucursal,
puesto      VARCHAR2(50),
PRIMARY KEY(operat_id)
);




