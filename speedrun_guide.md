# 🚀 Image Mania FOSS Speedrun - Complete Guide

This guide contains every single command and step needed to complete all 10 phases of the Image Mania FOSS self-hosting challenge from absolute scratch.

## 🏁 Pre-requisites (Windows PowerShell)

Open Windows PowerShell and run these commands to set up the GitHub CLI, authenticate, and enter the Linux Codespace:

```powershell
# Install GitHub CLI (if not already installed)
winget install --id GitHub.cli

# Login to GitHub (follow browser prompts)
gh auth login

# Allow Codespace permissions
gh auth refresh -h github.com -s codespace

# Create a new codespace from your repository (Replace username!)
gh codespace create -R <YOUR_GITHUB_USERNAME>/Image-Mania

# SSH into the server
gh codespace ssh
```

---

## 🛠️ The Ultimate Setup Script (Phases 0 - 10)

Once you are inside the Linux Codespace terminal (`@codespaces... $`), run these exact two commands. 
This downloads and runs the comprehensive completion script which automates all Docker builds, network configurations, and container deployments:

```bash
wget https://raw.githubusercontent.com/AviralAv03/Image-Mania/main/setup.sh
bash setup.sh
```

> [!TIP]
> **Wait for the script to finish.** It takes about 1-2 minutes. When it prints `🎉 ALL INFRASTRUCTURE PHASES COMPLETED AND DEPLOYED!`, proceed to the final steps below!

---

## 🌐 The Browser Finish Line (Manual configurations)

After the script completes, you only have four quick browser clicks left to secure your victory. Run `gh codespace ports` in your terminal to get your specific clickable URLs.

### 1. Gitea (Port 3001)
* Open the Gitea URL.
* Scroll to the very bottom and click **Install Gitea** (don't touch the pre-filled database settings).
* Once it loads, register a new account with the exact username: **`mello`**.
* *Note: You can use a fake email like `mello@mello.com` and any password you want.*
* Log in and create a new repository called **`hello-world`**.

### 2. qBittorrent (Port 8081)
* To log in, check your terminal for the temporary password by running: `docker logs qbittorrent 2>&1 | grep -i password | tail -n 1`
* Open the qBittorrent URL and log in with username **`admin`** and that temporary password.
* Click the **Gear Icon** (Options/Settings) and go to the **Web UI** tab.
* Change the password to exactly: **`torrentingIsGood`**
* Scroll down on the popup and click **Save**.

### 3. Jellyfin (Port 8096)
* Open the Jellyfin URL and rush through the Quick Setup Wizard. 
* When asked to "Add Media Library", set Content Type to "Movies", name it anything you want, but ensure the folder path is strictly: **`/media`**
* Finish the wizard. Go to the Home dashboard, open your library, and you should see the `rickroll.mp4` video downloaded by the setup script! 🕺

### 4. Uptime Kuma - THE FINAL BOSS (Port 3002)
* Open the Uptime Kuma URL and create an admin account.
* Click **"Add New Monitor"** at the top left. You must add three specific monitors to complete the challenge:
  1. **Monitor Type:** `HTTP(s)`, **Name:** `Gitea`, **URL:** `http://gitea:3000` 
  2. **Monitor Type:** `HTTP(s)`, **Name:** `Jellyfin`, **URL:** `http://jellyfin:8096` 
  3. **Monitor Type:** `HTTP(s)`, **Name:** `Pi-hole`, **URL:** `http://pihole:80/admin/` 
* Save all three. Wait 60 seconds for the dashboard to ping the internal Docker networks. 
* When all three bars hit **100% GREEN**, you have won! 🏆

> [!IMPORTANT]  
> Submit your public **Uptime Kuma Dashboard URL** to the hackathon judges!
