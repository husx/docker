# elecV2P
一款基于 NodeJS，可通过 JS 修改网络请求，以及定时运行脚本或 SHELL 指令的网络工具。  
官方项目地址：https://github.com/elecV2/elecV2P  
自用elecV2P镜像，修复官方镜像时区问题，添加python运行环境，同时支持amd64;arm64v8;arm32v7，跟随官方代码更新，与官方镜像用法一致。每次更新版本后会自动复制自带示例文件至`/usr/local/app/efss/example`文件夹。  
本项目地址：https://github.com/husx/docker/tree/master/elecV2P

## 版本：

| 名称    | 版本      | 说明                  |
| :-----: | :-------: | :-------------------: |
| elecv2p | 3.4.1/latest | 跟随官方代码更新|
| elecv2p | 3.2.7 |S6更新为v2.2.0.3|
| elecv2p |     3.2      |              使用node:alpine作为基础包，增加py模块 |
| elecv2p | 3.1.8 | Docker 环境下默认以 pm2 的方式启动 |


## 配置

### 环境变量
下面是可用于自定义安装的可用选项的完整列表。  

| 参数 | 描述                            |
| :--: | ------------------------------- |
| `TZ` | 设置时区-默认： `Asia/Shanghai` |


### 开放的端口
| 范围 | 描述 |
| :-----:| ---- |
| `80` |后台管理界面。添加规则/JS 文件管理/定时任务管理/MITM 证书 等  |
| `8001` |ANYPROXY 代理端口 |
| `8002` |ANYPROXY 代理请求查看端口 |

### 数据卷
下面的目录用于配置，并且可以映射为持久存储。

| 目录      | 描述                                      |
| --------- | ----------------------------------------- |
| `/usr/local/app/script/JSFile` | 本地 JS 文件存储目录 |
| `/usr/local/app/script/Lists` | 当前任务列表，包含运行状态，会保存到 script/Lists/task.list 文件中 |
| `/usr/local/app/script/Store` | 常量/cookie 存储。所有存储值以文件的形式存储在 script/Store 目录 |
| `/usr/local/app/script/Shell` | Shell文件默认目录 |
| `/usr/local/app/rootCA` | 证书存放目录 |
| `/usr/local/app/efss` | elecV2P 文件管理系统，用于比较大的文件存储和读取。访问路径 - /efss |
| `/usr/local/app/logs` | 日志文件存放目录 |

## docker-compose.yml
```yml
version: '3'
services:
  elecv2p:
    image: hushunxu/elecv2p:latest
    container_name: elecv2p
    restart: always
    environment:
      - TZ=Asia/Shanghai
    ports:
      - "8830:80"
      - "8831:8001"
      - "8832:8002"
    volumes:
      - ./docker/elecv2p/JSFile:/usr/local/app/script/JSFile
      - ./docker/elecv2p/Lists:/usr/local/app/script/Lists
      - ./docker/elecv2p/Store:/usr/local/app/script/Store
      - ./docker/elecv2p/Shell:/usr/local/app/script/Shell
      - ./docker/elecv2p/rootCA:/usr/local/app/rootCA
      - ./docker/elecv2p/efss:/usr/local/app/efss
      - ./docker/elecv2p/logs:/usr/local/app/logs
```