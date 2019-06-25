# Snell安装脚本

+ [x] 端口：`14250`    可自定义：[1-65535] 
+ [x] Obfs：`tls`         可自定义：[tls/http/off]
+ [x] PSK：随机生成的16位字符
+ [x] 若已安装 Snell，直接输出配置

---

### 安装


Debian & Ubuntu 用户请运行

```
wget --no-check-certificate -O snell.sh https://raw.githubusercontent.com/yudingsxt/snell.sh/master/snell-port.sh
chmod +x snell.sh
./snell.sh
```

Centos & RedHat 用户请运行

```
wget --no-check-certificate -O snell.sh https://raw.githubusercontent.com/yudingsxt/snell.sh/master/snell.centos-port.sh
chmod +x snell.sh
./snell.sh
```

---

### 卸载

卸载方法：

```
wget --no-check-certificate -O uninstall-snell.sh https://raw.githubusercontent.com/yudingsxt/snell.sh/master/uninstall-snell.sh
chmod +x uninstall-snell.sh
./uninstall-snell.sh
```

---

### 查看

运行状态

```
systemctl status snell
```

重启 Snell
```
systemctl restart snell
```

启动 Snell
```
systemctl start snell
```

停止 Snell
```
systemctl stop snell
```

---

### 修改

查看 Snell 配置文件

```
cat /etc/snell/snell-server.conf
```

修改  Snell 配置文件

```
vi /etc/snell/snell-server.conf
```

vi 编辑如下配置即可

```
[snell-server]
listen = 0.0.0.0:14250
psk = x3IBaVj9K6a6PAzF
obfs = tls
```

或者将编辑好的[snell-server.conf](https://raw.githubusercontent.com/ydzydzydz/snell.sh/master/snell-server.conf)，通过 ftp 软件上传到对应路径

---

### 效果

<img width="80%" src="https://raw.githubusercontent.com/ydzydzydz/blogphoto/master/snell/1.jpg" />

---

### 捷径

照着大佬的脚本撸了个[捷径](https://github.com/ydzydzydz/snell.sh/raw/master/Snell%E5%AE%89%E8%A3%85%26%E5%8D%B8%E8%BD%BD%26%E7%AE%A1%E7%90%86.shortcut)，直接运行即可安装&卸载&查看&管理状态

**但是不能安装时自定义端口，默认端口为`13254`，安装结束后会将 Snell 配置导出到备忘录，复制到 Surge 中即可使用**

---

**Forked from：[primovist/snell.sh](https://github.com/primovist/snell.sh)**

