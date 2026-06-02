# PostgreSQL

PostgreSQL is the **configurable** SQL backend for Console — a client/server
alternative to the default embedded [SQLite](sqlite.md) database. Like the
[MongoDB](../NoSQL/MongoDB/overview.md) option, switching to Postgres is a
configuration change only: set `DB_PROVIDER` and `DB_URL`, no code change
required. Use it for multi-instance or scaled deployments where a shared,
networked database is needed.

!!! info "Same schema as SQLite"
    Postgres and SQLite are both SQL backends and share the same migrations
    (`internal/app/migrations/` in the [Console source repository][console-src]).
    The repository interfaces are identical, so the application behaves the same
    on either backend. Data does **not** migrate automatically between backends.

[console-src]: https://github.com/device-management-toolkit/console

## Selecting the backend

Set `DB_PROVIDER=postgres` (or `db.provider: postgres` in `config.yml`) and
supply a `DB_URL`. See the [Database overview](../overview.md) for how
`DB_PROVIDER` chooses among all backends.

```bash
DB_PROVIDER=postgres \
DB_URL="postgres://postgresadmin:admin123@postgres:5432/rpsdb" \
console.exe
```

!!! warning "`DB_URL` is required for Postgres"
    Unlike SQLite, the Postgres backend has no embedded fallback. If
    `DB_PROVIDER=postgres` and `DB_URL` is empty, Console fails fast at startup
    with a `DB_URL required` error rather than silently defaulting to SQLite.

## Connection and pooling

- Console connects using the [`pgx`][pgx] PostgreSQL driver. The `DB_URL` must
  use the `postgres://` scheme — that prefix is what routes Console to the
  hosted-database path instead of the embedded SQLite file.
- **`DB_POOL_MAX`** (`db.pool_max`, default `2`) caps the maximum number of
  connections in the pool. It is honored by the SQL backends; tune it to match
  your deployment's concurrency.
- Foreign-key constraints are enforced.

[pgx]: https://github.com/jackc/pgx

## Quick start with Docker Compose

The `docker-compose.yml` bundled with Console includes a `postgres` service and
defaults the `app` service to the Postgres provider:

```bash
docker compose up -d
```

By default the bundled stack sets:

| Setting | Value |
|---|---|
| `DB_PROVIDER` | `postgres` |
| `DB_URL` | `postgres://postgresadmin:admin123@postgres:5432/rpsdb` |

The `postgres` is the Compose service hostname. Override `DB_PROVIDER` /
`DB_URL` to point at an external database.

!!! note "Production"
    The bundled credentials are for local development only. For production, run
    a hardened PostgreSQL deployment and point `DB_URL` at it — optionally over
    TLS. See [SSL with Local Postgres](../../../sslpostgresLocal.md) for
    enabling encrypted connections.

## Notes

- **Schema** is created and upgraded automatically from the bundled migrations
  on startup — the same set the [SQLite](sqlite.md) backend applies.
- **`APP_ENCRYPTION_KEY`** still applies: sensitive fields are encrypted by
  Console before they are written, regardless of the SQL backend. See
  [Configuration](../../configuration.md).
