#!/usr/bin/with-contenv sh

#设定更新任务
if [ ! -e "/crontabs/root" ];then
    mkdir -p crontabs
    cp /var/spool/cron/crontabs/root /crontabs/root
    echo "==>/crontabs/root已建立。"
else
    echo "==>/crontabs/root已存在。"
fi

ln -sf /crontabs/root /var/spool/cron/crontabs/root