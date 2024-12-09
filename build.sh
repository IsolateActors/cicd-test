#!/bin/bash

# 备份重命名dev文件夹
mv /root/docker/html/dev /root/docker/html/dev-backup
# 备份重命名sit文件夹
# mv /root/docker/html/sit /root/docker/html/sit-backup

# 构建 Docker 镜像
docker build --build-arg ENVIRONMENT=dev -t hello-cicd .
# docker build --build-arg ENVIRONMENT=sit -t hello-cicd .

# 运行 Docker 容器
docker run -d \
  -p 18081:81 \
  # -p 18082:82 \
  -v /root/docker/nginx/logs:/var/log/nginx \
  -v /root/docker/html:/usr/share/nginx/html \
  hello-cicd
