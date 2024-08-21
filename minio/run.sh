#!/bin/bash

# 定义MinIO数据目录
MINIO_DATA_DIR="/usr/local/minio"

# 检查目录是否存在
if [ ! -d "$MINIO_DATA_DIR" ]; then
    # 目录不存在，尝试创建它
    echo "Directory $MINIO_DATA_DIR does not exist. Attempting to create it..."
    mkdir -p "$MINIO_DATA_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to create directory $MINIO_DATA_DIR"
        exit 1
    fi
fi

# 运行Docker Compose
docker-compose up -d