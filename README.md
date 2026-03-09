# Akses Root VPS

Script untuk mengaktifkan login root dan password SSH pada VPS Ubuntu setelah rebuild.

## Install

Jalankan perintah berikut di VPS:

```bash
wget -qO- https://raw.githubusercontent.com/skynet-vpn/akses-rootvps/main/fix-ssh-login.sh | bash
```
Lock Dropbear Potato

```bash
dropbear -V && apt-mark hold dropbear && chattr +i /usr/sbin/dropbear
```

menganti welcome di server id
```bash
bash <(curl -sSL https://raw.githubusercontent.com/skynet-vpn/akses-rootvps/main/welcome.sh)
```
