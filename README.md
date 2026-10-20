[README.md](https://github.com/user-attachments/files/33727811/README.md)
<div align="center">

# 🛡️ PasarGuard Manager

### x-ui style terminal menu for PasarGuard Panel & Node — with full backup, restore and one-command server migration

**Version 2.2.1**

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

Or install this fixed release manually:

```bash
# copy the pg-m binary from the zip to /usr/local/bin/pg-m (or your previous path)
chmod +x pg-m
cp pg-m /usr/local/bin/pg-m
```

Then:

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
pg-m --node-certs           # weekly node-domain cert job
```

---

## 📋 Menu

```
┌──────────────────────────────────────────────────────────────┐
│                 PasarGuard Manager  v2.2.1                   │
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
│ 17. Node-domain Certificates       (issue + weekly renew)    │
└──────────────────────────────────────────────────────────────┘
```

---

## 🆕 What's new in 2.2.1

### Bug fix — Option 1 never asks for remote credentials
- **Option 1** = Issue on THIS server (master mode) → certificates are saved locally into `/var/lib/pasarguard/certs/<domain>/`.  
  It **never** asks for master IP / SSH port / root password.
- **Option 2** = Issue on this server + PUSH to master → only this path asks for the master address (run it on the node).
- Previous push settings are cleared when you choose Option 1 so residual config cannot confuse the flow.
- Menu labels made clearer.

### ArvanCloud DNS support (in addition to Cloudflare)
When proving domain ownership you now have three choices:
1. Cloudflare DNS
2. **ArvanCloud DNS** (API Key from npanel.arvancloud.ir → Profile → API Keys)
3. Standalone port 80 (domain must point to this server)

### Node-domain certificates (menu 17) — reminder
- **Mode 1 (local/master):** certbot → files land in `/var/lib/pasarguard/certs/<domain>/{fullchain.pem,key.pem}`
- **Mode 2 (push):** run on the server that owns the domain; give master address + root password **once** (only used to install an SSH key, never stored); weekly job renews and copies only when the cert changed.
- Weekly cron: Monday 04:00 (`pg-m --node-certs`)
- Menu prints the exact two paths to paste into the panel’s host/node TLS settings, with expiry dates.

---

## 🔐 SSL & Node-domain certs

- Issue Let's Encrypt for one or several (sub-)domains, DNS pre-check before certbot.
- Certs are copied to a path the panel container can read; `.env` is updated where needed.
- Auto-renew hook re-copies certs and can restart the panel.
- Node domains: use menu **17**. Prefer **Option 1** when the domain already points to the machine you are on (or when using Cloudflare/Arvan DNS challenge). Use **Option 2** only when the domain points to a node and you want the files on the master.

---

## 🗄️ Database Overview (menu 9 → 1)

Works with **TimescaleDB, PostgreSQL, MySQL, MariaDB and SQLite**. Shows type, version, size, status, connections, every table with exact row count and size, users total + by status, admins and nodes list. Safe password reset updates the DB **and** `.env` / compose together.

---

## 💾 Backup & Restore

One self-contained archive (`/root/pg-m-backups/*.tar.gz` + `.sha256`):

| Included | Full | Lite |
|----------|:----:|:----:|
| Database dump | ✅ | ✅ |
| `/opt/pasarguard` (`.env`, compose) | ✅ | ✅ |
| `/var/lib/pasarguard` (certs, xray config, templates) | ✅ | ✅ (no geo) |
| `/etc/letsencrypt` | ✅ | ✅ |
| nginx, `/etc/pg-m`, cron | ✅ | ✅ |
| pg-node directories | ✅ | – |

Telegram auto-backup, smart restore, official `pasarguard backup` still available.

> ⚠️ Backups contain private keys. Keep them private (`chmod 600`).

---

## 🚚 Migrate to a New VPS (menu 6)

Full Auto Transfer: new IP + SSH → pre-flight → optional freeze → package (DB + config + all certs) → upload with checksum → restore on new server with same credentials → compare users/admins/nodes → optional Cloudflare DNS switch.

---

## 🆕 What's new in 2.2 / 2.1 (summary)

- Node-domain certificates (menu 17) with local + push modes and weekly job.
- Fixed “restore finished but 0 users”.
- Smart restore, proper node handling on migration, remove center, monitoring & alerts, edit almost everything.

---

## 🤝 Credits

- Built for the [PasarGuard](https://github.com/PasarGuard) community
- Inspired by the classic `x-ui` management experience
- Uses official `pasarguard` and `pg-node` commands under the hood

## 📄 License

MIT License — free for personal and commercial use.

---

# 🇮🇷 فارسی

## 🚀 نصب سریع

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
```

یا نصب دستی این نسخه اصلاح‌شده:

```bash
chmod +x pg-m
cp pg-m /usr/local/bin/pg-m
```

بعد فقط بزن:

```bash
pg-m
```

---

## 📋 منو

منوی اصلی مثل نسخه قبل است + منوی **۱۷. Node-domain Certificates**.

---

## 🆕 تازه‌های نسخه ۲.۲.۱

### رفع باگ مهم
- **گزینه ۱** = صدور سرت روی **همین سرور** (حالت مستر)  
  فایل‌ها مستقیم در `/var/lib/pasarguard/certs/<دامنه>/` ذخیره می‌شوند.  
  **هرگز** IP، پورت SSH یا پسورد روت نمی‌پرسد.
- **گزینه ۲** = صدور روی این سرور + ارسال (Push) به مستر  
  فقط این گزینه ازت آدرس مستر می‌پرسد (باید روی نود اجرا شود).
- وقتی گزینه ۱ را انتخاب می‌کنی، تنظیمات قبلی Push پاک می‌شود تا گیج‌کننده نباشد.
- متن منو واضح‌تر شده.

### پشتیبانی DNS اروان کلود (علاوه بر Cloudflare)
الان سه روش برای اثبات مالکیت دامنه داری:
1. Cloudflare DNS
2. **ArvanCloud DNS** (API Key از پنل اروان → پروفایل → API Keys)
3. Standalone پورت ۸۰ (دامنه باید به همین سرور اشاره کند)

### یادآوری منوی ۱۷ (سرتیفیکیت دامنه‌های نود)
- **حالت ۱ (محلی / مستر):** سرت روی همین سرور گرفته و در مسیر پنل ذخیره می‌شود.
- **حالت ۲ (Push):** روی سروری که دامنه به آن اشاره می‌کند اجرا کن؛ یک‌بار آدرس + پسورد روت مستر را می‌دهی (فقط برای نصب کلید SSH، ذخیره نمی‌شود)؛ کرون هفتگی تمدید و در صورت تغییر کپی می‌کند.
- کرون پیش‌فرض: دوشنبه ساعت ۰۴:۰۰ (`pg-m --node-certs`)
- منو مسیر دقیق `fullchain.pem` و `key.pem` را برای کپی در تنظیمات TLS پنل نشان می‌دهد.

---

## 🔐 SSL و سرت دامنه نود

- صدور Let's Encrypt برای یک یا چند ساب‌دامین، چک DNS قبل از صدور.
- سرت‌ها به مسیری کپی می‌شوند که کانتینر پنل بتواند بخواند.
- هوک تمدید خودکار + امکان ریستارت پنل.
- برای دامنه‌های نود از منوی **۱۷** استفاده کن:
  - دامنه به همین سرور اشاره می‌کند یا Cloudflare/Arvan داری → **گزینه ۱**
  - دامنه به نود اشاره می‌کند و می‌خواهی فایل‌ها روی مستر باشد → **گزینه ۲** روی نود

---

## 🗄️ نمای کلی دیتابیس، بکاپ، انتقال سرور

همان امکانات نسخه ۲.۲: پشتیبانی TimescaleDB / PostgreSQL / MySQL / MariaDB / SQLite، بکاپ کامل و لایت + تلگرام، ریستور هوشمند، انتقال یک‌کلیکی به سرور جدید با مقایسه تعداد کاربر/ادمین/نود و تغییر خودکار DNS با Cloudflare.

---

## 🤝 Credits

- ساخته‌شده برای جامعه [PasarGuard](https://github.com/PasarGuard)
- الهام‌گرفته از تجربه مدیریت کلاسیک `x-ui`
- از دستورات رسمی `pasarguard` و `pg-node` استفاده می‌کند

## 📄 License

MIT — رایگان برای استفاده شخصی و تجاری.
