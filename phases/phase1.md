# Phase 1: Docker Compose 🌐

In Phase 0, we ran a container using `docker run`. While that works, it gets messy when you have many services. Professionals use **Docker Compose**.

## 🏗️ What is Docker Compose?
Docker Compose is a tool for defining and running multi-container Docker applications. You use a **YAML file** to configure your application’s services.

### The `docker-compose.yml` File
Instead of a long, complex command, you write a simple configuration file. Let's create a Compose file for a basic web server.

1. Create a new directory: `my-compose-app`
2. Create a file named `docker-compose.yml` and paste this:

```yaml
version: '3'
services:
  web-server:
    image: nginx:alpine
    container_name: my-first-compose
    ports:
      - 8085:80
```

### 🚀 Running with Compose
To start your service, simply run:
```bash
docker compose up -d
```
- `up`: Starts the services defined in the file.
- `-d`: Runs the containers in the "detached" mode (background).

---
**Next Step:** [Phase 2: Volumes & Filebrowser](./phase2.md)
