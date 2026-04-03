# Phase 1: Docker Compose 🌐

In Phase 0, we ran a container using `docker run`. While that works, it gets messy when you have many services. Professionals use **Docker Compose**.

## 🏗️ What is Docker Compose?
Docker Compose is a tool for defining and running multi-container Docker applications. You use a **YAML file** to configure your application’s services.

### 🧩 What is a Service?
In the world of Docker, a **Service** is just a fancy name for a container in production. A service only runs one image, but it codifies how that image should run: which ports it should use, how much memory it can take, and more.

### 🔗 Interconnection
The real power of Compose is that it allows you to **interconnect multiple services** so they work together as one cohesive unit. For example, your web server (Service A) can talk to your database (Service B) using only its name!

### The `docker-compose.yml` File
Instead of a long, complex command, you write a simple configuration file. Let's create a Compose file for a basic web server.

1. Create a new directory: `my-compose-app`
2. Create a file named `docker-compose.yml` and paste this:

```yaml
services:
  web-server:
    image: nginx:alpine
    container_name: my-first-compose
    ports:
      - 8085:80
```

### 🚀 Running with Compose
Before we start our new server, we need to stop the one from Phase 0 to avoid a port conflict:
```bash
docker stop hello-phase0 && docker rm hello-phase0
```

Now, start your new Compose service:
```bash
docker compose up -d
```
- `up`: Starts the services defined in the file.
- `-d`: Runs the containers in the "detached" mode (background).

> [!NOTE]
> **Check your browser!** Click the link for port **8085** in your codespace. 
> Unlike Phase 0, we didn't modify the `index.html` this time. You should see the default **"Welcome to nginx!"** page. This is because we are using the official image directly!

---
**Next Step:** [Phase 2: Volumes & Filebrowser](./phase2.md)
