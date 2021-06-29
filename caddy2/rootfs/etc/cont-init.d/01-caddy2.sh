#!/usr/bin/with-contenv sh

# 设置时区https://wiki.alpinelinux.org/wiki/Setting_the_timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

# 复制默认配置文件
if [ -s "/etc/caddy/Caddyfile" ];then
	echo "==>Caddyfile文件已存在。"
else 
echo "{
  email email@example.com # email for ACME
  order webdav before file_server # Important, webdav plugin should be ordered before file_server
}

webdav.example.com {
  encode zstd gzip # optional compression
  basicauth { # optional auth
    example-user HASHED_PASSWORD
  }
  webdav {
    root /opt/sites/Webdav-Site
  }
}" > /etc/caddy/Caddyfile
echo "==>Caddyfile文件已建立。"
fi


#显示信息
echo "========================================="
echo "当前服务器时间：$(date "+%Y-%m-%d %H:%M:%S")"
echo "========================================="
echo -e "当前caddy2版本：\n$(caddy version)"
echo "========================================="
echo -e "当前caddy2版本已安装的模块：\n$(caddy list-modules)"
echo "========================================="
