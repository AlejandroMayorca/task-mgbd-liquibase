# task-mgbd-liquibase

Taller investigativo y práctico: construcción de base de datos con Liquibase, Docker y PostgreSQL.

## Requisitos

- Docker Desktop (con Docker Compose)

## Estructura del repositorio

- Dockerfile
- docker-compose.yml
- liquibase.properties
- db/
  - changelog/
    - db.changelog-master.yaml
  - init/
    - 001-create-liquibase-schema.sql
  - ddl/
    - 001-create-persona.sql
    - 002-create-rol.sql
    - 003-create-usuario.sql
    - 004-create-producto.sql
    - 005-create-factura.sql
    - 006-create-detalle-factura.sql
  - dml/
    - 001-insert-data.sql
    - 002-update-data.sql
    - 003-delete-data.sql
- scripts/
  - queries/
    - 001-select-personas.sql
    - 002-select-facturas.sql
    - 003-select-detalle-factura.sql
- docs/
  - investigacion-liquibase.md
  - evidencias.md

## Ejecución (validación reproducible)

Desde la raíz del repositorio:

```bash
docker compose down -v
docker compose up -d db

docker compose run --rm liquibase validate
docker compose run --rm liquibase update
docker compose run --rm liquibase status --verbose
```

## Validación en PostgreSQL

```bash
docker compose exec db psql -U postgres -d mgdb_liquibase -c "\\dt"
docker compose exec db psql -U postgres -d mgdb_liquibase -c "SELECT * FROM persona;"
docker compose exec db psql -U postgres -d mgdb_liquibase -c "SELECT * FROM factura;"
```

Nota: las tablas internas de Liquibase (`databasechangelog`, `databasechangeloglock`) se crean en el esquema `liquibase` para que en `public` solo existan las 6 tablas del taller. Para verlas:

```bash
docker compose exec db psql -U postgres -d mgdb_liquibase -c "\\dt liquibase.*"
```

## Consultas de verificación (recomendado)

```bash
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/001-select-personas.sql
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/002-select-facturas.sql
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/003-select-detalle-factura.sql
```
