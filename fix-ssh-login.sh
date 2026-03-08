cat << 'EOF' > auto-fix-ssh.sh
#!/bin/bash

# Jika bukan root, otomatis sudo
if [ "$EUID" -ne 0 ]; then
  echo "Switch ke root..."
  sudo -i "$0"
  exit
fi

echo "Memperbaiki konfigurasi SSH..."

echo "Set password root:"
passwd root

echo "Backup konfigurasi SSH..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo "Mengatur sshd_config..."
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

echo "Memperbaiki config cloud-init..."
if [ -f /etc/ssh/sshd_config.d/60-cloudimg-settings.conf ]; then
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
    sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
fi

echo "Restart SSH..."
systemctl restart ssh

echo "Selesai. Status konfigurasi:"
sshd -T | egrep 'permitrootlogin|passwordauthentication'
EOF
