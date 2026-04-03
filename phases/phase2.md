# Phase 2: Volumes & Filebrowser 📁

Running a container is cool, but what happens when you restart it? Data vanishes like 🪄 magic unless you use **Volumes**.

## 💾 What are Volumes?
Volumes are like an external hard drive for your container. It lets you store persistent data (configs, media, databases) on your server's disk so the container can access it.

Imagine your server's folder `/home/data` is "linked" to the container's folder `/data`. Anything the container writes there stays on your server forever.

## 📁 Filebrowser.org
Let's deploy a web-based file manager to help you manage your server's files without always using the terminal.

### Objective:
1. Create a folder: `mkdir filebrowser`
2. Create a `docker-compose.yml` file:
```yaml
services:
  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    ports:
      - 8084:80
    volumes:
      - ./data:/srv
    restart: unless-stopped
```

**Expose the UI on port 8084.** 

### 💡 Pro Tip:
If you are unsure about a service's configuration, don't hesitate to **Google the documentation** for "filebrowser docker compose".

---
**Next Step:** [Phase 3: Handy Utilities](./phase3.md)
