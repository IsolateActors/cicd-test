FROM node:18-alpine AS base

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

#设置npm源
RUN npm config set registry https://registry.npmmirror.com

# 安装 pnpm
RUN npm install -g pnpm

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
