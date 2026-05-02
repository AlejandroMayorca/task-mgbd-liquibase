## Evidencias de ejecución

Este archivo sirve para registrar los comandos usados y sus salidas (si el docente las solicita).

## Comandos

```bash
docker compose down -v
docker compose up -d db

docker compose run --rm liquibase validate
docker compose run --rm liquibase update
docker compose run --rm liquibase status --verbose
```

## Validaciones en PostgreSQL

```bash
docker compose exec db psql -U postgres -d mgdb_liquibase -c "\\dt"
docker compose exec db psql -U postgres -d mgdb_liquibase -c "SELECT * FROM persona;"
docker compose exec db psql -U postgres -d mgdb_liquibase -c "SELECT * FROM factura;"
```

## Consultas del taller

```bash
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/001-select-personas.sql
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/002-select-facturas.sql
docker compose exec -T db psql -U postgres -d mgdb_liquibase -f scripts/queries/003-select-detalle-factura.sql
```

## Resultados (pegar aquí)

- Salida de `validate`:

```

```

- Salida de `update`:

```

```

- Salida de `status --verbose`:

```

```
