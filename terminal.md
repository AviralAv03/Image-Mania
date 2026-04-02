# ⌨️ The Pure Terminal Guide

For those who believe the GUI is for the weak. This guide contains the "Pro Tips" and "Cheat Sheets" for completing Image-Mania entirely within the headless Ubuntu terminal.

## 🛠️ Essential CLI Tools
- **`vim` / `nano`**: Your primary editors. If you want a more "modern" feel, we recommend learning the basics of `vim`.
- **`tmux`**: Essential for running multiple terminals in one SSH session. (Run `tmux` to start, `Ctrl+B then %` to split vertically).
- **`jq`**: For parsing JSON output in the terminal.
- **`curl` / `wget`**: For downloading files or testing web endpoints.

## 🐳 Docker CLI Cheat Sheet

| Command | Description |
| --- | --- |
| `docker compose up -d` | Start services in background |
| `docker compose down` | Stop and remove services |
| `docker compose logs -f [service]` | View live logs |
| `docker ps` | List running containers |
| `docker stats` | View CPU/RAM usage |
| `docker exec -it [name] bash` | Open a shell inside a container |

## 🔗 Port Management (The CLI way)
To see your active port forwards from within your **local terminal** (NOT the SSH one):
```bash
gh codespace ports
```

## 🚀 Advanced: Moving Files
Instead of using Filebrowser, you can use `scp` or `rsync` if you have local files:
```bash
# Upload a file to your server (run from LOCAL terminal)
gh codespace cp local-file.txt remote:/home/codespace/
```

---
Need more help? **Google is your best friend.** Search for "Docker Compose Tutorial" or "Linux Command Line Cheat Sheet".
