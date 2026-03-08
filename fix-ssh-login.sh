cat << 'EOF' > fix-ssh-login.sh
#!/bin/bash

echo "Memperbaiki konfigurasi SSH..."

# Minta password root baru
echo "Masukkan password root baru:"
passwd root

# Backup config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Edit sshd_config utama
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Perbaiki config override Ubuntu cloud
if [ -f /etc/ssh/sshd_config.d/60-cloudimg-settings.conf ]; then
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
    sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
fi

# Restart SSH
systemctl restart ssh

echo "Selesai."
echo "Cek konfigurasi:"
sshd -T | egrep 'permitrootlogin|passwordauthentication'
EOF
