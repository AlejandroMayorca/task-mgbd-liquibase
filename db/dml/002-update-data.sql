UPDATE persona
SET telefono = '3009999999'
WHERE tipo_documento = 'CC' AND numero_documento = '100000002';

UPDATE producto
SET stock = stock - 2
WHERE nombre = 'Mouse USB' AND stock >= 2;

UPDATE detalle_factura df
SET
  descuento = 7000.00,
  total_linea = (df.precio_unitario * df.cantidad) - 7000.00
WHERE df.id_factura = (SELECT id_factura FROM factura WHERE numero = 'F-0001')
  AND df.id_producto = (SELECT id_producto FROM producto WHERE nombre = 'Mouse USB');

UPDATE factura f
SET
  subtotal = x.subtotal,
  impuesto = ROUND(x.subtotal * 0.19, 2),
  total = ROUND(x.subtotal * 1.19, 2),
  estado = 'PAGADA'
FROM (
  SELECT id_factura, SUM(total_linea) AS subtotal
  FROM detalle_factura
  GROUP BY id_factura
) x
WHERE f.id_factura = x.id_factura
  AND f.numero = 'F-0001';
