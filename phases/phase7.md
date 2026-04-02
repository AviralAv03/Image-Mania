# Phase 7: Media Management (qBittorrent) 🌊

Let's start building your media pipeline with **qBittorrent**.

## ⬇️ linuxserver/qbittorrent
We recommend using the **linuxserver.io** images for consistency and best practices.

### Objective:
1. Deploy qBittorrent.
2. **Expose the Web UI on port 8081.**
3. **Task:** 
   - Access the web UI.
   - Navigate to **Settings > Web UI**.
   - Change the admin password to exactly: **`torrentingIsGood`**.
   
### 💾 Important:
Ensure you map a **persistent volume** to `/media` (or `/downloads`). This will be crucial for the final phase!

---
**Next Step:** [Phase 8: The Media Center](./phase8.md)
