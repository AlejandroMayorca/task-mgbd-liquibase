SELECT
  f.id_factura,
  f.numero,
  f.fecha,
  f.estado,
  f.subtotal,
  f.impuesto,
  f.total,
  (pc.nombres || ' ' || pc.apellidos) AS cliente,
  u.username AS vendedor
FROM factura f
JOIN persona pc ON pc.id_persona = f.id_cliente
JOIN usuario u ON u.id_usuario = f.id_usuario
ORDER BY f.fecha DESC, f.id_factura DESC;
