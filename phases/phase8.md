# Phase 8: The Media Center (Jellyfin) 🍿

This is it! The final piece of the architecture. Let's deploy **Jellyfin** to stream your media.

## 🎞️ Jellyfin.org
Jellyfin is the "ultimate" FOSS media server. No ads, no tracking, just your content.

### Objective:
1. Deploy Jellyfin.
2. **Expose the UI on port 8096** (the default).
3. **Shared Volume:** 
   - It **MUST** share the exact same `/media` volume as your qBittorrent container from Phase 7.
4. **Complete the Setup Wizard.**

### 🕺 The Final Rick Roll:
Use the terminal (e.g., `wget` or `curl`) from inside the SSH session to download a Rick Roll `.mp4` video directly into your shared `/media` folder. 

1. `cd` into your media directory.
2. `wget https://cdn-useast1.kapwing.com/static/templates/rick-roll-video-meme-template-video-1da252ec.mp4 -O rickroll.mp4` (or any valid link).
3. Verify it appearing in your Jellyfin library!

---
**Next Step:** [Phase 9: The Private Lane](./phase9.md)
