# Devlights Bootcamp 5.0 | Data & Cloud

## Setup

Requirement: [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.

```bash
cp .env.sample .env     # PowerShell: Copy-Item .env.sample .env
docker compose up -d
```

The default values in `.env` work as-is, but you can change them if you want. If you change the Postgres credentials after the first run, do `docker compose down` and delete `./pgdata`.

| Service    | URL / Port            | Credentials (defaults)                 |
| ---------- | --------------------- | -------------------------------------- |
| PostgreSQL | `localhost:5433`      | `myuser` / `mypassword`, DB `postgres` |
| pgAdmin    | http://localhost:8080 | `admin@example.com` / `adminpassword`  |
| Metabase   | http://localhost:3000 | Created on first login                 |

## Connecting to the database

- **psql:** `docker exec -it my_postgres_bootcamp psql -U myuser -d postgres`
- **pgAdmin:** log in, then right-click Servers > Register > Server. In the Connection tab use host `postgres-db`, port `5432`, plus your user, password and database.
- **External client (DBeaver, VS Code, etc.):** host `localhost`, port `5433`.

> Inside Docker (pgAdmin, Metabase) the host is `postgres-db:5432`, not `localhost:5433`.

## Metabase

Open http://localhost:3000, complete the initial setup and add PostgreSQL as a data source (host `postgres-db`, port `5432`, same user, password and database as in your `.env`).

## Useful commands

```bash
docker compose ps        # status
docker compose logs -f   # logs
docker compose down      # stop and remove containers
```

Data lives in `./pgdata` and survives `down`. Delete that folder to start from scratch.
