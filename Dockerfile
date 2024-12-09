FROM node:18-alpine AS base

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

# 启用 corepack
RUN corepack enable

# 启用 pnpm
RUN corepack enable pnpm

# 安装依赖
RUN pnpm install

COPY . .

# 根据环境变量构建项目
ARG ENVIRONMENT
RUN pnpm run build:${ENVIRONMENT}

# 使用 Nginx
FROM nginx:alpine

# 复制构建后的文件
COPY --from=base /app/dist /usr/share/nginx/html/${ENVIRONMENT}

# 复制 Nginx 配置文件
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 81
EXPOSE 82

CMD ["nginx", "-g", "daemon off;"]
