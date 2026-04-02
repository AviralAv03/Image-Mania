# Phase 10: The Pulse (Shared Networks & Monitoring) 💓

Congratulations! You've reached the final phase. To complete your homelab, you need a way to monitor all your services and ensure they are healthy.

## 🕵️ Service Discovery
In Phase 9, Gitea and Postgres shared a private network. But what if we want a **Monitoring Tool** to talk to *every* service in our homelab by their name?

### Objective: The Homelab Network
1. Create a global bridge network: `docker network create homelab-net`
2. **Task**: Add this network to Gitea, Jellyfin, and Pi-hole by adding an `external` network block to their Compose files.

### 📊 Uptime Kuma
Deploy the legendary **Uptime Kuma** to monitor your stack.

1. **Port**: Expose the UI on port **3002**.
2. **Network**: Put it on the `homelab-net` network.

```yaml
version: '3'
services:
  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    ports:
      - 3002:3001
    networks:
      - homelab-net
    volumes:
      - ./data:/app/data

networks:
  homelab-net:
    external: true
```

### 🏆 The Final Challenge:
In the Uptime Kuma dashboard:
1. Add a "Monitor" for **Gitea**.
2. **The Multiplier**: Instead of using an IP or `localhost`, use its **internal name**: `http://gitea:3000`.
3. Do the same for **Jellyfin** (`http://jellyfin:8096`) and your other services.

**If theStatus Page turns GREEN, you have mastered Docker Networking!** 🟢

---
**You have finished the Image-Mania Speedrun!** 🏆 
