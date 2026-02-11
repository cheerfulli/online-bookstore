# 📚 在线书店系统 (Online Bookstore)

一个基于 **Spring Boot + Vue** 的前后端分离在线书店电商系统，支持用户注册登录、图书浏览、购物车、订单管理、支付宝支付等完整电商功能。

## ✨ 功能特性

### 📖 用户端功能
- **用户管理**：注册、登录、个人信息管理、头像上传
- **图书浏览**：图书列表展示、分类筛选、图书详情查看
- **购物车**：添加商品、修改数量、删除商品
- **订单管理**：创建订单、订单列表、订单详情
- **在线支付**：支付宝沙箱支付
- **退款申请**：支持七天无理由退款等多种退款方式
- **地址管理**：收货地址的增删改查
- **客服反馈**：用户意见建议提交

### 🔧 管理端功能
- **用户管理**：用户列表、用户信息编辑
- **商品管理**：图书的增删改查、上下架管理
- **订单管理**：订单列表、订单状态管理
- **退款处理**：退款订单审核处理
- **建议管理**：查看用户反馈建议
- **数据统计**：订单数据可视化图表展示

## 🛠️ 技术栈

### 后端 (Backend)
| 技术 | 版本 | 说明 |
|------|------|------|
| Spring Boot | 2.7.1 | 基础框架 |
| MyBatis-Plus | 3.5.3 | ORM框架 |
| MySQL | 8.0 | 数据库 |
| Redis | - | 缓存 |
| JWT | 4.3.0 | 认证授权 |
| Alipay SDK | 4.22.110 | 支付宝支付 |
| Aliyun OSS | 3.15.1 | 文件存储 |
| Hutool | 5.7.3 | 工具类库 |
| Lombok | - | 简化代码 |

### 前端 (Frontend)
| 技术 | 版本 | 说明 |
|------|------|------|
| Vue | 2.6.14 | 前端框架 |
| Vue Router | 3.5.1 | 路由管理 |
| Vuex | 3.6.2 | 状态管理 |
| Element UI | 2.15.13 | UI组件库 |
| ECharts | 5.5.0 | 图表可视化 |
| WangEditor | 5.1.23 | 富文本编辑器 |

## 📁 项目结构

```
online-bookstore/
├── bookshop.sql                 # 数据库初始化脚本
├── code/
│   ├── springboot/              # 后端项目
│   │   ├── pom.xml              # Maven配置
│   │   └── src/
│   │       └── main/
│   │           ├── java/com/lifeng/springboot/
│   │           │   ├── RunApp.java           # 启动类
│   │           │   ├── common/               # 公共配置
│   │           │   ├── controller/           # 控制器
│   │           │   ├── entity/               # 实体类
│   │           │   ├── mapper/               # 数据访问层
│   │           │   ├── service/              # 服务层
│   │           │   └── utils/                # 工具类
│   │           └── resources/
│   │               └── application.yaml      # 应用配置
│   │
│   └── vue/                     # 前端项目
│       ├── package.json         # npm配置
│       ├── vue.config.js        # Vue配置
│       └── src/
│           ├── views/           # 页面组件
│           │   ├── shop/        # 用户端页面
│           │   └── manage/      # 管理端页面
│           ├── components/      # 公共组件
│           ├── router/          # 路由配置
│           ├── store/           # Vuex状态管理
│           └── utils/           # 工具函数
```

## 🚀 快速开始

### 环境要求

- **JDK** 17+
- **Maven** 3.6+
- **Node.js** 14+
- **MySQL** 8.0+
- **Redis** 6.0+

### 数据库配置

1. 创建数据库：
```sql
CREATE DATABASE `springboot-vue` CHARACTER SET utf8mb4;
```

2. 导入数据库脚本：
```sql
USE `springboot-vue`;
SOURCE bookshop.sql;
```

### 后端启动

1. 进入后端项目目录：
```bash
cd code/springboot
```

2. 修改配置文件 `src/main/resources/application.yaml`：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/springboot-vue?useUnicode=true&characterEncoding=UTF-8&serverTimezone=GMT%2b8
    username: your_username
    password: your_password
  redis:
    host: your_redis_host
    port: 6379
    password: your_redis_password
```

3. 运行项目：
```bash
mvn spring-boot:run
```

后端服务将在 `http://localhost:9090` 启动。

### 前端启动

1. 进入前端项目目录：
```bash
cd code/vue
```

2. 安装依赖：
```bash
npm install
```

3. 启动开发服务器：
```bash
npm run serve
```

前端服务将在 `http://localhost:8080` 启动。

### 构建部署

**前端构建：**
```bash
npm run build
```

**后端打包：**
```bash
mvn clean package -DskipTests
```

## 📷 功能截图

> 待添加

## 📊 数据库设计

| 表名 | 说明 |
|------|------|
| `user` | 用户信息表 |
| `item` | 图书商品表 |
| `item_detail` | 图书详情表 |
| `cart` | 购物车表 |
| `t_order` | 订单表 |
| `refund_order` | 退款订单表 |
| `address` | 收货地址表 |
| `user_advice` | 用户建议表 |

## 🔑 默认账号

| 账号 | 密码 | 角色 |
|------|------|------|
| admin | 123 | 管理员 |

## ⚙️ 配置说明

### 支付宝沙箱配置

本项目集成了支付宝沙箱支付功能，需要在 `application.yaml` 中配置：

```yaml
alipay:
  appId: your_app_id
  appPrivateKey: your_private_key
  alipayPublicKey: alipay_public_key
  notifyUrl: your_notify_url
```

> 注：使用支付宝沙箱环境进行测试，请前往 [支付宝开放平台](https://open.alipay.com/) 申请沙箱账号。

### 阿里云OSS配置

如需使用阿里云OSS存储图片，请配置相关参数。

## 📝 开发说明

- 后端采用 RESTful API 设计规范
- 使用 JWT 进行用户认证
- 前后端通过 JSON 格式进行数据交互
- 支持跨域访问

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！


## 🙏 致谢

感谢所有开源项目的贡献者！

---

⭐ 如果这个项目对你有帮助，请给一个 Star 支持一下！
