#Crear base de datos
CREATE DATABASE Universidad;
USE Universidad;
# tablas
#Estudiantes
CREATE TABLE Estudiante(
idEstudiante INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45),
apellido VARCHAR(75),
correo VARCHAR(100)
);
#Profesores
CREATE TABLE Profesor(
idProfesor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45),
apellido VARCHAR(75),
correo VARCHAR(100)

);
#Cursos
CREATE TABLE Curso(
idCurso INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45),
#Clave foranea
idProfesor INT,
FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)
);

#Grados
CREATE TABLE Grado(
idGrado INT AUTO_INCREMENT PRIMARY KEY,
calificacion DECIMAL(3,2),
idEstudiante INT,
idCurso INT,
FOREIGN KEY (idEstudiante) REFERENCES Estudiante(idEstudiante),
FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);
#----Relleno de datos----

#Estudiantes
INSERT INTO Estudiante(nombre, apellido, correo)
VALUES 
("Elene","Aran","elene_aran@gmail.com"),
("Mai", "Ruiz", "mai_ruiz@gmail.com"),
("Irati", "Amu", "irati_amu@gmail.com"),
("Aitzi", "Ru", "aitzi_ru@gmail.com");

#Profesores
INSERT INTO Profesor(nombre, apellido, correo)
VALUES 

("Martine","Beitia","martine_beitia@gmail.com"),
("Olatz", "Izar", "olatz_izar@gmail.com"),
("Ene", "Aristi", "ene_aristi@gmail.com"),
("Arrate", "Alza", "arrate_alza@gmail.com");

#Cursos
INSERT INTO Curso(nombre, idProfesor)
VALUES 
("Programacion", "1"),
("Euskera", "2"),
("Ingles", "3"),
("Frances", "4");

#Grados
INSERT INTO Grado( idEstudiante, idCurso,calificacion)
VALUES 

( 1, 1, 8.50),
( 1, 2, 7.58),
( 1, 3, 7.45),
( 1, 4, 9.50),
( 2, 2, 6.58),
( 2, 3, 7.50),
( 3, 1, 5.50),
( 3, 2, 7.95),
( 4, 3, 2.45);

#---Calificacion media de cada profesor---
SELECT p.nombre, AVG(g.calificacion)
FROM Profesor p
JOIN Curso c ON p.idProfesor = c.idProfesor
JOIN Grado g ON c.idCurso = g.idCurso
GROUP BY p.nombre;

#---Calificacion superior para cada estudiante---
SELECT e.nombre, MAX(g.calificacion)
FROM Estudiante e
JOIN Grado g ON e.idEstudiante = g.idEstudiante
GROUP BY e.nombre;

#---Ordenar estudiante por cursos inscritos---
SELECT e.nombre, GROUP_CONCAT(c.nombre ORDER BY c.nombre ASC)
FROM Estudiante e
JOIN Grado g ON e.idEstudiante = g.idEstudiante
JOIN Curso c ON g.idCurso = c.idCurso
GROUP BY e.nombre;

#---Informe resumido de los cursos y sus calificaciones --
SELECT c.nombre, AVG(g.calificacion) as CalificacionMedia
FROM Curso c
JOIN Grado g ON c.idCurso = g.idCurso
GROUP BY c.nombre
ORDER BY CalificacionMedia ASC;

#----Estudiante y profesor con mas cursos en comun----
SELECT e.nombre, p.nombre, COUNT(*) as CursosEnComun
FROM Estudiante e
JOIN Grado g ON e.idEstudiante = g.idEstudiante
JOIN Curso c ON c.idCurso = c.idCurso
JOIN Profesor p ON c.idProfesor = p.idProfesor
GROUP BY e.nombre, p.nombre
ORDER BY CursosEnComun DESC
LIMIT 1;


