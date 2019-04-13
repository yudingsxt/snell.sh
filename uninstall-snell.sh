#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
systemctl stop snell
systemctl disable snell
rm -f /ect/systemd/snell.service
rm -f /usr/bin/snell-server
rm -f /etc/snell/snell-server.conf
rmdir /etc/snell/
echo -e "Snell \033[1;32m 卸载完成 \033[0m"
