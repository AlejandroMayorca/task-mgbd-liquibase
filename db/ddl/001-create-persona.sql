CREATE TABLE persona (
  id_persona BIGSERIAL PRIMARY KEY,
  tipo_documento VARCHAR(10) NOT NULL,
  numero_documento VARCHAR(20) NOT NULL,
  nombres VARCHAR(80) NOT NULL,
  apellidos VARCHAR(80) NOT NULL,
  email VARCHAR(120),
  telefono VARCHAR(30),
  fecha_nacimiento DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_persona_documento UNIQUE (tipo_documento, numero_documento),
  CONSTRAINT uq_persona_email UNIQUE (email)
);
