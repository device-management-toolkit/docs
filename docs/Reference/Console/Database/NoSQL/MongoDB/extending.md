# Adding a New NoSQL DB

`internal/usecase/nosqldb/` is a parent directory by design — it holds the
MongoDB backend today and is the home for future NoSQL siblings such as
Cassandra, DynamoDB, or Couchbase. The design is **closed for modification,
open for extension**: none of the existing use-case or HTTP code changes — you
add a new package and wire it in.

!!! note "Illustrative placeholder"
    `cassandra` below is a placeholder used to illustrate the pattern; it is
    not a supported backend. Substitute the backend you are actually adding.

## What you change

| # | Step | File(s) |
|---|---|---|
| 1 | Create the package — one file per repository, plus shared infrastructure (`client.go`, `errors.go`, `fields.go`) | new `internal/usecase/nosqldb/<name>/` |
| 2 | Implement each `Repository` interface, with a compile-time guard per repo | the new package |
| 3 | Add a provider constant — `ProviderCassandra = "cassandra"` | `internal/app/repos.go` |
| 4 | Add a `build<Name>Repos(cfg, log) (*usecase.Repos, error)` constructor that dials the driver and registers a `Closer` for graceful shutdown | `internal/app/repos.go` |
| 5 | Add `case Provider<Name>:` to the `buildRepos` switch | `internal/app/repos.go` |
| 6 | Extend the migration-skip guard — NoSQL backends manage their own schema | `internal/app/migrate.go` |
| 7 | Add a `build-<name>` CI job mirroring `build-mongo` (starts the DB in Docker, runs the Postman collection) — the authoritative end-to-end parity check | `.github/workflows/api-test.yml` |
| 8 | Unit tests against the driver's wire-level mock when one ships (e.g., `drivertest.NewMockDeployment` for `mongo-driver/v2`); step 7 covers end-to-end | new `internal/usecase/nosqldb/<name>/*_test.go` |

## What you don't change

| File | Why |
|---|---|
| `internal/usecase/usecase.go` | Purely interface-based — never touched. |
| `internal/usecase/<feature>/…` | Use cases consume interfaces, not concrete drivers. |
| Any HTTP handler | Calls use cases, not repositories. |
| `internal/usecase/sqldb/…` | The SQL backend is entirely orthogonal. |

## Package layout (step 1)

```text
internal/usecase/nosqldb/cassandra/
    client.go              # Connect/Disconnect, index or schema setup, database name
    device.go              # implements devices.Repository
    domain.go              # implements domains.Repository
    profile.go             # implements profiles.Repository
    ciraconfig.go
    ieee8021xconfig.go
    wificonfig.go
    profilewificonfig.go
    errors.go              # reuse repoerrors via consoleerrors.CreateConsoleError
    fields.go              # centralize column / field name constants
```

## Wiring snippets (steps 2–6)

**Step 2 — repository guard** (one per repo file under `internal/usecase/nosqldb/<name>/`)

```go
var _ devices.Repository = (*DeviceRepo)(nil)
```

**Step 3 — provider constant** (`internal/app/repos.go`)

```go
const ProviderCassandra = "cassandra"
```

**Step 4 — constructor** (`internal/app/repos.go`)

```go
func buildCassandraRepos(cfg *config.Config, log logger.Interface) (*usecase.Repos, error) {
    // dial the driver, optionally run schema setup, then return
    // &usecase.Repos{ Devices: ..., Domains: ..., Closer: usecase.CloserFunc(...) }
}
```

**Step 5 — switch case** (`internal/app/repos.go`, inside `buildRepos`)

```go
case ProviderCassandra:
    return buildCassandraRepos(cfg, log)
```

**Step 6 — migration skip** (`internal/app/migrate.go`)

The current check is a single equality (`cfg.Provider == ProviderMongo`); adding a backend turns it into an OR (or a small set).

```go
if cfg.Provider == ProviderMongo || cfg.Provider == ProviderCassandra {
    return nil // NoSQL backends manage their own schema
}
```
