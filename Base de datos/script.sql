CREATE DATABASE clivel;

USE clivel;

CREATE TABLE Usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(30) NOT NULL,
    contrasenia VARCHAR(30) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidos VARCHAR(35) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    fecha_nacimiento date,   
    foto VARCHAR(200) NULL,
    fondo VARCHAR(200) NULL,
    descripcion VARCHAR(200) NULL,
    rol VARCHAR(20) NOT NULL,
    experto BOOLEAN NOT NULL,
    estado VARCHAR(20) NOT NULL,
    usuario_cambiado BOOLEAN NOT NULL,
    PRIMARY KEY (id_usuario)
);

CREATE TABLE Notificacion (
    id_usuario INT NOT NULL,
    id_usuario_notificacion INT NOT NULL,
    estado VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_usuario, id_usuario_notificacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Amigos (
    id_usuario INT NOT NULL,
    id_usuario_amigo INT NOT NULL,
    favorito BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_usuario, id_usuario_amigo),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_usuario_amigo) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Novedad (
    id_novedad INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(40) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    version VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_novedad),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Comunidad (
    id_comunidad INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    imagen BLOB,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_comunidad),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Mensaje (
    id_mensaje INT NOT NULL AUTO_INCREMENT,
    id_usuario_emisor INT NOT NULL,
    id_usuario_receptor INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    mensaje_texto VARCHAR(300) NULL,
    mensaje_binario BLOB NULL,
    fecha_envio DATE NOT NULL,
    enviado BOOLEAN NULL,
    visto BOOLEAN NULL,
    PRIMARY KEY (id_mensaje),
    FOREIGN KEY (id_usuario_emisor) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_usuario_receptor) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Noticia (
    id_noticia INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(40) NOT NULL,
    descripcion VARCHAR(2000) NOT NULL,
    imagen BLOB NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_noticia),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Juego (
    id_juego INT NOT NULL,
    PRIMARY KEY (id_juego)
);

CREATE TABLE Valoracion (
    id_valoracion INT NOT NULL AUTO_INCREMENT,
    id_juego INT NOT NULL,
    id_usuario INT NOT NULL,
    comentario VARCHAR(400) NOT NULL,
    opinion VARCHAR(20) NOT NULL,
    fecha_valoracion DATE NOT NULL,
    PRIMARY KEY (id_valoracion),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_juego) REFERENCES Juego(id_juego)
);

CREATE TABLE Like_ (
    id_like INT NOT NULL AUTO_INCREMENT,
    id_valoracion INT NOT NULL,
    id_usuario INT NOT NULL,
    opinion VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_like),
    FOREIGN KEY (id_valoracion) REFERENCES Valoracion(id_valoracion),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

