#!/bin/bash
set -e

echo "Running Phase 5: Pi-hole"
mkdir -p ~/pihole && cd ~/pihole
cat > docker-compose.yml << 'EOF'
services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    environment:
      TZ: 'Asia/Kolkata'
      WEBPASSWORD: 'admin'
    ports:
      - "8080:80"
      - "5353:53/tcp"
      - "5353:53/udp"
    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d
    restart: unless-stopped
EOF
docker compose up -d

echo "Running Phase 6: Gitea"
mkdir -p ~/gitea && cd ~/gitea
cat > docker-compose.yml << 'EOF'
services:
  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    ports:
      - "3001:3000"
    volumes:
      - ./data:/data
    restart: unless-stopped
EOF
docker compose up -d

echo "Running Phase 7: qBittorrent"
mkdir -p ~/qbittorrent/media && cd ~/qbittorrent
cat > docker-compose.yml << 'EOF'
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Kolkata
      - WEBUI_PORT=8081
    ports:
      - 8081:8081
      - 6881:6881
      - 6881:6881/udp
    volumes:
      - ./config:/config
      - ./media:/downloads
    restart: unless-stopped
EOF
docker compose up -d

echo "Running Phase 8: Jellyfin"
mkdir -p ~/jellyfin && cd ~/jellyfin
cat > docker-compose.yml << 'EOF'
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    ports:
      - 8096:8096
    volumes:
      - ./config:/config
      - ./cache:/cache
      - ~/qbittorrent/media:/media
    restart: unless-stopped
EOF
docker compose up -d

echo "Downloading Rickroll..."
wget -q -O ~/qbittorrent/media/rickroll.mp4 https://cdn-useast1.kapwing.com/static/templates/rick-roll-video-meme-template-video-1da252ec.mp4

echo "Running Phase 9: Private Lane (Gitea Postgres)"
cd ~/gitea
docker compose down || true
cat > docker-compose.yml << 'EOF'
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
    volumes:
      - ./data:/data

  db:
    image: postgres:14
    container_name: gitea-db
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea
      - POSTGRES_DB=gitea
    networks:
      - gitea-backbone
    volumes:
      - ./db-data:/var/lib/postgresql/data
EOF
docker compose up -d

echo "Running Phase 10: The Pulse"
docker network create homelab-net || true
docker network connect homelab-net gitea || true
docker network connect homelab-net jellyfin || true
docker network connect homelab-net pihole || true

mkdir -p ~/uptime-kuma && cd ~/uptime-kuma
cat > docker-compose.yml << 'EOF'
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
EOF
docker compose up -d

echo "All phases completed!"
