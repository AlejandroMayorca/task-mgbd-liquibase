CREATE TABLE detalle_factura (
  id_detalle_factura BIGSERIAL PRIMARY KEY,
  id_factura BIGINT NOT NULL,
  id_producto BIGINT NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unitario NUMERIC(12, 2) NOT NULL,
  descuento NUMERIC(12, 2) NOT NULL DEFAULT 0,
  total_linea NUMERIC(12, 2) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT ck_detalle_cantidad_pos CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_punit_nonneg CHECK (precio_unitario >= 0),
  CONSTRAINT ck_detalle_desc_nonneg CHECK (descuento >= 0),
  CONSTRAINT ck_detalle_total_nonneg CHECK (total_linea >= 0),
  CONSTRAINT fk_detalle_factura FOREIGN KEY (id_factura) REFERENCES factura (id_factura) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX idx_detalle_factura ON detalle_factura (id_factura);
CREATE INDEX idx_detalle_producto ON detalle_factura (id_producto);
CREATE UNIQUE INDEX uq_detalle_factura_producto ON detalle_factura (id_factura, id_producto);
