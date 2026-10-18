[Uploading README.md…]()
<div align="center">

# 🛡️ PasarGuard Manager

### x-ui style terminal menu for PasarGuard Panel & Node — with full backup, restore and one-command server migration

**Version 2.1.0**

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Bash-5%2B-green.svg)](#)
[![PasarGuard](https://img.shields.io/badge/PasarGuard-Compatible-orange.svg)](https://github.com/PasarGuard)

One command. Full control.

**[English](#-english) • [فارسی](#-فارسی)**

</div>

---

# 🇬🇧 English

## 🚀 Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

Then just type:

```bash
pg-m
```

CLI shortcuts (also usable from cron):

```bash
pg-m status                 # containers, URL, resources
pg-m doctor                 # full health check (20+ checks)
pg-m db                     # database overview
pg-m backup [full|lite]     # create backup
pg-m restore FILE           # restore backup / migration package
pg-m update                 # update pg-m itself
```

---

## 📋 Menu

```
┌──────────────────────────────────────────────────────────────┐
│                 PasarGuard Manager  v2.1.0                   │
│  Panel:UP  DB:UP                                             │
│  https://panel.example.com/dashboard/                        │
│  host | IP | load | RAM | disk                               │
│  Image: v1.x | DB: TimescaleDB | Users: 512 (active 430)     │
├──────────────────────────────────────────────────────────────┤
│  1. Install / Update / Uninstall   (auto-backup before)      │
│  2. Service Management                                       │
│  3. Panel Settings                                           │
│  4. SSL Certificate Management                               │
│  5. Backup & Restore               (Full / Lite / Telegram)  │
│  6. Migrate to New Server          (Full Auto Transfer)      │
│  7. Node Management      (Install / Fresh / Remove / Edit)   │
│  8. Firewall & Security                                      │
│  9. Database Management            (Overview / Fix)          │
│ 10. Tools & Utilities                                        │
│ 11. Quick Status / Doctor                                    │
│ 12. Subscription Relay / Tunnel                              │
│ 13. Domains & DNS                  (Cloudflare auto-update)  │
│ 14. Update pg-m / About                                      │
│ 15. Remove / Uninstall Center      (remove anything pg-m added)│
│ 16. Monitoring & Alerts            (auto-restart watchdog)   │
└──────────────────────────────────────────────────────────────┘
```

---

## 🗄️ Database Overview (menu 9 → 1)

Works with **TimescaleDB, PostgreSQL, MySQL, MariaDB and SQLite**. Shows:

- type, version, size, status, connections
- every table with **exact row count and size**
- users total + by status (active / expired / limited …), total traffic used
- admins list and nodes list

Also: masked connection info, interactive `psql`/`mysql` shell, dump, VACUUM/OPTIMIZE, and a **safe password reset** that updates the DB *and* `.env` / compose together (the old version broke the panel here).

---

## 💾 Backup & Restore

`pg-m` creates one self-contained archive (`/root/pg-m-backups/*.tar.gz` + `.sha256`):

| Included | Full | Lite |
|----------|:----:|:----:|
| Database dump (pg_dump / mysqldump / SQLite snapshot) | ✅ | ✅ |
| `/opt/pasarguard` (`.env`, `docker-compose.yml`) | ✅ | ✅ |
| `/var/lib/pasarguard` (certs, xray config, templates) | ✅ | ✅ (no geo files) |
| `/etc/letsencrypt` (all certs incl. sub-domains) | ✅ | ✅ |
| nginx config, `/etc/pg-m`, cron jobs | ✅ | ✅ |
| pg-node directories | ✅ | – |

- **Telegram auto-backup**: every 1/3/6/12/24 h, retention, proxy support, files > 50 MB are split automatically.
- **Restore** takes a safety snapshot of the current state first, then restores files + database and **verifies user/admin/node counts**.
- Official `pasarguard backup / restore` is still available (Backup → 8).

> ⚠️ Backups contain `.env` and private keys. Keep them private (files are `chmod 600`).

---

## 🚚 Migrate to a New VPS (menu 6)

**Option 1 — Full Auto Transfer.** You provide: new IP, SSH port, password or key. Then:

1. Pre-flight on the new server: SSH, OS, architecture, RAM, free disk, Docker, existing panel
2. *(optional)* freezes the old panel so no data changes during the move
3. Builds the package: **DB dump + `.env` + compose + panel data + all certificates (panel & sub-domains) + nginx + cron + Telegram settings**
4. Uploads it (retry + sha256 verification)
5. On the new server: installs Docker, restores everything with the **same DB name / password / port / image versions**, starts the stack
6. Compares **users / admins / nodes** between old and new server
7. Checks **DNS of every domain** and, with a Cloudflare token (menu 13), switches the A-records to the new IP
8. Optionally keeps the old panel stopped, removes the package from the new server, prints a checklist

**Option 3 — Restore a package on this server** is for the manual route: copy the package (`scp`), install `pg-m` on the new VPS, run Migrate → 3.

Tip: lower the DNS TTL a few hours before migrating.

---

## 🔐 SSL

- Issue Let's Encrypt for one or several (sub-)domains, **DNS pre-check** before certbot
- Certs are copied to a path the container can read, `.env` is updated
- **Auto-renew hook** (re-copies certs and restarts the panel after every renewal)
- Health check with per-domain SNI test, list/expiry, self-signed, revoke/delete

## 🧰 More

| Area | Features |
|------|----------|
| **Doctor** | Docker, DB, panel HTTP, disk, RAM/swap, SSL expiry, NTP, UFW, backup age … |
| **Firewall** | UFW (keeps your real SSH port), BBR, Fail2Ban, lock panel / node API port to one IP |
| **Node** | install, control (`pg-node`), API key, certificate, lock API port to the panel IP |
| **Domains** | DNS status of all cert domains, Cloudflare API: point one/all domains to an IP |
| **Tools** | Speedtest, swap, NTP sync, log cleanup, docker prune (safe), geo files |
| **Relay** | nginx reverse-proxy config for subscription links |
| **Self-update** | `pg-m update` (validates the script before replacing) |

## 🆕 What's new in 2.1

- **Fixed: "restore finished but 0 users"** — the old code imported while the database container was still in its first-start init phase (a temporary socket-only server). Now pg-m waits for the *real* server over TCP, imports with up to 3 retries, **checks that tables really exist**, prints the real error lines, and does **not** start the panel on an empty DB. Migration offers to retry the remote restore.
- **Smart Restore** (Backup → 3): one numbered list of *every* backup on the server (pg-m packages, official `pasarguard backup` zips, `.sql`, `.sql.gz`, `.dump`, SQLite). Pick by **number, part of the name, full path, or `l` = latest**. Zips inside zips, official zips and raw dumps are detected automatically. Backup → 8 restores only the database; CLI: `pg-m restore`, `pg-m restore-db FILE`.
- **Nodes done right**: migration no longer copies the old node's API key/certificate. By default a **fresh node** is installed on the new server and its address / port / **API key / certificate** are printed ready to paste into the panel. Node menu: install, **reinstall fresh**, **uninstall**, control/update, connection info, **edit .env / compose**, lock API port.
- **Remove / Uninstall Center** (menu 15): panel, nodes, SSL + hook, Telegram/scheduled backups, watchdog, swap, BBR, Fail2Ban, UFW (disable/reset), Cloudflare token, relay files, Docker log rotation, old backups, pg-m itself — each with an `[installed]` indicator.
- **Edit almost everything**: `.env`, compose, **core config (xray_config.json with JSON validation + revert)**, node `.env`/compose, pg-m settings, swap size, **SSH port** (tested before applying, handles Ubuntu 24.04 `ssh.socket`), backup schedule.
- **Monitoring & Alerts** (menu 16): watchdog every 5 min — restarts panel/DB if down, alerts via Telegram on down/disk ≥ 90 %/SSL expiring (tries to renew).
- **Server tools**: one-click optimize (swap, BBR, NTP, Docker log rotation, UFW, Fail2Ban), Docker log rotation, quieter output (no more walls of docker-compose lines).

---

## 🔧 What changed in 2.0

- Migration rewritten: logical DB dump + exact config copy instead of raw data directories
- Fixed risky cleanups: no more `docker rm` by name pattern (could delete other projects) and no `fuser -k 80`
- Fixed DB password reset (now updates `.env` and compose)
- Fixed UFW enable locking you out on non-22 SSH ports
- Removed hard-coded domains; Ctrl+C in live logs no longer kills the menu
- New: database overview, Telegram backup, doctor, Cloudflare DNS, auto-renew hook, CLI shortcuts

---

## 📌 Requirements

- Debian / Ubuntu (recommended), root access
- Docker (installed automatically if missing)
- Optional: `sshpass` (auto-installed for password migration), `jq` (Cloudflare)

## 🗑️ Uninstall Manager Only

```bash
rm -f /usr/local/bin/pg-m /etc/cron.d/pg-m-backup
```

This does **not** remove your PasarGuard panel or data.

---

# 🇮🇷 فارسی

## 🚀 نصب سریع

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

بعد از نصب فقط بزنید: `pg-m`

## ✨ امکانات نسخه ۲

- **نمایش کامل دیتابیس** (منوی ۹ ← ۱): نوع و حجم دیتابیس، تمام جدول‌ها با تعداد رکورد دقیق، تعداد کاربران به تفکیک وضعیت، ادمین‌ها و نودها. پشتیبانی از TimescaleDB، PostgreSQL، MySQL، MariaDB و SQLite.
- **بکاپ کامل**: دیتابیس + `.env` + compose + دیتای پنل + همه سرتیفیکیت‌ها (پنل و ساب‌دامین) + nginx + کرون، در یک فایل با چک‌سام. بکاپ خودکار تلگرام (با پروکسی و تقسیم خودکار فایل‌های بزرگ).
- **انتقال به سرور جدید (منوی ۶ ← ۱)**:
  1. بررسی سرور جدید (سیستم‌عامل، رم، فضا، داکر)
  2. توقف اختیاری پنل قدیم برای جلوگیری از تغییر دیتا
  3. ساخت پکیج کامل و آپلود با تأیید چک‌سام
  4. نصب داکر و ریستور کامل روی سرور جدید با **همان دیتابیس، پسورد، پورت و ورژن**
  5. مقایسه تعداد کاربر / ادمین / نود بین دو سرور
  6. بررسی DNS همه دامنه‌ها و تغییر خودکار رکوردها با Cloudflare (منوی ۱۳)
- **SSL**: صدور برای چند ساب‌دامین، چک DNS قبل از صدور، هوک تمدید خودکار.
- **Doctor**: بررسی سلامت کل سرور و پنل با یک دستور: `pg-m doctor`
- **فایروال امن**: UFW پورت واقعی SSH را باز نگه می‌دارد؛ قفل کردن پورت پنل/نود روی یک IP.

## 🆕 تازه‌های نسخه ۲.۱

- **رفع باگ «ریستور تمام شد ولی کاربران ۰ بود»**: قبلاً import وقتی انجام می‌شد که دیتابیس هنوز در مرحله init اولیه بود. حالا منتظر سرور واقعی می‌ماند، تا ۳ بار تلاش می‌کند، وجود جدول‌ها را چک می‌کند، خطای واقعی را نشان می‌دهد و پنل را روی دیتابیس خالی بالا نمی‌آورد.
- **ریستور هوشمند** (منوی ۵ ← ۳): یک لیست شماره‌دار از *همه* بکاپ‌های سرور (پکیج pg-m، زیپ رسمی `pasarguard backup`، `.sql`، `.dump`، SQLite). انتخاب با **شماره، قسمتی از اسم، مسیر کامل یا `l` برای آخرین**. فایل داخل فایل هم خودکار پیدا می‌شود.
- **نود درست**: در انتقال، API key و سرتیفیکیت نود قبلی کپی نمی‌شود؛ به‌صورت پیش‌فرض یک **نود جدید** نصب می‌شود و آدرس، پورت، API key و certificate آماده کپی در پنل نشان داده می‌شود. منوی نود: نصب، نصب مجدد تازه، **حذف**، کنترل، ویرایش `.env` و compose.
- **مرکز حذف** (منوی ۱۵): هر چیزی که pg-m نصب کرده با نشانگر `[installed]` قابل حذف است.
- **ویرایش تقریباً همه چیز**: `.env`، compose، کانفیگ هسته (xray) با اعتبارسنجی JSON، تنظیمات نود، اندازه swap، **پورت SSH** (با تست قبل از اعمال)، زمان‌بندی بکاپ.
- **مانیتورینگ** (منوی ۱۶): اگر پنل یا دیتابیس خاموش شود خودکار ریستارت می‌کند و در تلگرام خبر می‌دهد (دیسک، SSL).

## 🚚 مراحل انتقال سریع

1. روی سرور **قدیم**: `pg-m` ← `6` ← `1`
2. IP سرور جدید، پورت SSH و پسورد (یا کلید) را بدهید
3. صبر کنید تا بررسی‌ها و ریستور تمام شود و تعداد کاربران یکسان تأیید شود
4. رکورد A دامنه‌ها را به IP جدید ببرید (یا توکن Cloudflare بدهید تا خودکار انجام شود)
5. وارد پنل جدید شوید و نودها را تست کنید

> اگر SSH مستقیم ممکن نیست: بکاپ بسازید (`6 ← 2`)، با `scp` به سرور جدید ببرید، `pg-m` را نصب کنید و `6 ← 3` را بزنید.

> ⚠️ فایل‌های بکاپ شامل کلیدهای خصوصی هستند؛ آن‌ها را جای امن نگه دارید.

---

## 🤝 Credits

- Built for the [PasarGuard](https://github.com/PasarGuard) community
- Inspired by the classic `x-ui` management experience
- Uses official `pasarguard` and `pg-node` commands under the hood

## 📄 License

MIT License — free for personal and commercial use.
