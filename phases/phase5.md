# Phase 5: Network Mastery (Pi-hole) 🛡️

Ready for a real challenge? Let's deploy the legendary network-wide ad blocker: **Pi-hole**.

## 🛑 The Port 80 & 53 Conflict
By default, Pi-hole wants to use port **80** (Web) and port **53** (DNS). 
- Port **80** might be used by another service in your stack.
- Port **53** is often used by your server's system resolver.

### Objective:
- Deploy Pi-hole successfully.
- **Resolve any port conflicts.**
- **Expose the Web UI on port 8080.**

### 🔑 Hint:
To change the default port of a service, look for the `ports` section in your `docker-compose.yml`. 
If a service expects `- 80:80`, you can change it to `- 8080:80`. The first number is your server's port, and the second is the container's.

Use the default password generation mentioned in the [Pi-hole Docker documentation](https://github.com/pi-hole/docker-pi-hole) to log in.

---
**Next Step:** [Phase 6: Code Hosting](./phase6.md)
