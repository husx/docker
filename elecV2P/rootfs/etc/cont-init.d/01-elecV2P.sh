#!/usr/bin/with-contenv sh

# 设置时区https://wiki.alpinelinux.org/wiki/Setting_the_timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

#显示信息
echo "==>当前时间：$(date "+%Y-%m-%d %H:%M:%S")"
echo "==>当前python版本：$(python3 -V)"
echo "==>当前pip版本：$(pip -V)"

#复制自带示例
echo "==>复制自带示例至efss/example文件夹"
cd /usr/local/app
rm -rf ./efss/example
cp -af ./tmp ./efss/example
rm -rf ./tmp
rm -rf ./efss/example/tmp