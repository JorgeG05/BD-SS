CREATE DATABASE PrediccionSalud

-- Tabla de Pacientes
CREATE TABLE tblPacientes (
    id_paciente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    genero VARCHAR(10) CHECK (genero IN ('Masculino', 'Femenino', 'Otro')),
    fecha_registro DATE NOT NULL DEFAULT GETDATE()
);

-- Tabla de Datos Biometricos
CREATE TABLE tblDatos_Biometricos (
    id_dato INT PRIMARY KEY IDENTITY(1,1),
    id_paciente INT NOT NULL,
    frecuencia_cardiaca FLOAT NOT NULL,
    presion_sanguinea VARCHAR(20) NOT NULL,
    temperatura_corporal FLOAT NOT NULL,
	nivel_glucosa FLOAT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_paciente) REFERENCES tblPacientes(id_paciente) ON DELETE CASCADE
);


-- Tabla de Predicciones
CREATE TABLE tblPredicciones (
    id_prediccion INT PRIMARY KEY IDENTITY(1,1),
    id_paciente INT NOT NULL,
    resultado VARCHAR(200) NOT NULL,
    probabilidad FLOAT CHECK (probabilidad BETWEEN 0 AND 100),
    fecha_prediccion DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_paciente) REFERENCES tblPacientes(id_paciente) ON DELETE CASCADE,
);

-- Tabla de Recomendaciones
CREATE TABLE tblRecomendaciones (
    id_recomendacion INT PRIMARY KEY IDENTITY(1,1),
    id_prediccion INT NOT NULL,
    descripcion TEXT NOT NULL,
    prioridad VARCHAR(20) CHECK (prioridad IN ('Alta', 'Media', 'Baja')),
    FOREIGN KEY (id_prediccion) REFERENCES tblPredicciones(id_prediccion) ON DELETE CASCADE
);

-- Insertar datos en la tabla de Pacientes
INSERT INTO tblPacientes (nombre, edad, genero)
VALUES 
('Juan Pérez', 45, 'Masculino'),
('María Gómez', 30, 'Femenino'),
('Alex Rivera', 55, 'Otro');

-- Insertar datos en la tabla de Datos Biometricos
INSERT INTO tblDatos_Biometricos (id_paciente, frecuencia_cardiaca, presion_sanguinea, temperatura_corporal, nivel_glucosa)
VALUES 
(1, 72.5, '120/80', 36.5, 95.0),
(2, 80.2, '130/85', 37.1, 105.3),
(3, 65.8, '110/75', 36.2, 90.7);

-- Insertar datos en la tabla de Predicciones
INSERT INTO tblPredicciones (id_paciente, resultado, probabilidad)
VALUES 
(1, 'Riesgo moderado de hipertensión', 60.5),
(2, 'Riesgo bajo de diabetes', 30.2),
(3, 'Riesgo alto de enfermedad cardíaca', 85.7);

-- Insertar datos en la tabla de Recomendaciones
INSERT INTO tblRecomendaciones (id_prediccion, descripcion, prioridad)
VALUES 
(1, 'Mantener una dieta baja en sodio y realizar ejercicio moderado', 'Media'),
(2, 'Reducir el consumo de azúcares y realizar controles periódicos de glucosa', 'Baja'),
(3, 'Consultar con un cardiólogo y evitar el estrés', 'Alta');

-- Seleccionar todos los datos de la tabla de Pacientes
SELECT * FROM tblPacientes;

-- Seleccionar todos los datos de la tabla de Datos Biometricos
SELECT * FROM tblDatos_Biometricos;

-- Seleccionar todos los datos de la tabla de Predicciones
SELECT * FROM tblPredicciones;

-- Seleccionar todos los datos de la tabla de Recomendaciones
SELECT * FROM tblRecomendaciones;