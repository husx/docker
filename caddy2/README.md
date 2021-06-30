# caddy2
自用caddy2镜像,添加插件。  
官方项目地址：https://caddyserver.com/  

## 插件列表
|             名称             |                        地址                        |                        说明                        |
| :-------------------------- | :------------------------------------------------ | ------------------------------------------------- |
| caddy-docker-proxy/plugin/v2 | https://github.com/lucaslorentz/caddy-docker-proxy | 该插件使 Caddy 能够通过标签用作 Docker 容器的反向代理 |
|         caddy-webdav         |       https://github.com/mholt/caddy-webdav        |               |
| caddy-maxmind-geolocation | https://github.com/porech/caddy-maxmind-geolocation |  |
| caddy-dns/cloudflare | https://github.com/caddy-dns/cloudflare |  |
| caddy-dns/dnspod | https://github.com/caddy-dns/dnspod |  |
| caddy-dns/alidns | https://github.com/caddy-dns/alidns |  |
| caddy-dns/lego-deprecated | https://github.com/caddy-dns/lego-deprecated |  |

## 版本

| 名称    | 版本      | 说明                  |
| :-----: | :-------: | :-------------------: |
| caddy2 | 2.4.3/latest | 跟随官方代码更新|


## 配置

### 环境变量
下面是可用于自定义安装的可用选项的完整列表。  

| 参数 | 描述                            |
| :--: | ------------------------------- |
| `TZ` | 设置时区-默认： `Asia/Shanghai` |
| `CADDY_DOCKER_CADDYFILE_PATH` | 定义容器内部Caddyfile位置，默认不设置         |
|   `CADDY_INGRESS_NETWORKS`    | 手动配置 caddy 入口网络,未定义时，连接到控制器容器的网络被视为入口网络***（可选）*** |

### 开放的端口
| 范围 | 描述 |
| :-----:| ---- |
| `80` |http端口  |
| `443` |https端口 |
| `2019` |Caddy2 API端口***（可选）*** |

### 数据卷
下面的目录用于配置，并且可以映射为持久存储。

| 目录                   | 描述                                   |
| ---------------------- | -------------------------------------- |
| `/config`              | 配置目录                               |
| `/data`                | TLS 证书、私钥、和其他必要信息存储目录 |
| `/var/run/docker.sock` | 连接到 Docker 主机                     |

## docker-compose.yml
```yml
version: '3'
services:
  caddy2:
    image: hushunxu/caddy2:latest
    container_name: caddy2
    restart: always
    networks:
      - web
    environment:
      - TZ=Asia/Shanghai
      - CADDY_INGRESS_NETWORKS=web
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./docker/caddy2/config:/config
      - ./docker/caddy2/data:/data
	  
networks:
  web:
    external: true
```