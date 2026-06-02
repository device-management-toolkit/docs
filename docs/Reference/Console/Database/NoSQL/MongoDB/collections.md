# Collections and Indexes

Console uses a fixed database name, `consoledb`. Collections and their unique
indexes are created at startup by `ensureIndexes` — creating an index
materializes the collection too. Collection names mirror the SQL table names,
and every collection carries a `tenantid` field. Most unique indexes are
scoped per tenant; the one exception is called out below the table.

| Collection | Unique index |
|---|---|
| `devices` | `(guid, tenantid)` |
| `profiles` | `(profilename, tenantid)` |
| `ciraconfigs` | `(configname, tenantid)` |
| `domains` | `(profilename, tenantid)` |
| `domains` | `(domainsuffix, tenantid)` |
| `domains` | `(profilename, domainsuffix)` — case-insensitive collation |
| `ieee8021xconfigs` | `(profilename, tenantid)` |
| `wirelessconfigs` | `(profilename, tenantid)` |
| `profiles_wirelessconfigs` | `(profilename, wirelessprofilename, priority, tenantid)` |

These indexes reproduce the SQL `UNIQUE` and `PRIMARY KEY` constraints. Index
creation is idempotent — restarting Console against an existing `consoledb`
with the same index definitions is safe and is a no-op.

Field names shown above are the MongoDB BSON keys (taken from each entity
struct's `bson:"…"` tags). The SQL schema uses different column names — for
example, the `domains` table has columns `name`, `domain_suffix`, and
`tenant_id`, not `profilename`, `domainsuffix`, and `tenantid`. See Console's
[migrations directory][migrations] for the SQL DDL.

!!! note "Cross-tenant uniqueness on `domains`"
    The `(profilename, domainsuffix)` index on `domains` omits `tenantid` by
    design — it mirrors the SQL `lower_name_suffix_idx` constraint. Two
    different tenants cannot register a domain with the same
    `(profilename, domainsuffix)` pair, compared case-insensitively.

[migrations]: https://github.com/device-management-toolkit/console/tree/main/internal/app/migrations
