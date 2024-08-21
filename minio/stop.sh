#!/bin/bash

# 检查是否提供了参数，如果提供了参数，根据参数决定是否删除数据目录
REMOVE_DATA_DIR=no

if [ "$#" -eq 1 ]; then
    case "$1" in
        yes)
            REMOVE_DATA_DIR=yes
            ;;
        no)
            REMOVE_DATA_DIR=no
            ;;
        *)
            echo "Invalid argument. Usage: $0 [yes|no]"
            exit 1
            ;;
    esac
fi

# 容器名称，这里假设容器名称是固定的
CONTAINER_NAME="minio_local"

# 检查Docker Compose服务是否正在运行
if ! docker-compose ps | grep -q "minio"; then
    echo "MinIO service is not running."
    exit 2
fi

# 停止服务
echo "Stopping MinIO service..."
docker-compose down

# 如果用户选择删除数据目录，则执行删除操作
if [ "$REMOVE_DATA_DIR" == "yes" ]; then
    DATA_DIR="/opt/local/minio"

    if [ -d "$DATA_DIR" ]; then
        echo "Removing MinIO data directory: $DATA_DIR"
        rm -rf "$DATA_DIR"
        if [ $? -ne 0 ]; then
            echo "Failed to remove MinIO data directory."
            exit 3
        fi
    else
        echo "Data directory $DATA_DIR does not exist, no need to remove."
    fi
else
    echo "Data directory will not be removed."
fi

echo "Script completed."