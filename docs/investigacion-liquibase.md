## Liquibase (resumen)

Liquibase es una herramienta de control de versiones para bases de datos. Permite definir y ejecutar cambios de forma ordenada y reproducible mediante un registro interno (`DATABASECHANGELOG`) que guarda qué cambios ya fueron aplicados.

## Conceptos mínimos

- Changelog: archivo principal que lista los cambios a ejecutar (en este repositorio: `db/changelog/db.changelog-master.yaml`).
- Changeset: unidad atómica de cambio (id + author + contenido). Se ejecuta una sola vez por base de datos.
- Checksum: huella que Liquibase calcula para detectar cambios en un changeset ya aplicado.
- Rollback: reversión de un cambio (si se define). En escenarios académicos puede omitirse, pero en producción es una práctica recomendada.

## DDL y DML

- DDL: define estructura (tablas, llaves primarias/foráneas, restricciones, índices).
- DML: manipula datos (insert, update, delete) para cargar datos de prueba u operaciones.

En este taller se separan en carpetas:

- `db/ddl/` para estructura
- `db/dml/` para datos y operaciones

## Docker Compose

Docker Compose permite levantar servicios como:

- `db`: PostgreSQL
- `liquibase`: contenedor que ejecuta `validate`, `update` y `status` contra `db`

Esto hace que el profesor pueda ejecutar la validación sin configuración manual adicional.

## Buenas prácticas aplicadas

- Cambios numerados y en orden (001, 002, ...).
- Restricciones y llaves foráneas para garantizar integridad.
- Datos de prueba mínimos para validar joins y consultas.
