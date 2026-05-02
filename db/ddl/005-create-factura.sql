CREATE TABLE factura (
  id_factura BIGSERIAL PRIMARY KEY,
  numero VARCHAR(30) NOT NULL,
  fecha TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  id_cliente BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  subtotal NUMERIC(12, 2) NOT NULL DEFAULT 0,
  impuesto NUMERIC(12, 2) NOT NULL DEFAULT 0,
  total NUMERIC(12, 2) NOT NULL DEFAULT 0,
  estado VARCHAR(20) NOT NULL DEFAULT 'EMITIDA',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_factura_numero UNIQUE (numero),
  CONSTRAINT ck_factura_subtotal_nonneg CHECK (subtotal >= 0),
  CONSTRAINT ck_factura_impuesto_nonneg CHECK (impuesto >= 0),
  CONSTRAINT ck_factura_total_nonneg CHECK (total >= 0),
  CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente) REFERENCES persona (id_persona) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_factura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX idx_factura_cliente ON factura (id_cliente);
CREATE INDEX idx_factura_usuario ON factura (id_usuario);
