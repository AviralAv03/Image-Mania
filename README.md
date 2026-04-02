# 🐳 Image Mania

Welcome to **Image Mania**, the ultimate FOSS self-hosting speedrun. 

Forget the GUI. This challenge drops you into a pure, headless Ubuntu terminal. Your mission? Transform a blank server into a fully interconnected, automated homelab architecture using Docker, open-source services, and pure command-line grit.

---

## 🚀 Pre-Flight Setup (Windows Users)

Before the timer starts, you need to configure your local terminal to access the cloud environment. Open PowerShell and run the following sequence:

**1. Install the GitHub CLI:**
~~~powershell
winget install --id GitHub.cli
~~~

**2. Authenticate your account:**
~~~powershell
gh auth login
~~~

**3. Request Codespace permissions:**
*(This grants your CLI the power to manage remote environments)*
~~~powershell
gh auth refresh -h github.com -s codespace
~~~

**4. Build the Server:**
*(Make sure you have forked the event repository first)*
~~~powershell
gh codespace create -R AnirudhSinghRajora/Image-Mania
~~~

**5. SSH into the Matrix:**
~~~powershell
gh codespace ssh
~~~

**6. Make ports public:**
*(This makes the ports public so that we can evaluate your submission)*
~~~powershell
gh codespace ports visibility 3000:public 3001:public 8080:public 8081:public 8082:public 8083:public 8084:public 8096:public
~~~

*Note: `vim`, `nano`, and terminal compatibility packages are pre-installed. You are ready to build.*

---

## 🏆 The Challenge Phases

You will build your stack progressively. Each phase must be verified by a judge before you move on. Use the terminal text editors to write your `docker-compose.yml` files. 

### Phase 0: The Utility Belt
* **Filebrowser :** Deploy a web-based file manager to easily handle your server's data.
  * **Objective:** Map a persistent volume so you can visually browse the files on your server. Log in using the default `admin` / `admin` credentials and successfully change the password. Expose the UI on port **8084**.
* **IT-Tools :** Spin up the ultimate collection of handy developer utilities.
  * **Objective:** Deploy the container successfully and expose the web UI on port **8082**.
* **Stirling-PDF :** Deploy a powerful, locally hosted PDF manipulation tool.
  * **Objective:** Spin it up and configure i. Expose the UI on port **8083**.

### Phase 1: The Gateway & Dashboard
* **Pi-hole :** Spin up the infamous network-wide ad blocker. 
  * **Objective:** You will encounter port conflicts (specifically on ports 80 and 53). Resolve them and successfully expose the Web UI on port **8080**. Use the default empty/random password generation as noted in their GitHub docs to log in.
* **Homepage :** Deploy a sleek, custom dashboard. 
  * **Objective:** As you complete the following phases, you must add functional links to all your deployed services on this main hub. Expose the ui on port **3000**.

### Phase 2: The Codebase
* **Gitea :** Deploy a painless self-hosted Git service.
  * **Objective:** Complete the initial setup. Create a new user named exactly **`mello`**. Under that user, create a repository named **`hello-world`** and push a `README.md` file to it containing the text "Hello World!". Expose the UI on port **3001**.

### Phase 3: The Media Pipeline
* **qBittorrent :** Spin up the torrent client. 
  * **Objective:** Access the web UI, navigate to the settings, and change the admin password to exactly: **`torrentingIsGood`**. Ensure you map a persistent `/media` volume. Expose web UI on port **8081**.
* **Jellyfin :** Deploy the ultimate FOSS media server. 
  * **Objective:** It must share the exact same `/media` volume as qBittorrent. Complete the setup wizard. Finally, use the terminal (e.g., `wget` or `curl`) to download a Rick Roll `.mp4` video directly into your shared media folder so it appears in your Jellyfin library! Expose UI on the port **8096**(the default).

---

## 📜 Rules of Engagement
1.  **Terminal Only:** No web-based VS Code editors allowed. If you aren't writing YAML in Neovim, Vim, or Nano, you aren't doing it right. 
2.  **Use Compose:** Do not use massive `docker run` commands. Write clean, maintainable `docker-compose.yml` files.
3.  **Get Your Links:** Need to find your active URLs from inside the SSH session so the judges can verify your UI? Open a second local terminal tab and run `gh codespace ports` to see your forwarded web interfaces.
