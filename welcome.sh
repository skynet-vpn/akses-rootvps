#!/bin/bash

# Tulis ke /root/.profile
cat <<EOF > /root/.profile
# ~/.profile: executed by Bourne-compatible login shells.

if [ "\$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
$WEB_SERVER
desain p0t4t0
EOF

echo "✅ /root/.profile berhasil di-set!"
