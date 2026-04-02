# Phase 9: The Private Lane (Internal Networking) 🔒

Until now, we've used independent SQLite databases for our apps. In a production environment, we want a dedicated database server (like PostgreSQL) that is **hidden** from the public internet.

## 🕸️ Internal Networking
By default, Docker Compose puts all services in a file on the same network. However, you can create custom networks to isolate services.

### Objective: Move Gitea to PostgreSQL
We are going to update your Gitea configuration to use a PostgreSQL database.

1. **The Goal**: Gitea must talk to Postgres via an internal network.
2. **The Security**: The Postgres database should **NOT** have any public ports exposed. Only Gitea should be able to "see" it.

### 📝 Updated `docker-compose.yml` for Gitea:
```yaml
version: '3'
networks:
  gitea-backbone:
    driver: bridge

services:
  server:
    image: gitea/gitea:latest
    container_name: gitea
    environment:
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=db:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea
    networks:
      - gitea-backbone
    ports:
      - "3001:3000"
    depends_on:
      - db

  db:
    image: postgres:14
    container_name: gitea-db
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea
      - POSTGRES_DB=gitea
    networks:
      - gitea-backbone
    # Note: NO ports section here! It's private.
```

### 💡 Why does this work?
Within the `gitea-backbone` network, Gitea can find the database simply by using the service name: `db`. Docker handles the internal DNS automatically!

---
**Next Step:** [Phase 10: The Pulse (Final Boss)](./phase10.md)
