# Database

Console stores its data in a single database that you select at startup. Three
backends are supported behind identical repository interfaces, so the
application behaves the same regardless of which one is in use — switching is a
configuration change only, with no code change.

- **[SQLite](SQL/sqlite.md)** — the default. Embedded, on-disk, zero setup.
- **[Postgres](SQL/postgres.md)** — a configurable client/server SQL backend.
- **[MongoDB](NoSQL/MongoDB/overview.md)** — a configurable NoSQL backend.

## Selecting the backend

Set `DB_PROVIDER` (or `db.provider` in `config.yml`):

| `DB_PROVIDER` | Backend | `DB_URL` |
|---|---|---|
| `sqlite` *(default; also when unset)* | [Embedded SQLite](SQL/sqlite.md) | *ignored — uses a local file* |
| `postgres` | [PostgreSQL](SQL/postgres.md) | **required** — `postgres://user:pass@host:5432/dbname` |
| `mongo` | [MongoDB](NoSQL/MongoDB/overview.md) | **required** — `mongodb://user:pass@host:27017/?authSource=admin` |

Notes:

- **`DB_URL`** is required for `postgres` and `mongo`, and ignored for `sqlite`
  (which always uses its embedded on-disk file). With `postgres` or `mongo`
  selected but no `DB_URL`, Console fails fast at startup rather than silently
  falling back to SQLite.
- **`DB_POOL_MAX`** (`db.pool_max`, default `2`) is honored by the SQL backends
  only. The MongoDB driver manages its own connection pool via `DB_URL` options
  such as `maxPoolSize`.
- Data does **not** migrate automatically between backends. Each backend stores
  its data independently.

See [Configuration](../configuration.md) for the full list of `DB_*` variables.
