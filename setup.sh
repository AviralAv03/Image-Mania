#!/bin/bash
set -e

# ==============================================================================
# 🚀 THE ULTIMATE IMAGE-MANIA SPEEDRUN MEGA-SCRIPT
# ==============================================================================
# HOW TO USE THIS (FOR YOUR FRIEND):
# 
# 1. Open PowerShell on your Windows PC and run these commands first:
#
#    winget install --id GitHub.cli
#    gh auth login
#    gh auth refresh -h github.com -s codespace
#    
#    # Create codespace (replace GITHUB_USERNAME with their actual username)
#    gh codespace create -R <GITHUB_USERNAME>/Image-Mania
#    
#    # SSH into the server
#    gh codespace ssh
#
# 2. Once inside the Linux server, run these two commands to grab and use this script:
#    wget https://raw.githubusercontent.com/AviralAv03/Image-Mania/main/setup.sh
#    bash setup.sh
# ==============================================================================

echo "Starting Image-Mania Full Speedrun (Phases 0-10)..."

echo "=== Running Phase 0: The Docker Blueprint ==="
mkdir -p ~/hello-docker && cd ~/hello-docker
cat > Dockerfile << 'EOF'
FROM nginx:alpine
RUN echo "<h1>Hello from Phase 0! Docker is running.</h1>" > /usr/share/nginx/html/index.html
EXPOSE 80
EOF
docker build -t my-first-container .
docker run -d -p 8085:80 --name hello-phase0 my-first-container

sleep 2 # Let it breathe

echo "=== Running Phase 1: Docker Compose ==="
docker stop hello-phase0 && docker rm hello-phase0
mkdir -p ~/my-compose-app && cd ~/my-compose-app
cat > docker-compose.yml << 'EOF'
services:
  web-server:
    image: nginx:alpine
    container_name: my-first-compose
    ports:
      - 8085:80
EOF
docker compose up -d

echo "=== Running Phase 2: Filebrowser ==="
mkdir -p ~/filebrowser && cd ~/filebrowser
cat > docker-compose.yml << 'EOF'
services:
  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    ports:
      - 8084:80
    volumes:
      - ./data:/srv
    restart: unless-stopped
EOF
docker compose up -d

echo "=== Running Phase 3: Handy Utilities ==="
mkdir -p ~/it-tools && cd ~/it-tools
cat > docker-compose.yml << 'EOF'
services:
  it-tools:
    image: corentinth/it-tools:latest
    container_name: it-tools
    ports:
      - 8082:80
    restart: unless-stopped
EOF
docker compose up -d

mkdir -p ~/stirling-pdf && cd ~/stirling-pdf
cat > docker-compose.yml << 'EOF'
services:
  stirling-pdf:
    image: frooodle/s-pdf:latest
    container_name: stirling-pdf
    ports:
      - 8083:8080
    restart: unless-stopped
EOF
docker compose up -d

echo "=== Running Phase 4: Homepage ==="
mkdir -p ~/homepage/config && cd ~/homepage
cat > docker-compose.yml << 'EOF'
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    ports:
      - 3000:3000
    volumes:
      - ./config:/app/config
    restart: unless-stopped
EOF
docker compose up -d

cat > ~/homepage/config/services.yaml << 'EOF'
- My Homelab:
    - Filebrowser:
        href: "{{HOMEPAGE_VAR_BASE_URL}}:8084"
        description: Web File Manager
        icon: filebrowser.png
    - IT Tools:
        href: "{{HOMEPAGE_VAR_BASE_URL}}:8082"
        description: Developer Utilities
        icon: it-tools.png
    - Stirling PDF:
        href: "{{HOMEPAGE_VAR_BASE_URL}}:8083"
        description: PDF Tools
        icon: stirling-pdf.png
EOF

echo "=== Running Phase 5: Pi-hole ==="
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

echo "=== Running Phase 6: Code Hosting (Gitea Temporary) ==="
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

echo "=== Running Phase 7: Media Management (qBittorrent) ==="
mkdir -p ~/qbittorrent && cd ~/qbittorrent
mkdir -p ./media
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

echo "=== Running Phase 8: The Media Center (Jellyfin) ==="
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

echo "=== Running Phase 9: Private Lane (Gitea Postgres) ==="
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

echo "=== Running Phase 10: The Pulse ==="
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

echo "====================================================="
echo "🎉 ALL INFRASTRUCTURE PHASES COMPLETED AND DEPLOYED!"
echo "====================================================="
echo "Check your ports using: gh codespace ports"
