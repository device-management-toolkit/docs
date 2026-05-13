# Quick Start with Docker Compose

!!! note "Before you start"
    This walkthrough uses the `docker-compose.yml` bundled with Console and the
    `mongo` provider. See the [Overview](overview.md) for how `DB_PROVIDER` and
    `DB_URL` select the backend.

## 1. Start the stack

The bundled `docker-compose.yml` includes a profile-gated `mongo` service.
Bring it up with the MongoDB environment variables set:

```bash
DB_PROVIDER=mongo \
DB_URL="mongodb://mongoadmin:admin123@mongo:27017/?authSource=admin" \
docker compose --profile mongo up -d
```

| Setting | Effect |
|---|---|
| `--profile mongo` | Activates the `mongo` service (it stays idle otherwise). |
| `DB_PROVIDER=mongo` | Selects the MongoDB repository implementation. |
| `DB_URL` | Connection string; `mongo` is the Compose service hostname. |

## 2. Check the startup log

The `app` service listens on port `8181`. On startup it logs that it reached
MongoDB and ensured the unique indexes, for example:

```text
mongo connected: db=consoledb
mongo unique indexes ensured (9 total)
```

## 3. Inspect the live database

!!! tip "Prefer the UI?"
    Console also ships with a web UI. The bundled Compose stack sets
    `AUTH_DISABLED=true` on the `app` service, so browsing to
    [http://localhost:8181](http://localhost:8181) opens the **Devices** view
    directly — no login prompt. If the list renders without an error banner,
    the MongoDB round-trip is working end to end. Continue with the `mongosh`
    steps below to inspect the database directly.

The `mongo` service from step 1 ships with the official MongoDB shell
([`mongosh`](https://www.mongodb.com/docs/mongodb-shell/)). The quickest way
to confirm Console created `consoledb` and its indexes from the command line
is to open an interactive `mongosh` session inside that container:

```bash
docker compose exec mongo mongosh \
  -u mongoadmin -p admin123 --authenticationDatabase admin consoledb
```

| Part of the command | Effect |
|---|---|
| `docker compose exec mongo` | Runs the next command inside the running `mongo` service container. |
| `mongosh` | The MongoDB shell, already installed in the official `mongo` image. |
| `-u mongoadmin -p admin123 --authenticationDatabase admin` | Logs in with the dev credentials baked into the bundled service. |
| `consoledb` | Selects the database Console uses — the prompt switches to `consoledb>`. |

Once you see the `consoledb>` prompt, run:

```js
show collections
db.devices.countDocuments()
db.devices.getIndexes()
```

- `show collections` lists the collections Console manages — see
  [Collections and Indexes](collections.md) for the full set.
- `db.devices.countDocuments()` returns `0` on a fresh deployment.
- `db.devices.getIndexes()` should include the unique compound index on
  `(guid, tenantid)`, evidence that `ensureIndexes` ran successfully against
  the live database.

Type `exit` (or press **Ctrl+D**) to leave the shell.

## Production notes

The bundled stack is for local development only. Console connects to whatever
MongoDB `DB_URL` points at — it does not provision, secure, or back up the
database itself. For production, run a hardened MongoDB deployment following
the [MongoDB security checklist][mongo-sec], then point `DB_URL` at it, for
example:

```text
mongodb://user:pass@host:27017/?authSource=admin&tls=true&replicaSet=rs0
```

[mongo-sec]: https://www.mongodb.com/docs/manual/administration/security-checklist/
