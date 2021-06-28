FROM golang:alpine as builder

RUN apk add -U --no-cache ca-certificates git
RUN go get -u github.com/caddyserver/xcaddy/cmd/xcaddy 
RUN CGO_ENABLED=0 xcaddy build \
  --output artifacts/binaries/linux/caddy \
  --with github.com/lucaslorentz/caddy-docker-proxy/plugin/v2 \
  --with github.com/mholt/caddy-webdav \
  --with github.com/porech/caddy-maxmind-geolocation \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/caddy-dns/dnspod \
  --with github.com/caddy-dns/alidns \
  --with github.com/caddy-dns/lego-deprecated
RUN chmod +x artifacts/binaries/linux/caddy

FROM alpine:latest

ARG S6_VER=2.2.0.3
ENV TZ=Asia/Shangha
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

ADD rootfs /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/artifacts/binaries/linux/caddy /bin/

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

WORKDIR /
EXPOSE 80 443 2019
VOLUME /config
VOLUME /data

ENTRYPOINT [ "/init" ]
