#!/usr/bin/with-contenv sh

# 设置时区https://wiki.alpinelinux.org/wiki/Setting_the_timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

#显示信息
echo "========================================="
echo "当前服务器时间：$(date "+%Y-%m-%d %H:%M:%S")"
echo "========================================="
echo -e "当前caddy2版本：\n$(caddy version)"
echo "========================================="
echo -e "当前caddy2版本已安装的模块：\n$(caddy list-modules)"
echo "========================================="