INSERT INTO Usuario (usuario, contrasenia, nombre, apellidos, correo, fecha_nacimiento, foto, descripcion, rol, experto, estado, usuario_cambiado)
VALUES ('admin', 'admin', 'admin', 'admin', 'admin', '2020-01-01', NULL, '', 'admin', true, 'desconectado', false),
('johndoe', 'password', 'John', 'Doe', 'johndoe@example.com', '1990-05-15', NULL, '', 'normal', false, 'conectado', false),
('janedoe', 'password', 'Jane', 'Doe', 'janedoe@example.com', '1992-08-22', NULL, '', 'normal', false, 'conectado', false),
('bobsmith', 'password', 'Bob', 'Smith', 'bobsmith@example.com', '1985-11-03', NULL, '', 'normal', false, 'conectado', false),
('alicesmith', 'password', 'Alice', 'Smith', 'alicesmith@example.com', '1988-02-12', NULL, '', 'normal', false, 'conectado', false),
('mikejohnson', 'password', 'Mike', 'Johnson', 'mikejohnson@example.com', '1993-07-19', NULL, '', 'normal', false, 'conectado', false),
('emilywilson', 'password', 'Emily', 'Wilson', 'emilywilson@example.com', '1991-04-27', NULL, '', 'normal', false, 'conectado', false),
('davidbrown', 'password', 'David', 'Brown', 'davidbrown@example.com', '1987-09-08', NULL, '', 'normal', false, 'conectado', false),
('sarahmiller', 'password', 'Sarah', 'Miller', 'sarahmiller@example.com', '1989-12-17', NULL, '', 'normal', false, 'conectado', false),
('alexthomas', 'password', 'Alex', 'Thomas', 'alexthomas@example.com', '1994-02-05', NULL, '', 'normal', false, 'conectado', false),
('laurajones', 'password', 'Laura', 'Jones', 'laurajones@example.com', '1990-06-30', NULL, '', 'normal', false, 'conectado', false),
('maria', 'password', 'María', 'Gómez', 'maria@example.com', '1991-01-01', NULL, '', 'normal', false, 'conectado', false),
('jose', 'password', 'José', 'López', 'jose@example.com', '1992-02-02', NULL, '', 'normal', false, 'conectado', false),
('angela', 'password', 'Ángela', 'Fernández', 'angela@example.com', '1993-03-03', NULL, '', 'normal', false, 'conectado', false),
('andres', 'password', 'Andrés', 'Rodríguez', 'andres@example.com', '1994-04-04', NULL, '', 'normal', false, 'conectado', false),
('isabel', 'password', 'Isabel', 'García', 'isabel@example.com', '1995-05-05', NULL, '', 'normal', false, 'conectado', false),
('francisco', 'password', 'Francisco', 'Martínez', 'francisco@example.com', '1996-06-06', NULL, '', 'normal', false, 'conectado', false),
('carmen', 'password', 'Carmen', 'Sánchez', 'carmen@example.com', '1997-07-07', NULL, '', 'normal', false, 'conectado', false),
('manuel', 'password', 'Manuel', 'González', 'manuel@example.com', '1998-08-08', NULL, '', 'normal', false, 'conectado', false),
('lucia', 'password', 'Lucía', 'Romero', 'lucia@example.com', '1999-09-09', NULL, '', 'normal', false, 'conectado', false),
('carlos', 'password', 'Carlos', 'Pérez', 'carlos@example.com', '2000-10-10', NULL, '', 'normal', false, 'conectado', false),
('sara', 'password', 'Sara', 'Hernández', 'sara@example.com', '2001-11-11', NULL, '', 'normal', false, 'conectado', false),
('antonio', 'password', 'Antonio', 'Jiménez', 'antonio@example.com', '2002-12-12', NULL, '', 'normal', false, 'conectado', false),
('ana', 'password', 'Ana', 'Torres', 'ana@example.com', '2003-01-13', NULL, '', 'normal', false, 'conectado', false),
('pedro', 'password', 'Pedro', 'Vargas', 'pedro@example.com', '2004-02-14', NULL, '', 'normal', false, 'conectado', false),
('beatriz', 'password', 'Beatriz', 'Molina', 'beatriz@example.com', '2005-03-15', NULL, '', 'normal', false, 'conectado', false),
('javier', 'password', 'Javier', 'Ortega', 'javier@example.com', '2006-04-16', NULL, '', 'normal', false, 'conectado', false),
('patricia', 'password', 'Patricia', 'Delgado', 'patricia@example.com', '2007-05-17', NULL, '', 'normal', false, 'conectado', false),
('daniel', 'password', 'Daniel', 'Cruz', 'daniel@example.com', '2008-06-18', NULL, '', 'normal', false, 'conectado', false),
('marcos', 'password', 'Marcos', 'Méndez', 'marcos@example.com', '2009-07-19', NULL, '', 'normal', false, 'conectado', false),
('luisa', 'password', 'Luisa', 'Peña', 'luisa@example.com', '2010-08-20', NULL, '', 'normal', false, 'conectado', false);