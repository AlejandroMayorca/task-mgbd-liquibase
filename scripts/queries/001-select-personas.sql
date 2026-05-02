SELECT
  p.id_persona,
  p.tipo_documento,
  p.numero_documento,
  p.nombres,
  p.apellidos,
  p.email,
  p.telefono,
  u.username,
  r.nombre AS rol
FROM persona p
LEFT JOIN usuario u ON u.id_persona = p.id_persona
LEFT JOIN rol r ON r.id_rol = u.id_rol
ORDER BY p.id_persona;
