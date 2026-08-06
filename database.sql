-- 1. Base de Datos
CREATE DATABASE IF NOT EXISTS NoESteam;
USE NoESteam;

-- 2. Tabla Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla Forma de Pago (Solo Crédito y Débito predeterminados)
CREATE TABLE IF NOT EXISTS forma_pago (
    id_forma_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Insertar de manera predeterminada solo Crédito y Débito
INSERT INTO forma_pago (id_forma_pago, nombre) VALUES 
(1, 'Tarjeta de Crédito'),
(2, 'Tarjeta de Débito')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- 4. Tabla Juegos
CREATE TABLE IF NOT EXISTS juegos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    logo VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL
);

-- 5. Tabla Compras (Guarda el comprobante con los datos de la tarjeta procesada)
CREATE TABLE IF NOT EXISTS compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_juego INT NOT NULL,
    id_forma_pago INT NOT NULL,
    titular_tarjeta VARCHAR(100) NOT NULL,
    ultimos_4_digitos VARCHAR(4) NOT NULL, -- Guardamos solo los últimos 4 dígitos por seguridad
    fecha_expiracion_tarjeta VARCHAR(7) NOT NULL, -- Formato MM/AA
    monto_total DECIMAL(10, 2) NOT NULL,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juegos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_forma_pago) REFERENCES forma_pago(id_forma_pago) ON DELETE RESTRICT
);
