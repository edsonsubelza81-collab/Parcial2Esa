CREATE DATABASE Parcial2Esa;
USE Parcial2Esa; 
CREATE LOGIN usrparcial2 with password = '123456',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF,
DEFAULT_DATABASE = Parcial2Esa

GO
USE Parcial2Esa;
GO 
CREATE USER usrparcial2 FOR LOGIN usrparcial2
GO 
ALTER ROLE db_owner ADD MEMBER usrparcial2
GO

DROP TABLE IF EXISTS Canal;
DROP TABLE IF EXISTS Programa;

CREATE TABLE Canal (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    frecuencia VARCHAR(20) NOT NULL,
    
);


CREATE TABLE Programa (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    idCanal INT NOT NULL,
    titulo VARCHAR(100) NOT NULL ,
    descripcion VARCHAR(250) ,
    duracion INT NOT NULL,
    productor VARCHAR(100) NOT NULL ,
    fechaEstreno DATE NOT NULL ,


    CONSTRAINT FK_Programa_Canal FOREIGN KEY (idCanal)
    REFERENCES Canal(id)
);

ALTER TABLE Canal ADD estado SMALLINT NOT NULL DEFAULT 1; 
ALTER TABLE Programa ADD estado SMALLINT NOT NULL DEFAULT 1; 


GO  
CREATE PROC paProgramaListar @parametro  VARCHAR(50)
AS
SELECT 
p.id, 
    p.idCanal, 
    p.titulo, 
    p.descripcion, 
    p.duracion, 
    p.productor, 
    p.fechaEstreno, 
    p.estado,
    c.nombre AS nombreCanal, 
    c.frecuencia             

FROM Programa P
INNER JOIN Canal ca ON ca.id = P.idCanal
WHERE P.estado >-1 AND p.titulo + p.descripcion LIKE '%' + REPLACE (@parametro,' ', '%')+'%'
ORDER BY p.estado DESC, p.titulo ASC;
EXEC paProgramaListar '';

--DML
INSERT INTO Canal (nombre, frecuencia) 
VALUES 
('Unitel', '2.1 HD'),
('Red ATB', '9.0 SD'),
('Bolivia TV', '7.1 HD'),
('Canal Universitario', '13.0 SD'),
('PAT', '3.1 HD'),
('RTP', '4.0 SD');

INSERT INTO Programa (idCanal, titulo, descripcion, duracion, productor, fechaEstreno)
VALUES 
(1, 'Noticiero Unitel', 'Noticias nacionales e internacionales', 60, 'Juan Perez', '2020-01-15'),
(2, 'Deportes ATB', 'Resumen de eventos deportivos', 30, 'Maria Gomez', '2019-05-20'),
(3, 'Cultura Bolivia', 'Programas culturales y artísticos', 45, 'Carlos Lopez', '2021-03-10'),
(4, 'Educativo Universitario', 'Contenido educativo para estudiantes', 50, 'Ana Martinez', '2018-09-05'),
(5, 'Entretenimiento PAT', 'Variedades y shows de entretenimiento', 40, 'Luis Fernandez', '2022-11-25'),
(6, 'Documentales RTP', 'Documentales sobre naturaleza y sociedad', 70, 'Sofia Ramirez', '2017-07-30');

EXEC paProgramaListar '';
EXEC paProgramaListar 'entretenimiento';

SELECT * FROM Canal;
SELECT * FROM Programa;