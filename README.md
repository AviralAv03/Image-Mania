# 🐳 Image Mania

Welcome to **Image Mania**, the ultimate FOSS self-hosting speedrun. 

Forget the GUI. This challenge drops you into a pure, headless Ubuntu terminal. Your mission? Transform a blank server into a fully interconnected, automated homelab architecture using Docker, open-source services, and pure command-line grit.

---

## 🚀 Pre-Flight Setup (Windows Users)

Before the timer starts, you need to configure your local terminal to access the cloud environment. Open PowerShell and run the following sequence:

**1. Install the GitHub CLI:**
```powershell
winget install --id GitHub.cli
```

**2. Authenticate your account:**
```powershell
gh auth login
```

**3. Request Codespace permissions:**
*(This grants your CLI the power to manage remote environments)*
```powershell
gh auth refresh -h github.com -s codespace
```

**4. Build the Server:**
*(Make sure you have forked the event repository first)*
```powershell
gh codespace create -R AnirudhSinghRajora/Image-Mania
```

**5. SSH into the Matrix:**
```powershell
gh codespace ssh
```
*Note: `vim`, `nano`, and terminal compatibility packages are pre-installed. You are ready to build.*

---

## 🏆 The Challenge Phases

You will build your stack progressively. Each phase must be verified by a judge before you move on. Use the terminal text editors to write your `docker-compose.yml` files. 

### Phase 1: The Foundation
* **Nginx Proxy Manager (`jc21/nginx-proxy-manager`):** Spin up the proxy and access its web UI on port 81 to change the default admin credentials.
* **Homepage (`ghcr.io/gethomepage/homepage`):** Deploy a sleek, custom dashboard. As you complete the following phases, you must link all your deployed services to this main hub.

### Phase 2: The Media Empire
* **Jellyfin (`lscr.io/linuxserver/jellyfin`):** Deploy the ultimate FOSS media server. You must properly mount persistent `/config` and `/media` volumes so your library survives container restarts.
    * *Bonus Flex:* Use `wget` to download an open-source film (like *Big Buck Bunny*) directly into your server's media folder via the command line and scan it into Jellyfin.
* **qBittorrent (`lscr.io/linuxserver/qbittorrent`):** Spin up the torrent client. **Crucial:** It must share the exact same `/media` volume you mapped to Jellyfin.

### Phase 3: The Automation
* **Sonarr (`lscr.io/linuxserver/sonarr`):** Deploy the media automation tool.
* **The Catch:** Sonarr needs to talk to qBittorrent. You cannot use `localhost` because they are separate containers. You must put both containers on a custom internal Docker network and link them via their container names (e.g., `http://qbittorrent:8080`).

### Phase 4: Boss Level
* **Paper Minecraft Server (`itzg/minecraft-server`):** For the fastest teams. Spin up a highly optimized FOSS Minecraft server. You will need to inject the correct environment variables (`EULA=TRUE`, `TYPE=PAPER`) and properly map the game port (`25565`).

---

## 📜 Rules of Engagement
1.  **Terminal Only:** No web-based VS Code editors allowed. If you aren't writing YAML in Neovim, Vim, or Nano, you aren't doing it right. 
2.  **Use Compose:** Do not use massive `docker run` commands. Write clean, maintainable `docker-compose.yml` files.
3.  **Get Your Links:** Need to find your active URLs from inside the SSH session so the judges can verify your UI? Open a second local terminal tab and run `gh codespace ports` to see your forwarded web interfaces.
