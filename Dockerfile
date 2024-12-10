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

RUN pnpm run build

# 使用 Nginx
FROM nginx:alpine

# 复制构建后的文件
COPY --from=base /app/dist /usr/share/nginx/html


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
