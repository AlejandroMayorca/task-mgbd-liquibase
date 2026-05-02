CREATE TABLE producto (
  id_producto BIGSERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  descripcion VARCHAR(300),
  precio NUMERIC(12, 2) NOT NULL,
  stock INTEGER NOT NULL DEFAULT 0,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT ck_producto_precio_nonneg CHECK (precio >= 0),
  CONSTRAINT ck_producto_stock_nonneg CHECK (stock >= 0),
  CONSTRAINT uq_producto_nombre UNIQUE (nombre)
);

CREATE INDEX idx_producto_activo ON producto (activo);
