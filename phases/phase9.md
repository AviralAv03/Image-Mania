# Phase 9: The Private Lane (Internal Networking) 🔒

Until now, we've used independent SQLite databases for our apps. In a production environment, we want a dedicated database server (like PostgreSQL) that is **hidden** from the public internet.

## 🏗️ Folder Structure
Organization is key in a homelab. We recommend creating a dedicated folder for each service.

### 🛑 Stopping the Old Gitea Stack
Before we build the new, robust Gitea with a real database, we must stop and remove the simple version from Phase 6.

1. Navigate back to your Phase 6 directory.
2. Run the cleanup command:
   ```bash
   docker compose down
   ```

Now, let's build the new architecture.

## 🕸️ Internal Networking

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
