FROM alpine:latest

ARG S6_VER=2.2.0.3

ENV TZ=Asia/Shanghai \
    MOON_PORT=9993 \
    IPV4_ADDRESS= \
    IPV6_ADDRESS=

ADD rootfs /

RUN apk upgrade --update --no-cache \
# 安装应用
    && apk add --no-cache tzdata zerotier-one \
# 安装s6-overlay
    && if [ "$(uname -m)" = "x86_64" ];then s6_arch=amd64;elif [ "$(uname -m)" = "aarch64" ];then s6_arch=aarch64;elif [ "$(uname -m)" = "armv7l" ];then s6_arch=arm; fi \
    && wget --no-check-certificate https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-${s6_arch}.tar.gz \
    && tar xzf s6-overlay-${s6_arch}.tar.gz -C / \
    && rm s6-overlay-${s6_arch}.tar.gz \
# 清除缓存
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf $HOME/.cache

EXPOSE 9993/udp

VOLUME /var/lib/zerotier-one

WORKDIR /var/lib/zerotier-one

ENTRYPOINT [ "/init" ]