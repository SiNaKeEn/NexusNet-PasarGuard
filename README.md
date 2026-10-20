[README.md](https://github.com/user-attachments/files/33738703/README.md)
<div align="center">

# 🛡️ PasarGuard Manager

### x-ui style terminal menu for PasarGuard Panel & Node — with full backup, restore and one-command server migration

**Version 2.2.2**

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Bash-5%2B-green.svg)](#)
[![PasarGuard](https://img.shields.io/badge/PasarGuard-Compatible-orange.svg)](https://github.com/PasarGuard)

One command. Full control.

**English** · [فارسی → README.fa.md](README.fa.md)

</div>

---

## 🚀 Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

Or install this release from the zip:

```bash
chmod +x pg-m
cp pg-m /usr/local/bin/pg-m
pg-m --version   # should print 2.2.2
```

Then run:

```bash
pg-m
```

CLI shortcuts:

```bash
pg-m status                 # containers, URL, resources
pg-m doctor                 # full health check
pg-m db                     # database overview
pg-m backup [full|lite]     # create backup
pg-m restore FILE           # restore / migration package
pg-m update                 # update pg-m itself
pg-m --node-certs           # weekly node-domain cert job
```

---

## 📋 Main Menu (summary)

1. Install / Update / Uninstall  
2. Service Management  
3. Panel Settings  
4. SSL Certificate Management  
5. Backup & Restore (Full / Lite / Telegram)  
6. Migrate to New Server  
7. Node Management  
8. Firewall & Security  
9. Database Management  
10. Tools & Utilities  
11. Quick Status / Doctor  
12. Subscription Relay / Tunnel  
13. Domains & DNS (Cloudflare)  
14. Update pg-m / About  
15. Remove / Uninstall Center  
16. Monitoring & Alerts  
**17. Node-domain Certificates** ← issue, list, delete, weekly renew + push  

---

## 🆕 What's new in 2.2.2

### Menu 17 — Node-domain certificates (improved)

| Option | What it does |
|--------|----------------|
| **1. Issue on THIS server = master** | Local only. **Never** asks for remote IP/password. Saves into `/var/lib/pasarguard/certs/<domain>/`. |
| **2. Issue here + PUSH to master** | Run on the **node**. Asks master IP once (SSH key only; password not stored). |
| **3. List ALL certs on this server** | Scans disk (`/var/lib/pasarguard/certs/`). Works on the master even for certs that were pushed from nodes. |
| **4. Show configured paths + expiry** | Paths for domains registered in the weekly job. |
| **5. Delete a certificate** | Removes panel cert folder; optionally also deletes the Let's Encrypt copy. Updates the job domain list. |
| **6–9** | Run job now / enable / disable / toggle panel restart after change. |

**Prove ownership methods:** Cloudflare DNS · **ArvanCloud DNS** · Standalone (port 80).

Weekly cron: every Monday 04:00 (`pg-m --node-certs`). Copies only when the cert file changed.

Paths to paste into the panel (host / node TLS):

```
/var/lib/pasarguard/certs/<domain>/fullchain.pem
/var/lib/pasarguard/certs/<domain>/key.pem
```

### Earlier fixes (2.2.1)

- Option 1 no longer asks for master credentials.
- Residual push settings are cleared when choosing local mode.
- ArvanCloud DNS support added.

---

## 🔐 SSL (panel menu 4) & node domains (menu 17)

- Let's Encrypt for one or several subdomains; DNS pre-check.
- Certs copied to a path the panel container can read.
- Auto-renew hook can re-copy and restart the panel.
- For **node domains**: prefer Option 1 when the domain already points to this machine (or use Cloudflare/Arvan DNS challenge). Use Option 2 only on the node when files must live on the master.

**Tip without API token:** turn Cloudflare proxy off (DNS only) → issue with Standalone → turn proxy back on.

---

## 💾 Backup, DB, Migration

- Full / Lite archives with checksum; Telegram auto-backup; smart restore.
- Database overview for TimescaleDB / PostgreSQL / MySQL / MariaDB / SQLite.
- One-command migration to a new VPS (package + restore + optional Cloudflare DNS switch).

> Backups contain private keys — keep them private (`chmod 600`).

---

## 🤝 Credits

Built for the [PasarGuard](https://github.com/PasarGuard) community. Inspired by classic `x-ui`. Uses official `pasarguard` and `pg-node` commands.

## 📄 License

MIT — free for personal and commercial use.
