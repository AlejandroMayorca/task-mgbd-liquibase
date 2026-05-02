INSERT INTO rol (nombre, descripcion)
VALUES
  ('ADMIN', 'Administrador del sistema'),
  ('VENDEDOR', 'Usuario con permisos de venta');

INSERT INTO persona (tipo_documento, numero_documento, nombres, apellidos, email, telefono, fecha_nacimiento)
VALUES
  ('CC', '100000001', 'Alejandro', 'Gomez', 'alejandro.gomez@correo.com', '3000000001', '2001-05-15'),
  ('CC', '100000002', 'Maria', 'Lopez', 'maria.lopez@correo.com', '3000000002', '2002-02-10'),
  ('CC', '100000003', 'Carlos', 'Perez', 'carlos.perez@correo.com', '3000000003', '2000-11-20');

INSERT INTO usuario (username, password_hash, activo, id_persona, id_rol)
VALUES
  (
    'carlos.v',
    'demo_hash',
    TRUE,
    (SELECT id_persona FROM persona WHERE tipo_documento = 'CC' AND numero_documento = '100000003'),
    (SELECT id_rol FROM rol WHERE nombre = 'VENDEDOR')
  ),
  (
    'admin',
    'demo_hash_admin',
    TRUE,
    (SELECT id_persona FROM persona WHERE tipo_documento = 'CC' AND numero_documento = '100000001'),
    (SELECT id_rol FROM rol WHERE nombre = 'ADMIN')
  );

INSERT INTO producto (nombre, descripcion, precio, stock, activo)
VALUES
  ('Laptop 14', 'Portátil 14 pulgadas', 2500000.00, 10, TRUE),
  ('Mouse USB', 'Mouse óptico', 45000.00, 50, TRUE),
  ('Teclado', 'Teclado estándar', 90000.00, 30, TRUE),
  ('Sticker', 'Producto de prueba para eliminar', 2000.00, 100, TRUE);

WITH f AS (
  INSERT INTO factura (numero, id_cliente, id_usuario, subtotal, impuesto, total, estado)
  VALUES (
    'F-0001',
    (SELECT id_persona FROM persona WHERE tipo_documento = 'CC' AND numero_documento = '100000002'),
    (SELECT id_usuario FROM usuario WHERE username = 'carlos.v'),
    0,
    0,
    0,
    'EMITIDA'
  )
  RETURNING id_factura
)
INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario, descuento, total_linea)
SELECT
  f.id_factura,
  p.id_producto,
  d.cantidad,
  p.precio,
  d.descuento,
  (p.precio * d.cantidad) - d.descuento
FROM f
JOIN (
  VALUES
    ('Laptop 14', 1, 0.00),
    ('Mouse USB', 2, 5000.00)
) AS d(nombre_producto, cantidad, descuento)
  ON TRUE
JOIN producto p
  ON p.nombre = d.nombre_producto;

UPDATE factura f
SET
  subtotal = x.subtotal,
  impuesto = ROUND(x.subtotal * 0.19, 2),
  total = ROUND(x.subtotal * 1.19, 2)
FROM (
  SELECT id_factura, SUM(total_linea) AS subtotal
  FROM detalle_factura
  GROUP BY id_factura
) x
WHERE f.id_factura = x.id_factura;
