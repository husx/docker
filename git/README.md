# 在docker容器中运行git
自用镜像，本镜像使用alpine（amd64;arm64v8;arm32v7），支持http、ssh方式使用git、及cron计划任务执行，方便备份自己和各位大佬的代码。  

本项目地址：https://github.com/husx/docker/tree/master/git

## 版本：

| 名称    | 版本      | 说明                  |
| :-----: | :-------: | :-------------------: |
| git | 1.03/latest | 增加自定义git设置文件 |
| git | 1.02 | 修正时区设置无效 |
| git | 1.01 | 增加git-subtree命令 |
| git | beta | 初版 |


## 配置

### 环境变量
下面是可用于自定义安装的可用选项的完整列表。  

| 参数    | 描述                                  |
| ------- | ------------------------------------- |
| `TZ`    | 设置时区-默认： `Asia/Shanghai`       |
| `NAME`  | git全局用户名-默认值： `无`（必填）   |
| `EMAIL` | git全局邮箱地址-默认值： `无`（必填） |

### 开放的端口
| 范围 | 描述 |
| ---- | ---- |
| 无   |      |

### 数据卷
下面的目录用于配置，并且可以映射为持久存储。

| 目录      | 描述                                      |
| --------- | ----------------------------------------- |
| root/.ssh    | SSH登录配置文件夹（为空时可自动生成密钥）（可选） |
| /git      | Git配置文件及工作目录                     |
| /crontabs | cron计划任务目录（可选）                      |
| /custom_config.sh | 自定义git设置文件，可覆盖环境变量`NAME`、`EMAIL`设置（可选） |
## docker-compose.yml
```yml
version: '3'
services:
  git:
    image: hushunxu/git
    container_name: name.git
    restart: always
    environment:
      - TZ=Asia/Shanghai
      - NAME=test #git全局用户名
      - EMAIL=test@test.com #git全局邮箱地址
    volumes:
      - ./git/ssh:/root/.ssh
      - ./git/git:/git
      - ./git/git/custom_config.sh:/custom_config.sh
      - ./git/crontabs:/crontabs
```