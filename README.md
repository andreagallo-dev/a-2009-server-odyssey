# 🏡 Andrea's Homelab

Welcome to my Homelab repository! I built this setup during the summer of 2025 to self-host my services, manage my data securely, and learn more about system administration. 

This project gives a second life to an old but reliable Intel Core2 Quad machine, proving that you don't need the latest enterprise hardware to have a fully functional and robust home server.

![OMV-Dashboard](OMV-Dashboard.PNG)

## 🖥️ Hardware Specifications

*   **CPU:** Intel Core2 Quad CPU Q8300 @ 2.50GHz
*   **RAM:** 6 GB DDR2
*   **OS Drive:** 120GB SanDisk SSD (SDSSDP128G)
*   **Main Storage:** 2x 3TB HDDs (Seagate ST3000DM001 & WD Red WD30EFRX) in **RAID 1 (Mirror)**
*   **Backup Drive:** 1TB HDD (Seagate ST31000524AS)

## ⚙️ Operating System & Architecture

The server runs on **OpenMediaVault (OMV) 7** (Sandworm) based on Debian 12. 
All services are containerized using **Docker** and managed through OMV's Compose plugin and SSH.

## 🗄️ Storage & Backup Strategy

I implemented a robust 3-tier storage strategy directly within OpenMediaVault:
1.  **Main Data Pool (`/dev/md0`):** A 2.73 TiB RAID 1 Mirror holding critical data like Nextcloud files and Immich photos. This ensures zero downtime in case of a single drive failure.
2.  **App Data (`/dev/sdb1`):** Docker configs and Compose files are stored on the SSD for faster I/O.
3.  **Local Backups (`/dev/sdc1`):** A dedicated 1TB drive used solely for backups.
    *   **Automation:** I use OMV's scheduled **Rsync tasks**. Every night at 04:00 AM, Nextcloud data is backed up to the backup drive, followed by Immich photos at 05:00 AM.

## 🐳 Docker Services

Here are the services currently running in my stack. You can find their configurations in the `docker-compose` folder:

*   ☁️ **Nextcloud:** Cloud storage and file synchronization.
*   📸 **Immich:** High-performance self-hosted photo and video backup solution.
*   🍿 **Jellyfin:** Open-source media server for streaming movies and TV shows.
*   🌐 **Nginx Proxy Manager:** Reverse proxy to handle SSL certificates and route traffic to my containers.
*   🛡️ **Pi-hole** Network-wide ad blocking and local DNS resolution.

## 🔒 Security & Networking

*   **VPN / Remote Access:** The server is protected by a firewall. I use a VPN (Tailscale subnet `100.64.0.0/10`) to access the services remotely. 
*   **Firewall Rules:** Incoming connections on specific ports (like port 8080 for the Pi-hole web interface and port 53 for DNS) are strictly accepted *only* from the VPN subnet interface, keeping the server hidden from the public internet.
*   **IPv6:** Disabled locally to prevent routing leaks and simplify local network management.

---
*If you have any questions about how I set up specific parts of this homelab, feel free to open an issue!*
