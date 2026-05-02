SELECT
  f.numero AS factura,
  p.nombre AS producto,
  df.cantidad,
  df.precio_unitario,
  df.descuento,
  df.total_linea
FROM detalle_factura df
JOIN factura f ON f.id_factura = df.id_factura
JOIN producto p ON p.id_producto = df.id_producto
ORDER BY f.numero, p.nombre;
