[Uploading README.md…]()
# PasarGuard Manager (`pg-m`)

**x-ui style management menu for [PasarGuard](https://github.com/PasarGuard) Panel & Node**

Version **1.4.1** — English-only terminal UI, built on official `pasarguard` / `pg-node` commands.

---

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

Then run:

```bash
pg-m
```

### Manual install

```bash
curl -fsSL -o /usr/local/bin/pg-m \
  https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/pg-m
chmod +x /usr/local/bin/pg-m
pg-m
```

---

## Menu

```
0.  Service Management
1.  Install / Update / Uninstall
2.  Port & Access Links
3.  SSL Certificate
4.  Backup & Restore
5.  Migrate to New Server
6.  Panel Settings
7.  Node Management
8.  Firewall & IP Limit
9.  Tools
10. Quick Status
11. Exit
```

Panel URL is shown at the top of the main menu when the panel is installed.

---

## Features

| Area | What you get |
|------|----------------|
| **Service** | Start / Stop / Restart / Status / Logs |
| **Install** | TimescaleDB, PostgreSQL, SQLite, MySQL, MariaDB |
| **Port** | Change `UVICORN_PORT`, open firewall, show access link |
| **SSL** | List status & expiry, issue, renew, **delete/revoke**, apply to panel, self-signed |
| **Backup** | Official backup/restore, Telegram auto-backup, PG dump |
| **Migrate** | Package backups + `.env` + certs for a new VPS |
| **Settings** | Temp owner key, edit `.env` / compose, DB password reset |
| **Node** | Install node, show API key & certificate |
| **Firewall** | UFW, BBR, Fail2Ban, **IP limit** for panel port |
| **Tools** | Speedtest, disk/mem/ports, Docker, Geo files, who uses :80 |

---

## SSL notes

- Certificates are **copied** to `/var/lib/pasarguard/certs/<domain>/` because the panel container cannot read `/etc/letsencrypt`.
- Issue / Renew / Apply all use this path and set `UVICORN_PORT=443`.

- **Issue** frees port 80 (stops panel / nginx / apache / caddy, `fuser -k 80/tcp`) before `certbot --standalone`.
- **List** shows `Active` / `Expires <30d` / `EXPIRED`.
- **Renew** runs `certbot renew`.
- **Delete** revokes/deletes the cert (like x-ui remove cert).
- **Apply** writes paths into `/opt/pasarguard/.env` and sets port `443`.

If issue fails with *port 80 in use*, use **Tools → Who uses port 80**, then retry SSL issue.

---

## IP Limit

Under **8. Firewall & IP Limit**:

- Lock panel port to your current SSH IP only  
- Add extra allowed IPs  
- Reset / open panel port to the world again  

SSH (22) should stay allowed so you do not lock yourself out.

---

## Uninstall manager only

```bash
rm -f /usr/local/bin/pg-m
```

Does not remove PasarGuard panel.

---

## Requirements

- Debian / Ubuntu  
- Root  
- Optional: panel already installed (or install from menu)

---

## License

MIT — for the PasarGuard community.
