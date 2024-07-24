# 进一步制作镜像，让镜像支持API
FROM soulteary/docker-codeformer:latest

# 设置工作目录
WORKDIR /app/CodeFormer

# 安装 supervisor
RUN apt-get update && apt-get install -y supervisor  && \
    pip install cog -i https://mirrors.aliyun.com/pypi/simple/ && \
    cp /app/CodeFormer/web-demos/replicate/* /app/CodeFormer && \
    sed -i '1,5d' /app/CodeFormer/cog.yaml

# 复制项目文件到工作目录
COPY weights /app/CodeFormer/weights


# 复制 supervisord 配置文件
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 启动 supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
