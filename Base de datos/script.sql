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
VALUES ('admin', 'admin', 'admin', 'admin', 'admin', '2020-01-01', NULL, '', 'admin', true, 'desconectado', false);