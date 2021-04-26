#!/usr/bin/with-contenv sh

# 设置时区https://wiki.alpinelinux.org/wiki/Setting_the_timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone
date -R

#配置git全局信息
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global credential.helper 'store --file /git/.git-credentials'
if [ -e "/custom_config.sh" ];then
    echo "==>发现git自定义配置文件，正在执行..."
    chmod 755 /custom_config.sh
	sh /custom_config.sh
fi

#gitconfig文件
if [ ! -e "/git/.gitconfig" ];then
    cp /root/.gitconfig /git/.gitconfig
	ln -sf /git/.gitconfig /root/.gitconfig
    echo "==>/git/.gitconfig文件已建立。"
else 
	echo "==>/git/.gitconfig文件已存在。"
fi

#查看当前生效的配置
echo "=========当前git配置========="
git config --list
echo "============================="

#生成ssh密钥
if [ ! -e "/root/.ssh/id_rsa" ];then
    ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' -C git_docker
    echo "==>ssh密钥已生成。"
else
    echo "==>ssh密钥已存在。"
fi