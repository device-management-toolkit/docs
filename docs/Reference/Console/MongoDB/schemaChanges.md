# Schema Changes

The Go entity in `internal/entity/<entity>.go` is the single source of truth.
Both backends derive their behavior from it, but each requires distinct
bookkeeping when a field is added, removed, or changed.

| Aspect | SQL backend (schema-on-write) | MongoDB backend (schema-on-read) |
|---|---|---|
| Shape enforcement | database (DDL) | application (repo code) |
| Where the shape is declared | `internal/app/migrations/*.sql` | nowhere — no DDL, no `ALTER TABLE` |
| Repo write obligation | name every column in `Insert` / `Update` / `Scan` | include every field in the `bson.M{"$set": …}` document |
| Missed field at runtime | SQL error: `unknown column` (loud) | field silently dropped from the document (silent) |

!!! warning "Missed fields in `$set` are silent"
    Forget a field in `Update`'s `$set` map and the MongoDB driver writes the
    document without it — no error is returned. The api-test workflow's
    `build-mongo` job (running the full Postman collection against a real
    MongoDB) is the authoritative parity check that surfaces this drift.

## Add a nullable field

| Step | SQL backend | MongoDB backend |
|---|---|---|
| 1. Entity struct | add the field to `internal/entity/<entity>.go` | same file — add a `bson:"<name>"` struct tag |
| 2. Schema | add `<timestamp>_<name>.up.sql` and `.down.sql` under `internal/app/migrations/` | none — schemaless |
| 3. `Insert` | add to `squirrel.Insert(...).Columns(...)` / `.Values(...)` in `internal/usecase/sqldb/<entity>.go` | none — `InsertOne(ctx, e)` serializes the struct by its `bson` tags |
| 4. `Update` | add to the `squirrel.Update(...).Set(...)` chain | add the key to the `bson.M{"$set": …}` map in `internal/usecase/nosqldb/mongo/<entity>.go` |
| 5. `Get` / `Scan` | add to the projection and `rows.Scan(...)` targets | none — `cur.All(...)` / `Decode(...)` populates any field present |
| 6. Index (optional) | migration with `CREATE INDEX` | new `IndexModel` in `ensureIndexes` (`client.go`) |

## Variations

Each row lists only the delta from the procedure above.

| Change | SQL backend | MongoDB backend |
|---|---|---|
| `NOT NULL` with default | migration must include `DEFAULT` to backfill existing rows — e.g., `ALTER TABLE profiles ADD COLUMN uefi_wifi_sync_enabled BOOLEAN NOT NULL DEFAULT FALSE` | existing documents lack the field; reads return the Go zero value. Optional backfill: `db.profiles.updateMany({uefiwifisyncenabled: {$exists: false}}, {$set: {uefiwifisyncenabled: false}})` |
| Unique constraint | migration with `CREATE UNIQUE INDEX ... ON profiles (profilename, tenantid)`; existing duplicates must be removed first | new unique `IndexModel` in `ensureIndexes` (optionally collated); existing duplicates block startup |
| Drop a field | migration `ALTER TABLE devices DROP COLUMN mpspassword` (`.down.sql` re-adds) | stop writing it in `Insert` / `Update`; old documents retain it. Optional cleanup: `db.devices.updateMany({}, {$unset: {mpspassword: 1}})` |
| Rename or change type | dual-write → backfill → switch reads → drop the old shape, across multiple releases | identical multi-release pattern |
| Foreign-key relationship | `FOREIGN KEY` constraint in the migration | no native foreign keys — enforce in the use-case layer (parent lookup before child insert) |

## Files to change together

A change to `internal/entity/<entity>.go` typically touches:

```text
internal/app/migrations/<timestamp>_<name>.up.sql
internal/app/migrations/<timestamp>_<name>.down.sql
internal/usecase/sqldb/<entity>.go
internal/usecase/nosqldb/mongo/<entity>.go
internal/usecase/nosqldb/mongo/fields.go     # if used as a filter or sort key
internal/usecase/nosqldb/mongo/client.go     # if it needs a unique index
```
