# zerotier-moon
自用镜像，参考https://github.com/rwv/docker-zerotier-moon代码进行修改。  

## 版本：

| 名称    | 版本      | 说明                  |
| :-----: | :-------: | :-------------------: |
| zerotier-moon | 1.6.5/latest |  |


## 配置

### 环境变量
下面是可用于自定义安装的可用选项的完整列表。  

| 参数           | 描述                                          |
| -------------- | --------------------------------------------- |
| `TZ`           | 设置时区，默认值： `Asia/Shanghai`            |
| `MOON_PORT`    | zerotier-moon使用端口，默认值： `9993`        |
| `IPV4_ADDRESS` | moon主机的公网ipv4地址，默认值： `无`（必填） |
| `IPV6_ADDRESS` | moon主机的公网ipv6地址，默认值： `无`         |

### 开放的端口
| 范围       | 描述                                                       |
| ---------- | ---------------------------------------------------------- |
| `9993/udp` | zerotier-moon使用端口,默认值。如修改默认端口则为修改后的值 |

### 数据卷
下面的目录或文件用于配置，并且可以映射为持久存储。

| 目录      | 描述                                      |
| --------- | ----------------------------------------- |
| `/var/lib/zerotier-one` | zerotier-one配置文件夹 |
## docker-compose.yml
```yml
version: '3'
services:
  zerotier-one:
    image: hushunxu/zerotier-one:latest
    container_name: zerotier-one
    restart: always
    cap_add:
      - NET_ADMIN
      - SYS_ADMIN
    devices:
      - "/dev/net/tun:/dev/net/tun"
    environment:
      - IPV4_ADDRESS=192.168.10.1 #moon主机的公网ipv4地址
    ports:
      - "9993:9993/udp"
    volumes:
      - /zerotier-one:/var/lib/zerotier-one
```

