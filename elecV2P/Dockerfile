FROM node:alpine

ARG S6_VER=2.2.0.3
ARG V2P_VER=

ENV PATH /usr/local/app/node_modules/.bin:$PATH
ENV TZ=Asia/Shanghai

ADD rootfs /

RUN apk upgrade --update --no-cache \
# 安装应用
    && apk add --no-cache tzdata git python3 \
    && wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && pip3 install --no-cache-dir -r /requirements.txt \
# 安装s6-overlay
    && if [ "$(uname -m)" = "x86_64" ];then s6_arch=amd64;elif [ "$(uname -m)" = "aarch64" ];then s6_arch=aarch64;elif [ "$(uname -m)" = "armv7l" ];then s6_arch=arm; fi \
    && wget --no-check-certificate https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-${s6_arch}.tar.gz \
    && tar xzf s6-overlay-${s6_arch}.tar.gz -C / \
    && rm s6-overlay-${s6_arch}.tar.gz \
# 安装elecV2P
    && if [ "$V2P_VER" = "" ];then git clone https://github.com/elecV2/elecV2P.git /usr/local/app;else wget --no-check-certificate https://github.com/elecV2/elecV2P/archive/${V2P_VER}.tar.gz;mkdir -p /usr/local/app;tar xzf ${V2P_VER}.tar.gz elecV2P-${V2P_VER}/ --strip-components 1 -C /usr/local/app;rm ${V2P_VER}.tar.gz; fi \
    && cd /usr/local/app \
    && yarn install --production \
    && yarn global add pm2 \
    && chmod -R 777 /usr/local/app \
    && cp -a ./script ./tmp \
# 清除缓存
    && apk del git \
    && rm /get-pip.py \
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf $HOME/.cache

VOLUME /usr/local/app

WORKDIR /usr/local/app

EXPOSE 80 8001 8002

ENTRYPOINT [ "/init" ]
