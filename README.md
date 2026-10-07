<div align="center">

# 🛡️ PasarGuard Manager

### x-ui style terminal management menu for PasarGuard Panel & Node

**Version 1.9.0**

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Bash-5%2B-green.svg)](#)
[![PasarGuard](https://img.shields.io/badge/PasarGuard-Compatible-orange.svg)](https://github.com/PasarGuard)

One command. Full control.

</div>

---

## 🚀 Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

After installation just type:

```bash
pg-m
```

---

## 📋 Menu Overview

```
┌──────────────────────────────────────────────────────────────┐
│                 PasarGuard Manager  v1.9.0                   │
│          https://panel.example.com/dashboard/                │
├──────────────────────────────────────────────────────────────┤
│  0. Exit                                                     │
│──────────────────────────────────────────────────────────────│
│  1. Install / Update / Uninstall                             │
│  2. Service Management          (Start / Stop / Restart...)  │
│  3. Panel Settings              (Port / Path / Admin...)     │
│  4. SSL Certificate Management                               │
│  5. Backup & Restore                                         │
│  6. Migrate to New Server                                    │
│──────────────────────────────────────────────────────────────│
│  7. Node Management                                          │
│  8. Firewall & Security                                      │
│  9. Database Management                                      │
│──────────────────────────────────────────────────────────────│
│ 10. Tools & Utilities                                        │
│ 11. Quick Status                                             │
└──────────────────────────────────────────────────────────────┘
```

Panel URL is shown at the top of the menu when installed.

---

## ✨ Features

| Category | Features |
|----------|----------|
| **Service** | Start • Stop • Restart • Status • Live Logs |
| **Install** | TimescaleDB • PostgreSQL • SQLite • MySQL • MariaDB |
| **Port** | Change port • Open firewall • Show access links |
| **SSL** | Let's Encrypt (one domain) • Self-Signed • List & Expiry • Renew • Delete/Revoke • Apply to Panel • Full cert content view |
| **Backup** | Manual backup • Telegram auto-backup • Restore • PostgreSQL dump |
| **Migrate** | **Full automatic transfer to new VPS** (package + SCP + remote install + restore) |
| **Settings** | Temp owner key • Edit `.env` / compose • DB password reset |
| **Node** | Install node • Show API Key • Show certificates • Multi-name support |
| **Security** | UFW • BBR • Fail2Ban • IP Limit (lock panel to your IP) |
| **Tools** | Speedtest • Disk/Mem/Ports • Docker cleanup • Geo files • Who uses port 80 |

---

## 🔐 SSL Certificate (Easy Mode)

Exactly like 3X-UI experience:

1. Choose **Issue Let's Encrypt**
2. Enter your domain
3. Script automatically:
   - Frees port 80
   - Issues certificate with Certbot
   - Copies certs to panel-readable path
   - Updates `.env`
   - Restarts panel on port 443

**View Existing Certificates** shows:
- Domain name
- Expiry status (Active / Expires soon / Expired)
- Full path
- Full certificate text + private key (on demand)

---

## 🚚 Migrate to New Server (Full Auto)

This is the upgraded migration system:

### What it does automatically:

1. Creates a complete migration package on the old server  
   (backup + `.env` + certificates + letsencrypt)
2. Connects to the new VPS via SSH
3. Uploads the package
4. Installs `pg-m` on the new server
5. Installs PasarGuard panel (if not present)
6. Restores the backup
7. Applies certificates and environment
8. Restarts services

You only need to provide:
- New server IP
- SSH port (default 22)
- Root password or SSH key

---

## 📦 Manual Install

```bash
curl -fsSL -o /usr/local/bin/pg-m \
  https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/pg-m
chmod +x /usr/local/bin/pg-m
pg-m
```

---

## 🗑️ Uninstall Manager Only

```bash
rm -f /usr/local/bin/pg-m
```

This does **not** remove your PasarGuard panel or data.

---

## 📌 Requirements

- Debian / Ubuntu (recommended)
- Root access
- Docker (installed automatically by official PasarGuard scripts if missing)

---

## 🤝 Credits

- Built for the [PasarGuard](https://github.com/PasarGuard) community
- Inspired by the classic `x-ui` management experience
- Uses official `pasarguard` and `pg-node` commands under the hood

---

## 📄 License

MIT License — free for personal and commercial use.
