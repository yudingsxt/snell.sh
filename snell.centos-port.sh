#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
CONF="/etc/snell/snell-server.conf"
SYSTEMD="/etc/systemd/system/snell.service"
yum install unzip -y
cd ~/
wget --no-check-certificate -O snell.zip https://github.com/surge-networks/snell/releases/download/v1.1.0/snell-server-v1.1.0-linux-amd64.zip
unzip -o snell.zip
rm -f snell.zip
chmod +x snell-server
mv -f snell-server /usr/local/bin/



if [ -f ${CONF} ]; then
  echo "Found existing config..."

  else
  if [ -z ${snell_port} ]; then
    echo -e "请输入 Snell 端口 [1-65535]"
    read -e -p "(默认: 12312):" snell_port
    [[ -z "${snell_port}" ]] && snell_port="12312"

		echo && echo "============================="
		echo -e "	端口 : ${snell_port} "
		echo "=============================" && echo

  else
    echo && echo "============================="
		echo -e "	端口 : 12312 "
		echo "=============================" && echo
  fi

  if [ -z ${snell_obfs} ]; then
    echo -e "请输入 obfs ( tls / http ) "
    read -e -p "(默认: tls):" snell_obfs
    [[ -z "${snell_obfs}" ]] && snell_obfs="tls"

		echo && echo "============================="
		echo -e "	obfs : ${snell_obfs} "
		echo "=============================" && echo

  else
    echo && echo "============================="
		echo -e "	obfs : tls "
		echo "=============================" && echo
  fi

  if [ -z ${PSK} ]; then
    PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)

    echo && echo "============================="
		echo -e "	PSK : ${PSK} "
		echo "=============================" && echo

  else

    echo && echo "============================="
    echo -e "	PSK : ${PSK} "
    echo "=============================" && echo

  fi
  echo && echo "============================="
  echo "[snell-server]"
  echo "listen = 0.0.0.0:${snell_port}"
  echo "psk = ${PSK}"
  echo "obfs = ${snell_obfs}"
  echo "=============================" && echo

  mkdir /etc/snell/
  echo "Generating new config..."
  echo "[snell-server]" >>${CONF}
  echo "listen = 0.0.0.0:${snell_port}" >>${CONF}
  echo "psk = ${PSK}" >>${CONF}
  echo "obfs = ${snell_obfs}" >>${CONF}
fi
if [ -f ${SYSTEMD} ]; then
  echo "Found existing service..."
  systemctl daemon-reload
  systemctl restart snell
else
  echo "Generating new service..."
  echo "[Unit]" >>${SYSTEMD}
  echo "Description=Snell Proxy Service" >>${SYSTEMD}
  echo "After=network.target" >>${SYSTEMD}
  echo "" >>${SYSTEMD}
  echo "[Service]" >>${SYSTEMD}
  echo "Type=simple" >>${SYSTEMD}
  echo "LimitNOFILE=32768" >>${SYSTEMD}
  echo "ExecStart=/usr/local/bin/snell-server -c /etc/snell/snell-server.conf" >>${SYSTEMD}
  echo "" >>${SYSTEMD}
  echo "[Install]" >>${SYSTEMD}
  echo "WantedBy=multi-user.target" >>${SYSTEMD}
  systemctl daemon-reload
  systemctl enable snell
  systemctl start snell
fi
