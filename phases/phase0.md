# Phase 0: The Docker Blueprint 🐳

Welcome to the start of your self-hosting journey! Before we dive into complex services, we need to understand the building blocks: **Containers and Dockerfiles**.

## 🏗️ Folder Structure
Organization is key in a homelab. We recommend creating a dedicated folder for each service.
For this phase, let's create a basic "Hello World" service.

1. Create a directory: `mkdir hello-docker`
2. Enter the directory: `cd hello-docker`

## 📝 The Dockerfile
A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image.

Create a file named `Dockerfile` (no extension) inside `hello-docker/` and paste this:

```dockerfile
# Use a lightweight web server as the base image
FROM nginx:alpine

# Create a simple HTML file to serve
RUN echo "<h1>Hello from Phase 0! Docker is running.</h1>" > /usr/share/nginx/html/index.html

# Expose port 80 (default for Nginx)
EXPOSE 80
```

## 🚀 Building and Running
To turn this `Dockerfile` into a running container:

1. **Build the image:**
   ```bash
   docker build -t my-first-container .
   ```
2. **Run the container:**
   ```bash
   docker run -d -p 8085:80 --name hello-phase0 my-first-container
   ```

---

## 🔓 Ports & Visibility
Now that your first container is running, how do you actually see it in your browser?

### 🔌 What are Ports?
Think of your server's IP address like a building's address. **Ports** are like individual apartment numbers. Different services live in different "apartments".

### Making Ports Public
By default, GitHub Codespaces keeps your ports private. To let the judges (or the world) see your progress, you MUST make them public.

#### ⚠️ IMPORTANT: The Second Terminal Rule
Do **NOT** run these status/port commands inside the same terminal where you are `ssh-ed` into the server. 
1. Open a **new local terminal tab or window** (PowerShell, Terminal, or iTerm).
2. Run the following command if you haven't already to make your ports accessible:

```bash
# This command makes multiple ports public at once
gh codespace ports visibility 3000:public 3001:public 3002:public 8080:public 8081:public 8082:public 8083:public 8084:public 8085:public 8096:public
```

## 🔍 How to find your URL?
In that same **second local terminal**, run:
```bash
gh codespace ports
```
Click the link shown for port **8085** to see your "Hello World"!

---
**Next Step:** [Phase 1: Docker Compose](./phase1.md)
