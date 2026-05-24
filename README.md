# Online Bookstore

一个基于 Spring Boot + Vue 2 的网上书店系统，包含用户端商城和后台管理端。项目采用前后端分离结构，后端提供 REST API，前端通过 Vue CLI 开发服务器代理到后端接口。

## 功能概览

用户端：

- 用户注册、登录、个人信息维护、头像上传
- 图书浏览、分类筛选、图书详情查看
- 购物车添加、删除、结算
- 收货地址管理
- 订单查看、确认收货、退款申请
- 客服反馈提交
- 支付宝沙箱支付相关接口

管理端：

- 用户管理
- 图书管理、上下架、图书详情维护
- 订单管理、发货处理
- 退款订单管理
- 用户反馈管理
- 订单数据图表统计

## 技术栈

后端：

- JDK 17
- Spring Boot 2.7.1
- MyBatis / MyBatis-Plus 3.5.3
- MySQL 8
- Redis
- JWT
- Lombok
- Alipay SDK
- Aliyun OSS SDK

前端：

- Vue 2.6.14
- Vue Router 3.5.1
- Vuex 3.6.2
- Vue CLI 5
- Element UI 2.15.13
- Axios
- ECharts
- WangEditor

## 项目结构

```text
online-bookstore/
|-- bookshop.sql                 # 根目录数据库初始化脚本
|-- code/
|   |-- springboot/              # Spring Boot 后端
|   |   |-- pom.xml
|   |   `-- src/main/
|   |       |-- java/com/lifeng/springboot/
|   |       |   |-- RunApp.java  # 后端启动类
|   |       |   |-- common/      # 公共配置、拦截器、JWT、支付/OSS 配置
|   |       |   |-- controller/  # 接口控制器
|   |       |   |-- entity/      # 实体类
|   |       |   |-- mapper/      # MyBatis Mapper
|   |       |   |-- service/     # 业务层
|   |       |   `-- utils/       # 工具类
|   |       `-- resources/
|   |           |-- application.yaml # 后端配置
|   |           |-- files/       # 本地图片资源
|   |           `-- *.sql        # 其他数据库脚本备份
|   `-- vue/                     # Vue 前端
|       |-- package.json
|       |-- vue.config.js        # 前端端口和代理配置
|       `-- src/
|           |-- router/
|           |-- utils/
|           |-- views/manage/    # 管理端页面
|           `-- views/shop/      # 用户端商城页面
`-- docker-compose.yml           # Docker 配置文件，当前本地开发不依赖它
```

## 本地环境要求

- JDK 17
- Maven 3.6+
- Node.js 16+
- MySQL 8
- Redis

## 数据库与 Redis 配置

后端当前读取的配置文件是：

```text
code/springboot/src/main/resources/application.yaml
```

当前默认配置：

```yaml
server:
  port: 9090

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/springboot-vue?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false&serverTimezone=GMT%2b8
    username: root
    password: 21045312
  redis:
    host: 192.168.242.131
    port: 6379
    password: 21045312
```

如果你的 MySQL 或 Redis 地址、端口、密码不同，需要先修改 `application.yaml`。

初始化数据库：

```sql
CREATE DATABASE `springboot-vue` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

然后导入根目录脚本：

```bash
mysql -u root -p springboot-vue < bookshop.sql
```

## 本地启动

先启动后端：

```bash
cd code/springboot
mvn spring-boot:run
```

后端默认地址：

```text
http://localhost:9090
```

注意：后端没有配置根路径页面，直接访问 `http://localhost:9090/` 返回 404 是正常的。可以用下面的接口验证后端是否正常：

```text
http://localhost:9090/item?pageNum=1&pageSize=5
```

再启动前端：

```bash
cd code/vue
npm install
npm run serve
```

前端实际开发地址：

```text
http://localhost:9876/
```

前端请求统一使用 `/api` 前缀，`code/vue/vue.config.js` 会把 `/api` 代理到：

```text
http://localhost:9090/
```

## 页面入口

- 用户端登录页：`http://localhost:9876/login`
- 用户端商城页：`http://localhost:9876/shop`
- 管理端登录页：`http://localhost:9876/manageLogin`
- 管理端首页：`http://localhost:9876/home`

Vue Router 使用 `history` 模式，本地开发请通过 `npm run serve` 访问，不要直接打开 HTML 文件。

## 默认账号

数据库脚本中包含以下测试账号：

| 账号 | 密码 | 角色 |
| --- | --- | --- |
| admin | 123 | 管理员 |
| 21045312 | 21045312 | 管理员 |
| 111 | 111 | 普通用户 |
| 123 | 123 | 普通用户 |
| 222 | 222 | 普通用户 |
| 444 | 444 | 普通用户 |

说明：数据库中保存的是 MD5 后的密码，登录时后端会对输入密码做 MD5 后再比对。

## 打包构建

后端打包：

```bash
cd code/springboot
mvn clean package -DskipTests
```

前端打包：

```bash
cd code/vue
npm run build
```

前端构建产物输出到：

```text
code/vue/dist/
```

## 常见问题

### 前端端口是多少？

当前不是 `8080`，而是 `9876`，配置在 `code/vue/vue.config.js`。

### 后端端口是多少？

当前是 `9090`，配置在 `code/springboot/src/main/resources/application.yaml`。

### 为什么访问后端根路径是 404？

后端只提供接口，没有配置根路径页面。访问 `/item?pageNum=1&pageSize=5` 这类接口即可验证后端状态。

### 前端请求为什么都走 `/api`？

`code/vue/src/utils/request.js` 中统一设置了 `baseURL: '/api'`，开发环境下由 `vue.config.js` 代理到后端 `http://localhost:9090/`。页面里写接口时不要再手动加 `/api`。

### 支付宝和 OSS 怎么配置？

仓库中已有沙箱/示例配置项。实际使用时请在 `application.yaml` 中替换为自己的支付宝沙箱、回调地址和 OSS 参数，不要使用生产密钥直接提交到仓库。
