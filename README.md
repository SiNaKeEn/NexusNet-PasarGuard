# NexusNet-PasarGuard# PasarGuard Manager (`pg-m`)

**A powerful, clean and fully English terminal menu for PasarGuard Panel & Node.**

Inspired by 3x-ui / Sanaei style menus — built to make managing PasarGuard easy, fast and professional.

---

## Features

| Category              | Options                                      |
|-----------------------|----------------------------------------------|
| **Service**           | Start / Stop / Restart / Status / Logs       |
| **Install**           | TimescaleDB, PostgreSQL, SQLite, MySQL, MariaDB |
| **Update / Uninstall**| One-click update & clean uninstall           |
| **SSL & Domain**      | Let's Encrypt + view/edit SSL settings       |
| **Backup & Restore**  | Official backup, Telegram auto-backup, restore |
| **Panel Settings**    | Temp-key, edit .env, edit compose, DB info   |
| **Node Management**   | Install node (default / custom name)         |
| **Firewall**          | UFW rules + BBR                              |
| **Tools**             | Speedtest, disk, memory, ports, Docker clean |

---

## Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

Or from this repository:

```bash
git clone https://github.com/SiNaKeEn/NexusNet-PasarGuard.git
cd NexusNet-PasarGuard/Manager
bash install.sh
```

After installation just run:

```bash
pg-m
```

---

## Screenshots (Menu Preview)

```
╔══════════════════════════════════════════════════════════╗
║              PasarGuard Manager  v1.0.0                  ║
╚══════════════════════════════════════════════════════════╝

  1)  Service Management
  2)  Install / Update / Uninstall
  3)  SSL & Domain Management
  4)  Backup & Restore
  5)  Panel Settings
  6)  Node Management
  7)  Firewall & Security
  8)  Tools
  9)  Quick Status
  0)  Exit
```

---

## Requirements

- Ubuntu / Debian (recommended)
- Root access
- PasarGuard already installed **or** install it from the menu

---

## Notes

- All text inside the terminal is **English only** (no Persian characters).
- The menu is a frontend for official `pasarguard` and `pg-node` commands.
- It stays compatible with future official updates.

---

## Uninstall

```bash
rm -f /usr/local/bin/pg-m
```

---

## License

MIT

---

**Made for the PasarGuard community**
