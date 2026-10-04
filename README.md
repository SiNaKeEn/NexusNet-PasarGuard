# PasarGuard Manager (`pg-m`)

**A powerful, clean and fully English terminal menu for PasarGuard Panel & Node.**

Inspired by 3x-ui / Sanaei style menus — built to make managing PasarGuard easy and professional.

**Version 1.1.0**

---

## Features

| Category | Options |
|----------|---------|
| **Service** | Start / Stop / Restart / Status / Logs |
| **Install** | TimescaleDB, PostgreSQL, SQLite, MySQL, MariaDB |
| **Update / Uninstall** | One-click update & clean uninstall |
| **SSL & Domain** | Let's Encrypt + Self-Signed + view/edit SSL |
| **Backup & Restore** | Official backup, Telegram auto-backup, restore, manual DB dump |
| **Migrate** | Full migration package for new server |
| **Panel Settings** | Temp-key, Change Port, edit .env/compose, DB password reset |
| **Node Management** | Install node, Show API Key, Show Certificate, edit node .env |
| **Firewall** | UFW rules + BBR + Fail2Ban |
| **Tools** | Speedtest, disk, memory, ports, Docker clean, Geo files, system info |

---

## Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

After installation:

```bash
pg-m
```

---

## Menu Preview

```
╔══════════════════════════════════════════════════════════╗
║           PasarGuard Manager  v1.1.0                     ║
╚══════════════════════════════════════════════════════════╝

  1)  Service Management
  2)  Install / Update / Uninstall
  3)  SSL & Domain Management
  4)  Backup & Restore
  5)  Migrate to New Server
  6)  Panel Settings
  7)  Node Management
  8)  Firewall & Security
  9)  Tools
  10) Quick Status
  0)  Exit
```

---

## Requirements

- Ubuntu / Debian (recommended)
- Root access
- PasarGuard already installed **or** install it from the menu

---

## Notes

- All text inside the terminal is **English only**.
- Frontend for official `pasarguard` and `pg-node` commands.
- Compatible with future official updates.

---

## Uninstall

```bash
rm -f /usr/local/bin/pg-m
```

---

## License

MIT

**Made for the PasarGuard community**
