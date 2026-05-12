# MongoDB

MongoDB is an alternative storage backend for Console — a drop-in replacement
for the default SQLite / PostgreSQL SQL backends. Switching is a configuration
change only: no code change, no schema migration. The repository interfaces are
identical across backends, so the use-case and HTTP layers are unaware of which
one is in use.

!!! info "API compatibility"
    The MongoDB backend is fully API-compatible with the SQL backends.
    Everything available through the Console UI or REST API behaves the same on
    either backend. Data does **not** migrate automatically between backends.

## Selecting the backend

Set `DB_PROVIDER` (or `db.provider` in `config.yml`):

| `DB_PROVIDER` | Backend | `DB_URL` example |
|---|---|---|
| `sqlite` *(default; also when unset)* | Embedded SQLite | *none — uses a local file* |
| `postgres` | PostgreSQL | `postgres://user:pass@host:5432/dbname` |
| `mongo` | MongoDB | `mongodb://user:pass@host:27017/?authSource=admin` |

Notes:

- `DB_POOL_MAX` is honored only by the SQL backends. The MongoDB driver manages
  its own connection pool, configured through `DB_URL` options such as
  `maxPoolSize`. See [MongoDB connection string options][mongo-conn-opts] for
  the full list.

[mongo-conn-opts]: https://www.mongodb.com/docs/manual/reference/connection-string-options/

!!! note "Source paths in this section"
    File paths and CI workflow references in the pages that follow (e.g.,
    `internal/usecase/nosqldb/mongo/`, `internal/app/repos.go`,
    `.github/workflows/api-test.yml`) refer to the
    [Console source repository][console-src], not to this docs repo.

[console-src]: https://github.com/device-management-toolkit/console

## Next steps

- [Quick Start with Docker Compose](quickStart.md) — bring up the bundled
  `mongo` service, point Console at it, and verify the deployment.
- [Collections and Indexes](collections.md) — what Console creates inside the
  `consoledb` database.
- [Schema Changes](schemaChanges.md) — the bookkeeping each backend needs
  when an entity changes.
- [Adding a New NoSQL DB](extending.md) — extending the `nosqldb` package with
  another backend.
