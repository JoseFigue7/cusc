-- ==========================================
-- Base de Datos para Centro Universitario
-- ==========================================
-- Este archivo es OPCIONAL y proporciona una estructura
-- de base de datos para funcionalidades avanzadas

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS centrouniversitario
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE centrouniversitario;

-- ==========================================
-- Tabla: contactos
-- Almacena los mensajes del formulario de contacto
-- ==========================================

CREATE TABLE IF NOT EXISTS contactos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    interes VARCHAR(50) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    respondido BOOLEAN DEFAULT FALSE,
    ip_address VARCHAR(45),
    user_agent TEXT,
    INDEX idx_fecha (fecha),
    INDEX idx_leido (leido),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================
-- Tabla: carreras
-- Información de las carreras disponibles
-- ==========================================

CREATE TABLE IF NOT EXISTS carreras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    duracion_anos INT NOT NULL,
    modalidad ENUM('presencial', 'virtual', 'semipresencial') DEFAULT 'presencial',
    nivel ENUM('tecnico', 'licenciatura', 'maestria', 'doctorado') DEFAULT 'licenciatura',
    imagen VARCHAR(255),
    icono VARCHAR(50),
    requisitos TEXT,
    plan_estudios TEXT,
    campo_laboral TEXT,
    fecha_inicio DATE,
    precio_mensual DECIMAL(10, 2),
    activa BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_activa (activa),
    INDEX idx_nivel (nivel)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar carreras de ejemplo
INSERT INTO carreras (nombre, descripcion, duracion_anos, nivel, icono, precio_mensual) VALUES
('Ingeniería en Sistemas', 'Forma profesionales capaces de analizar, diseñar, desarrollar e implementar soluciones tecnológicas innovadoras.', 4, 'licenciatura', 'laptop', 5000.00),
('Administración de Empresas', 'Forma líderes empresariales con visión estratégica capaces de gestionar organizaciones de manera eficiente.', 4, 'licenciatura', 'briefcase', 4500.00),
('Medicina', 'Forma médicos altamente capacitados con conocimientos científicos y humanísticos para el cuidado de la salud.', 6, 'licenciatura', 'heart-pulse', 8000.00),
('Derecho', 'Defiende la justicia y los derechos, conviértete en un profesional del ámbito legal.', 5, 'licenciatura', 'bank', 4800.00),
('Marketing Digital', 'Domina las estrategias digitales y conecta marcas con sus audiencias en el mundo online.', 3, 'licenciatura', 'graph-up-arrow', 4200.00),
('Arquitectura', 'Diseña espacios innovadores y contribuye al desarrollo urbano con creatividad y técnica.', 5, 'licenciatura', 'rulers', 5500.00);

-- ==========================================
-- Tabla: noticias
-- Noticias y eventos de la universidad
-- ==========================================

CREATE TABLE IF NOT EXISTS noticias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    resumen TEXT NOT NULL,
    contenido LONGTEXT NOT NULL,
    categoria ENUM('institucional', 'internacional', 'eventos', 'logros', 'becas', 'cultura') DEFAULT 'institucional',
    imagen VARCHAR(255),
    autor VARCHAR(100) NOT NULL,
    fecha_publicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    destacada BOOLEAN DEFAULT FALSE,
    activa BOOLEAN DEFAULT TRUE,
    visitas INT DEFAULT 0,
    slug VARCHAR(255) UNIQUE,
    meta_description TEXT,
    INDEX idx_categoria (categoria),
    INDEX idx_fecha (fecha_publicacion),
    INDEX idx_destacada (destacada),
    INDEX idx_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar noticias de ejemplo
INSERT INTO noticias (titulo, resumen, contenido, categoria, autor) VALUES
('Inauguración de Nuevos Laboratorios de Tecnología', 
 'Presentamos nuestros modernos laboratorios equipados con tecnología de última generación para fortalecer el aprendizaje práctico de nuestros estudiantes.',
 'En un evento especial, la universidad inauguró sus nuevos laboratorios de tecnología, equipados con lo último en hardware y software para la formación de estudiantes en áreas como inteligencia artificial, desarrollo de software y ciberseguridad.',
 'institucional', 'Administración'),

