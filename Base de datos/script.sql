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

CREATE TABLE FAQ (
    id_FAQ INT NOT NULL AUTO_INCREMENT,
    pregunta VARCHAR(150) NOT NULL,
    respuesta VARCHAR(600) NOT NULL,
    PRIMARY KEY (id_FAQ)
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


CREATE TABLE Juego (
    id_juego INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    fechaLanzamiento VARCHAR(40) NOT NULL,
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
VALUES ('admin', 'admin', 'admin', 'admin', 'admin', '2000-01-01', NULL, '', 'admin', true, 'desconectado', false),
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
('luisa', 'password', 'Luisa', 'Peña', 'luisa@example.com', '2010-08-20', NULL, '', 'normal', false, 'conectado', false),
('johnsmith', 'password', 'John', 'Smith', 'johnsmith@example.com', '1990-01-01', NULL, '', 'normal', false, 'conectado', false),
('emmawilson', 'password', 'Emma', 'Wilson', 'emmawilson@example.com', '1992-02-02', NULL, '', 'normal', false, 'conectado', false),
('michaeltaylor', 'password', 'Michael', 'Taylor', 'michaeltaylor@example.com', '1993-03-03', NULL, '', 'normal', false, 'conectado', false),
('sophiaroberts', 'password', 'Sophia', 'Roberts', 'sophiaroberts@example.com', '1995-04-04', NULL, '', 'normal', false, 'conectado', false),
('williamthompson', 'password', 'William', 'Thompson', 'williamthompson@example.com', '1996-05-05', NULL, '', 'normal', false, 'conectado', false),
('olivertaylor', 'password', 'Oliver', 'Taylor', 'olivertaylor@example.com', '1998-06-06', NULL, '', 'normal', false, 'conectado', false),
('isabellawalker', 'password', 'Isabella', 'Walker', 'isabellawalker@example.com', '1999-07-07', NULL, '', 'normal', false, 'conectado', false),
('jamesmitchell', 'password', 'James', 'Mitchell', 'jamesmitchell@example.com', '2001-08-08', NULL, '', 'normal', false, 'conectado', false),
('ameliawhite', 'password', 'Amelia', 'White', 'ameliawhite@example.com', '2002-09-09', NULL, '', 'normal', false, 'conectado', false),
('benjaminrodriguez', 'password', 'Benjamin', 'Rodriguez', 'benjaminrodriguez@example.com', '2004-10-10', NULL, '', 'normal', false, 'conectado', false),
('lucasjohnson', 'password', 'Lucas', 'Johnson', 'lucasjohnson@example.com', '1990-01-01', NULL, '', 'normal', false, 'conectado', false),
('victoriathomas', 'password', 'Victoria', 'Thomas', 'victoriathomas@example.com', '1992-02-02', NULL, '', 'normal', false, 'conectado', false),
('ethanharris', 'password', 'Ethan', 'Harris', 'ethanharris@example.com', '1993-03-03', NULL, '', 'normal', false, 'conectado', false),
('ameliamartin', 'password', 'Amelia', 'Martin', 'ameliamartin@example.com', '1995-04-04', NULL, '', 'normal', false, 'conectado', false),
('olivermiller', 'password', 'Oliver', 'Miller', 'olivermiller@example.com', '1996-05-05', NULL, '', 'normal', false, 'conectado', false),
('charlottesmith', 'password', 'Charlotte', 'Smith', 'charlottesmith@example.com', '1998-06-06', NULL, '', 'normal', false, 'conectado', false),
('liammorgan', 'password', 'Liam', 'Morgan', 'liammorgan@example.com', '1999-07-07', NULL, '', 'normal', false, 'conectado', false),
('ameliataylor', 'password', 'Amelia', 'Taylor', 'ameliataylor@example.com', '2001-08-08', NULL, '', 'normal', false, 'conectado', false),
('danielrodriguez', 'password', 'Daniel', 'Rodriguez', 'danielrodriguez@example.com', '2002-09-09', NULL, '', 'normal', false, 'conectado', false),
('harperwilson', 'password', 'Harper', 'Wilson', 'harperwilson@example.com', '2004-10-10', NULL, '', 'normal', false, 'conectado', false),
('usuario1', 'usuario1', 'usuario', 'usuario', 'usuario1@usuario.com', '2004-10-10', NULL, '', 'normal', false, 'conectado', false);

INSERT INTO Juego (id_juego, nombre, fechaLanzamiento)
VALUES
   (3328, 'The Witcher 3: Wild Hunt', '2015-05-18'),
   (3498, 'Grand Theft Auto V', '2013-09-17'),
   (4062, 'BioShock Infinite', '2013-03-26'),
   (5286, 'Tomb Raider (2013)', '2013-03-05');

INSERT INTO Valoracion (id_valoracion, id_juego, id_usuario, comentario, opinion, fecha_valoracion)
VALUES
   (NULL, 3328, 2, 'Gran juego, me encantó la historia y los gráficos.', 'Excelente', '2023-06-08'),
   (NULL, 3328, 3, 'Me gustó mucho, pero algunos aspectos podrían mejorar.', 'Bueno', '2023-06-09'),
   (NULL, 3328, 4, 'No fue lo que esperaba, bastante aburrido.', 'Pasar', '2023-06-10'),
   (NULL, 3328, 21, 'Me encantó, uno de mis juegos favoritos.', 'Excelente', '2023-06-01'),
   (NULL, 3328, 22, 'Buenos gráficos y jugabilidad.', 'Bueno', '2023-06-02'),
   (NULL, 3328, 23, 'No es mi tipo de juego, no me gustó.', 'Pasar', '2023-06-03');
   


INSERT INTO Valoracion (id_valoracion, id_juego, id_usuario, comentario, opinion, fecha_valoracion)
VALUES
   (NULL, 3498, 5, 'Uno de los mejores juegos de mundo abierto que he jugado.', 'Excelente', '2023-06-08'),
   (NULL, 3498, 6, 'La historia es increíble, pero el modo online es aburrido.', 'Bueno', '2023-06-09'),
   (NULL, 3498, 7, 'No es mi tipo de juego, no me gustó.', 'Pasar', '2023-06-10'),
   (NULL, 3498, 24, 'Divertido y emocionante, lo recomiendo.', 'Excelente', '2023-06-01'),
   (NULL, 3498, 25, 'El mundo abierto ofrece muchas posibilidades.', 'Bueno', '2023-06-02'),
   (NULL, 3498, 26, 'No me gustó la violencia del juego.', 'Pasar', '2023-06-03');
   


INSERT INTO Valoracion (id_valoracion, id_juego, id_usuario, comentario, opinion, fecha_valoracion)
VALUES
   (NULL, 4062, 8, 'Una experiencia única, me encantó.', 'Excelente', '2023-06-08'),
   (NULL, 4062, 9, 'Buena jugabilidad, pero la historia no me atrapó.', 'Bueno', '2023-06-09'),
   (NULL, 4062, 10, 'No me gustó, no entendí la trama.', 'Pasar', '2023-06-10'),
   (NULL, 4062, 27, 'Historia intrigante, me mantuvo enganchado.', 'Excelente', '2023-06-01'),
   (NULL, 4062, 28, 'Excelentes gráficos, pero la jugabilidad no es tan buena.', 'Bueno', '2023-06-02'),
   (NULL, 4062, 29, 'No entendí la trama, me confundió.', 'Pasar', '2023-06-03');
   


INSERT INTO Valoracion (id_valoracion, id_juego, id_usuario, comentario, opinion, fecha_valoracion)
VALUES
   (NULL, 5286, 11, 'El juego tiene buenos gráficos, pero la historia es débil.', 'Aceptable', '2023-06-08'),
   (NULL, 5286, 12, 'Me gustó, pero esperaba más desafío.', 'Bueno', '2023-06-09'),
   (NULL, 5286, 13, 'No me gustó la jugabilidad, no lo recomendaría.', 'Pasar', '2023-06-10'),
   (NULL, 5286, 30, 'Buena historia y acción.', 'Aceptable', '2023-06-01'),
   (NULL, 5286, 31, 'Gráficos impresionantes, pero se vuelve repetitivo.', 'Bueno', '2023-06-02'),
   (NULL, 5286, 32, 'No me gustó la protagonista, no me identifiqué.', 'Pasar', '2023-06-03');


INSERT INTO FAQ (pregunta, respuesta) 
VALUES 
    ('¿Cómo puedo cambiar mi contraseña?', 'Para cambiar tu contraseña, pulsa en tu foto de perfil y pulsa en editar perfil, luego debes buscar el campo "Contraseña". Allí podrás ingresar una nueva contraseña y confirmar los cambios.'),
    ('¿Cómo puedo agregar amigos?', 'En la pestaña de amigos, estando registrado podrás pulsar en un botón que tiene un icono de un más, luego le llegará una petición al usuario que deseas agregar y cuando te acepte sereis amigos y podréis hablar'),
    ('¿Cuando llegará la pestaña de comunidades?', 'Estamos en desarrollo, es la seccion con la que queremos que clivel sea una página única por eso nos está llevando mucho tiempo el desarrollo, de momento podéis ver un concepto y probablemente llegue a finales de año o comienzos del siguiente.'),
    ('¿Cómo puedo escribir un comentario sobre un juego?', 'Para ello debes ir a la seccón juegos, seleccionar en uno de ellos y cuando veas la información sobre ese juego tendrás que bajar y podrás ver un botón para añadir comentarios, solo está disponible para usuarios registrados.'),
    ('¿Qué es la estrella en la página amigos?', 'La estrella simboliza los amigos favoritos, cuando pulses en la estrella que principalmente aparece vacía al lado de cada usuario podrás pulsar en la estrella principal para filtrar por amigos favoritos.');
