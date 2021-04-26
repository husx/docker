FROM alpine:3.13

ARG S6_VER=2.2.0.1

ENV TZ=Asia/Shanghai \
    NAME= \
    EMAIL=

ADD rootfs /

RUN apk upgrade --update --no-cache \
# 安装s6-overlay
    && if [ "$(uname -m)" = "x86_64" ];then s6_arch=amd64;elif [ "$(uname -m)" = "aarch64" ];then s6_arch=aarch64;elif [ "$(uname -m)" = "armv7l" ];then s6_arch=arm; fi \
    && wget --no-check-certificate https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-${s6_arch}.tar.gz \
    && tar -xvzf s6-overlay-${s6_arch}.tar.gz \
    && rm s6-overlay-${s6_arch}.tar.gz \
# 安装应用及依赖
    && apk add --no-cache tzdata git git-subtree openssh \
# 清除缓存
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf $HOME/.cache

VOLUME /git

WORKDIR /git

ENTRYPOINT [ "/init" ]
