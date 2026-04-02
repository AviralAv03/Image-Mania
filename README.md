# 🐳 Image Mania

Welcome to **Image Mania**, the ultimate FOSS self-hosting speedrun. 

Forget the GUI. This challenge drops you into a pure, headless Ubuntu terminal (or your favorite code editor). Your mission? Transform a blank server into a fully interconnected, automated homelab architecture using Docker, open-source services, and pure command-line grit.

---

## 🚀 Pre-Flight Setup

Before the timer starts, you need to configure your local environment to access the cloud server.

### 1. Install the GitHub CLI
- **Windows (PowerShell):** `winget install --id GitHub.cli`
- **macOS (Homebrew):** `brew install gh`
  - If brew is not installed, follow the [official guide](https://brew.sh/)
- **Linux:** Follow the [official guide](https://github.com/cli/cli/blob/trunk/docs/install_linux.md) for your distro.

### 2. Authenticate & Prepare
Run these commands in your terminal:
```bash
# Login to GitHub
gh auth login

# Grant Codespace permissions
gh auth refresh -h github.com -s codespace

# Create your Codespace (Make sure you have forked this repo first!)
gh codespace create -R <your-github-username>/Image-Mania

# SSH into the server
gh codespace ssh
```

### 3. IMPORTANT: Port Visibility 🔓
To let the judges evaluate your work, you **MUST** make your ports public. 

> [!IMPORTANT]
> This command **MUST** be run in a **separate terminal tab or window** on your local machine, NOT inside the one you used to SSH into the Codespace.

```bash
gh codespace ports visibility 3000:public 3001:public 8080:public 8081:public 8082:public 8083:public 8084:public 8085:public 8096:public
```

---

## 📚 New to Docker? Read This First!

If you've never used Docker before, it might seem scary. Think of it as **Lego for software**. 

### What are Ports?
Ports are like arrival gates at an airport. A service runs on a specific "gate" so you can find it.
- **How to change them?** In a `docker-compose.yml`, the `ports` section looks like this: `- 8080:80`. 
- The **first number** is the port on your *server*. The **second number** is the port *inside* the container. Change the first one if you have a conflict!

### What are Volumes?
Volumes are like external hard drives. They keep your data safe even if the container is destroyed or updated.

### Google is your Best Friend 🔍
Stopped by an error? Don't know a specific configuration? **Google the documentation!** Most services have excellent "Docker Hub" or "Official Documentation" pages. Searching for *"how to change [service] port docker"* will solve 90% of your problems.

---

## 🏆 The Challenge Phases

You will build your stack progressively across 9 phases. Click each phase to see the specific guidelines and objectives.

- [**Phase 0: The Docker Blueprint**](./phases/phase0.md) (Intro & Dockerfile)
- [**Phase 1: Ports & Visibility**](./phases/phase1.md) (Making it accessible)
- [**Phase 2: Volumes & Filebrowser**](./phases/phase2.md) (Managing files)
- [**Phase 3: Handy Utilities**](./phases/phase3.md) (IT Tools & Stirling-PDF)
- [**Phase 4: The Dashboard**](./phases/phase4.md) (Homepage)
- [**Phase 5: Network Mastery**](./phases/phase5.md) (Pi-hole & Port Conflicts)
- [**Phase 6: Code Hosting**](./phases/phase6.md) (Gitea)
- [**Phase 7: Media Management**](./phases/phase7.md) (qBittorrent)
- [**Phase 8: The Media Center**](./phases/phase8.md) (Jellyfin & Shared Volumes)
- [**Phase 9: The Private Lane**](./phases/phase9.md) (Internal Networking)
- [**Phase 10: The Pulse**](./phases/phase10.md) (Service Discovery & Monitoring)

---

## 📜 Rules of Engagement
1.  **Use Compose:** Do not use massive `docker run` commands. Write clean, maintainable `docker-compose.yml` files.
2.  **Terminal Lovers:** If you want to do everything in the CLI (Neovim, Vim, Nano), check out the [**Terminal Guide**](./terminal.md).
3.  **Active URLs:** To find your links, open a second terminal tab and run `gh codespace ports`.

*`vim`, `nano`, and essential tools are pre-installed. Good luck, Architect.*
