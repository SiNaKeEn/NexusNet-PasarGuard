[README.md](https://github.com/user-attachments/files/33136636/README.md)
# PasarGuard Manager (pg-m) v1.3.0

Clean x-ui style menu for PasarGuard.

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/install.sh)
pg-m
```

## Menu

```
0. Service Management
1. Install / Update / Uninstall
2. Panel Port & Links
3. SSL Certificate Management
4. Backup & Restore
5. Migrate to New Server
6. Panel Settings
7. Node Management
8. Firewall & Security
9. Tools
10. Quick Status
11. Exit
```

## SSL features

- List certs with Active / Expires soon / EXPIRED
- New Let's Encrypt (warns if already exists)
- Renew (certbot renew)
- Apply cert to panel .env