('Nuevo Convenio de Intercambio con Universidades Europeas',
 'Firmamos acuerdos de intercambio estudiantil con prestigiosas universidades de España, Francia y Alemania.',
 'La universidad ha firmado convenios de colaboración con instituciones europeas de prestigio, abriendo oportunidades de intercambio académico y cultural para nuestros estudiantes.',
 'internacional', 'Relaciones Internacionales'),

('Gran Feria de Empleo 2025',
 'Participa en nuestra feria anual de empleo con más de 50 empresas líderes buscando talento universitario.',
 'La feria conectará a estudiantes y graduados con empresas líderes en diversos sectores. Inscripciones abiertas en el portal universitario.',
 'eventos', 'Bolsa de Trabajo');

-- ==========================================
-- Tabla: inscripciones
-- Solicitudes de inscripción de estudiantes
-- ==========================================

CREATE TABLE IF NOT EXISTS inscripciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    carrera_id INT,
    nivel_estudios ENUM('secundaria', 'preparatoria', 'licenciatura', 'otro') NOT NULL,
    promedio DECIMAL(4, 2),
    documento_identidad VARCHAR(50),
    direccion TEXT,
    ciudad VARCHAR(100),
    estado VARCHAR(100),
    codigo_postal VARCHAR(10),
    nombre_tutor VARCHAR(150),
    telefono_tutor VARCHAR(20),
    estado_solicitud ENUM('pendiente', 'en_revision', 'aceptada', 'rechazada') DEFAULT 'pendiente',
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    notas TEXT,
    FOREIGN KEY (carrera_id) REFERENCES carreras(id),
    INDEX idx_estado (estado_solicitud),
    INDEX idx_email (email),
    INDEX idx_fecha (fecha_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================
-- Tabla: usuarios (administradores)
-- Para un futuro panel de administración
-- ==========================================

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    rol ENUM('admin', 'editor', 'moderador') DEFAULT 'editor',
    activo BOOLEAN DEFAULT TRUE,
    ultimo_login DATETIME,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Usuario administrador por defecto (contraseña: admin123)
-- IMPORTANTE: Cambiar la contraseña después de la instalación
INSERT INTO usuarios (username, email, password, nombre_completo, rol) VALUES
('admin', 'admin@centrouniversitario.edu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin');

-- ==========================================
-- Tabla: configuracion
-- Configuraciones generales del sitio
-- ==========================================

CREATE TABLE IF NOT EXISTS configuracion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    clave VARCHAR(100) UNIQUE NOT NULL,
    valor TEXT,
    descripcion TEXT,
    tipo ENUM('texto', 'numero', 'boolean', 'json') DEFAULT 'texto',
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Configuraciones iniciales
INSERT INTO configuracion (clave, valor, descripcion, tipo) VALUES
('nombre_universidad', 'Centro Universitario', 'Nombre oficial de la institución', 'texto'),
('email_contacto', 'informes@centrouniversitario.edu', 'Email principal de contacto', 'texto'),
('telefono_contacto', '+52 (555) 123-4567', 'Teléfono principal', 'texto'),
('direccion', 'Calle Yaquis, Lt 1, Mz. 11, Esquina Huehuecoyotl, Colonia Culturas de México, Chalco, Estado de México, C.P. 56607', 'Dirección física', 'texto'),
('facebook_url', 'https://facebook.com', 'URL de Facebook', 'texto'),
('twitter_url', 'https://twitter.com', 'URL de Twitter', 'texto'),
('instagram_url', 'https://instagram.com', 'URL de Instagram', 'texto'),
('linkedin_url', 'https://linkedin.com', 'URL de LinkedIn', 'texto'),
('youtube_url', 'https://youtube.com', 'URL de YouTube', 'texto'),
('inscripciones_abiertas', '1', 'Estado de inscripciones', 'boolean'),
('mensaje_mantenimiento', '', 'Mensaje durante mantenimiento', 'texto');

-- ==========================================
-- Tabla: testimonios
-- Testimonios de estudiantes y graduados
-- ==========================================

CREATE TABLE IF NOT EXISTS testimonios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera VARCHAR(100),
    generacion VARCHAR(20),
    foto VARCHAR(255),
    testimonio TEXT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    destacado BOOLEAN DEFAULT FALSE,
    aprobado BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_destacado (destacado),
    INDEX idx_aprobado (aprobado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================
-- Tabla: eventos
-- Calendario de eventos universitarios
-- ==========================================

CREATE TABLE IF NOT EXISTS eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME,
    ubicacion VARCHAR(200),
    tipo ENUM('conferencia', 'taller', 'seminario', 'feria', 'cultural', 'deportivo', 'otro') DEFAULT 'otro',
    imagen VARCHAR(255),
    cupo_maximo INT,
    inscritos INT DEFAULT 0,
    requiere_inscripcion BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_fecha_inicio (fecha_inicio),
    INDEX idx_tipo (tipo),
    INDEX idx_activo (activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================
-- Vista: estadisticas_contactos
-- Vista para reportes de contactos
-- ==========================================

CREATE OR REPLACE VIEW estadisticas_contactos AS
SELECT 
    DATE(fecha) as fecha_dia,
    COUNT(*) as total_mensajes,
    SUM(CASE WHEN leido = TRUE THEN 1 ELSE 0 END) as mensajes_leidos,
    SUM(CASE WHEN respondido = TRUE THEN 1 ELSE 0 END) as mensajes_respondidos,
    interes,
    COUNT(DISTINCT email) as emails_unicos
FROM contactos
GROUP BY DATE(fecha), interes;

-- ==========================================
-- Vista: carreras_populares
-- Vista de carreras más solicitadas
-- ==========================================

CREATE OR REPLACE VIEW carreras_populares AS
SELECT 
    c.id,
    c.nombre,
    c.nivel,
    COUNT(i.id) as total_solicitudes,
    c.precio_mensual
FROM carreras c
LEFT JOIN inscripciones i ON c.id = i.carrera_id
WHERE c.activa = TRUE
GROUP BY c.id, c.nombre, c.nivel, c.precio_mensual
ORDER BY total_solicitudes DESC;

-- ==========================================
-- Procedimiento: limpiar_mensajes_antiguos
-- Limpia mensajes de contacto antiguos (opcional)
-- ==========================================

DELIMITER //

CREATE PROCEDURE limpiar_mensajes_antiguos(dias INT)
BEGIN
    DELETE FROM contactos 
    WHERE fecha < DATE_SUB(NOW(), INTERVAL dias DAY)
    AND leido = TRUE 
    AND respondido = TRUE;
END //

DELIMITER ;

-- ==========================================
-- Trigger: actualizar_inscritos_evento
-- Actualiza el contador de inscritos
-- ==========================================

-- (Este es solo un ejemplo, necesitarías una tabla de inscripciones_eventos)

-- ==========================================
-- Índices adicionales para optimización
-- ==========================================

-- Índice compuesto para búsquedas comunes
CREATE INDEX idx_contactos_fecha_interes ON contactos(fecha, interes);
CREATE INDEX idx_noticias_activa_fecha ON noticias(activa, fecha_publicacion);

-- ==========================================
-- Comentarios finales
-- ==========================================

-- Esta estructura de base de datos proporciona:
-- 1. Almacenamiento de mensajes de contacto
-- 2. Gestión de carreras y contenido
-- 3. Sistema de inscripciones
-- 4. Noticias y eventos
-- 5. Testimonios de estudiantes
-- 6. Panel de administración básico
-- 7. Configuraciones del sitio

-- Para usar esta base de datos:
-- 1. Importa este archivo en phpMyAdmin o MySQL Workbench
-- 2. Actualiza contacto.php para usar la base de datos
-- 3. Crea archivos PHP adicionales para gestión de contenido

-- Comandos útiles:
-- Ver todas las tablas: SHOW TABLES;
-- Ver estructura: DESCRIBE nombre_tabla;
-- Respaldar BD: mysqldump -u usuario -p centrouniversitario > backup.sql

