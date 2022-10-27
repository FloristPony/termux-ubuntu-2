echo "Ubuntu 22.04 LTS Installer by Tiffany Lynch. Starting in 5 seconds"
sleep 5
pkg up -y
pkg in proot wget -y
wget https://partner-images.canonical.com/oci/jammy/current/ubuntu-jammy-oci-arm64-root.tar.gz
mkdir -p ubuntu22
cd ubuntu22
proot --link2symlink tar xf $HOME/ubuntu-jammy-oci-arm64-root.tar.gz --exclude=dev||:
cd $HOME
cat <<EOF > launch.sh
unset LD_PRELOAD
proot --kill-on-exit --link2symlink -0 -r ubuntu22 -b /dev -b /proc -b /sys -b /data -w /root /usr/bin/env -i HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin TERM=xterm-256color LANG=C.UTF-8 /bin/bash --login
EOF
echo "nameserver 8.8.8.8" >> ubuntu22/etc/resolv.conf
touch ubuntu22/root/.hushlogin
echo "Install completed. Launch ubuntu by 'bash launch.sh'."
