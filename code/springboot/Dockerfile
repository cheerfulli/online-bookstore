# 多阶段构建 - 构建阶段
FROM maven:3.8.6-eclipse-temurin-17 AS builder

WORKDIR /app

# 复制 pom.xml 并下载依赖（利用 Docker 缓存）
COPY pom.xml .
RUN mvn dependency:go-offline -B

# 复制源代码并构建
COPY src ./src
RUN mvn clean package -DskipTests -B

# 运行阶段
FROM eclipse-temurin:17-jre

WORKDIR /app

# 安装 curl 用于健康检查
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 创建非 root 用户（Debian 语法）
RUN groupadd -r spring && useradd -r -g spring spring && \
    mkdir -p /app/uploads && \
    chown -R spring:spring /app && \
    chmod -R 755 /app/uploads
USER spring:spring

# 从构建阶段复制 jar 文件
COPY --from=builder --chown=spring:spring /app/target/*.jar app.jar

# 暴露端口
EXPOSE 9090

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:9090/actuator/health || exit 1

# 启动应用
ENTRYPOINT ["java", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:-prod}", \
  "-jar", \
  "app.jar"]
