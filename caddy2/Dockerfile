ARG CADDY_VERSION=2.4.3
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/plugin/v2 \
    --with github.com/mholt/caddy-webdav \
    --with github.com/porech/caddy-maxmind-geolocation \
    --with github.com/greenpau/caddy-auth-jwt \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/dnspod \
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/lego-deprecated

FROM caddy:${CADDY_VERSION}-alpine

ARG S6_VER=2.2.0.3
ENV TZ=Asia/Shangha
ENV CADDY_DOCKER_CADDYFILE_PATH=/config/Caddyfile

ADD rootfs /
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk upgrade --update --no-cache \
# 安装应用
    && apk add --no-cache tzdata \
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

ENTRYPOINT [ "/init" ]