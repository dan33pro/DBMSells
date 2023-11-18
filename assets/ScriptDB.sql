CREATE TABLE Usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(50) NOT NULL UNIQUE,
  codPais INT NOT NULL DEFAULT 57,
  numeroCelular VARCHAR(15) NOT NULL,
  id_rol INT NOT NULL
);

CREATE TABLE Autenticacion (
  id_usuario INT PRIMARY KEY,
  userPassword VARCHAR(100) NOT NULL
);

CREATE TABLE Roles (
  id_rol INT PRIMARY KEY AUTO_INCREMENT,
  nombreRol VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Productos (
  id_producto INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  descripcion VARCHAR(600) NOT NULL,
  precio VARCHAR(50) NOT NULL,
  empresa VARCHAR(50) NOT NULL,
  id_tipo_producto INT NOT NULL,
  id_admin INT NOT NULL,
  imagen BLOB NULL
);

CREATE TABLE TiposProducto (
  id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT,
  detalle VARCHAR(60)
);

CREATE TABLE Rutas (
  id_ruta INT PRIMARY KEY AUTO_INCREMENT,
  nombre_ruta VARCHAR(50) NOT NULL,
  id_admin INT NOT NULL,
  id_vendedor INT NOT NULL,
  id_entregador INT NOT NULL
);

CREATE TABLE Clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(50) NOT NULL UNIQUE,
  codPais INT NOT NULL DEFAULT 57,
  numeroCelular VARCHAR(15) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  id_ruta INT NOT NULL
);

CREATE TABLE Pedidos (
  id_pedido INT PRIMARY KEY AUTO_INCREMENT,
  notas VARCHAR(100) NOT NULL,
  id_estado INT NOT NULL,
  id_cliente INT NOT NULL,
  fecha  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total VARCHAR(100)
);

CREATE TABLE Estados (
  id_estado INT PRIMARY KEY AUTO_INCREMENT,
  estado VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE DetallesPedido (
  id_producto INT NOT NULL,
  id_pedido INT NOT NULL,
  cantidad INT NOT NULL,
  total VARCHAR(100),
  PRIMARY KEY(id_producto, id_pedido)
);

ALTER TABLE Usuarios ADD FOREIGN KEY (id_rol) REFERENCES Roles (id_rol);
ALTER TABLE Autenticacion ADD FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario);
ALTER TABLE Productos ADD FOREIGN KEY (id_admin) REFERENCES Usuarios (id_usuario);
ALTER TABLE Productos ADD FOREIGN KEY (id_tipo_producto) REFERENCES TiposProducto (id_tipo_producto);
ALTER TABLE Rutas ADD FOREIGN KEY (id_admin) REFERENCES Usuarios (id_usuario);
ALTER TABLE Rutas ADD FOREIGN KEY (id_vendedor) REFERENCES Usuarios (id_usuario);
ALTER TABLE Rutas ADD FOREIGN KEY (id_entregador) REFERENCES Usuarios (id_usuario);
ALTER TABLE Clientes ADD FOREIGN KEY (id_ruta) REFERENCES Rutas (id_ruta);
ALTER TABLE Pedidos ADD FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente);
ALTER TABLE Pedidos ADD FOREIGN KEY (id_estado) REFERENCES Estados (id_estado);
ALTER TABLE DetallesPedido ADD FOREIGN KEY (id_producto) REFERENCES Productos (id_producto);
ALTER TABLE DetallesPedido ADD FOREIGN KEY (id_pedido) REFERENCES Pedidos (id_pedido);

-- Información por deafult
INSERT INTO Roles (id_rol, nombreRol) VALUES(null, "Administrador");
INSERT INTO Roles (id_rol, nombreRol) VALUES(null, "Vendedor");
INSERT INTO Roles (id_rol, nombreRol) VALUES(null, "Entregador");

INSERT INTO Estados  (id_estado, estado) VALUES(null, "Regsitrado");
INSERT INTO Estados  (id_estado, estado) VALUES(null, "Entregado");
INSERT INTO Estados  (id_estado, estado) VALUES(null, "Devuelto");

-- Modificaciones
ALTER TABLE Autenticacion DROP FOREIGN KEY Autenticacion_ibfk_1;
ALTER TABLE Autenticacion ADD CONSTRAINT Autenticacion_ibfk_1 FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE;