drop table centros cascade constraints;
drop table trabajadores cascade constraints;
drop table partes cascade constraints;
drop table viajes cascade constraints;
drop table usuarios cascade constraints;


CREATE TABLE centros(
idCentro NUMBER(3) NOT NULL,
nombre VARCHAR2(15) NOT NULL,
telefono VARCHAR2(9) NOT NULL,
calle VARCHAR2(40) NOT NULL,
numero VARCHAR2(2) NOT NULL,
codPostal VARCHAR2(5) NOT NULL,
ciudad VARCHAR2(15) NOT NULL,
provincia VARCHAR2(15) NOT NULL,

CONSTRAINT pkIdCentro PRIMARY KEY (idCentro)
);

CREATE TABLE trabajadores(
dni VARCHAR2(9) NOT NULL,
nombre VARCHAR2(15) NOT NULL,
apellido1 VARCHAR2(20) NOT NULL,
apellido2 VARCHAR2(20) NOT NULL,
calle VARCHAR2(30) NOT NULL,
portal VARCHAR2(3) NOT NULL,
piso VARCHAR2(2) NOT NULL,
mano VARCHAR2(4) NOT NULL,
telefPersonal VARCHAR2(9),
telefEmpresa VARCHAR2(9) NOT NULL,
fechaNac DATE,
salario NUMBER(7,2),
tipoTrabajador VARCHAR2(20) NOT NULL,
centro NUMBER(3) NOT NULL,
usuario VARCHAR2(20) NOT NULL,

CONSTRAINT pkDni PRIMARY KEY (dni),
CONSTRAINT fkCentro FOREIGN KEY (centro)
  REFERENCES centros(idCentro),
CONSTRAINT ckTipo CHECK (tipoTrabajador IN ('Logistica','Administracion')
));

CREATE TABLE partes(
idParte NUMBER(10) NOT NULL,
fecha DATE NOT NULL,
kmInicio NUMBER(7) NOT NULL,
kmFinal NUMBER(7) NOT NULL,
gasolina NUMBER(4),
peaje NUMBER(3),
dietas NUMBER(3),
otros NUMBER(4),
incidencia NUMBER(4),
estado VARCHAR2(10),
trabajador VARCHAR2(9) NOT NULL,

CONSTRAINT pkParte PRIMARY KEY (idParte),
CONSTRAINT fkTrabajador FOREIGN KEY (trabajador)
  REFERENCES trabajadores(dni),
CONSTRAINT ckEstado CHECK (estado IN ('Abierto','Cerrado')),
CONSTRAINT ckKilometro CHECK (kmInicio<kmFinal)
);

CREATE TABLE viajes(
albaran NUMBER(10) NOT NULL,
horaSalida VARCHAR2(5) NOT NULL,
horaLlegada VARCHAR2(5) NOT NULL,
matricula VARCHAR2(7) NOT NULL,
parte NUMBER(10) NOT NULL,

CONSTRAINT pkAlbaran PRIMARY KEY (albaran),
CONSTRAINT fkParte FOREIGN KEY (parte)
  REFERENCES partes(idParte),
CONSTRAINT ckHora CHECK (horaSalida<horaLlegada)
);

CREATE TABLE usuarios(
idUsuario VARCHAR2(20) NOT NULL,
password VARCHAR2(16) NOT NULL,
trabajador VARCHAR2(9) NOT NULL,

CONSTRAINT pkUsuario PRIMARY KEY (idUsuario),
CONSTRAINT fkTrabajador2 FOREIGN KEY (trabajador)
  REFERENCES trabajadores(dni)
);

CREATE SYNONYM c FOR centros;
CREATE SYNONYM t FOR trabajadores;
CREATE SYNONYM p FOR partes;
CREATE SYNONYM v FOR viajes;
CREATE SYNONYM u FOR usuarios;

