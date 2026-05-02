CREATE TABLE usuario (
  id_usuario BIGSERIAL PRIMARY KEY,
  username VARCHAR(60) NOT NULL,
  password_hash VARCHAR(200) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  id_persona BIGINT NOT NULL,
  id_rol BIGINT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_usuario_username UNIQUE (username),
  CONSTRAINT fk_usuario_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX idx_usuario_persona ON usuario (id_persona);
CREATE INDEX idx_usuario_rol ON usuario (id_rol);
