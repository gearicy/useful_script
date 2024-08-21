#!/bin/bash

# 检查是否提供了至少一个容器名称
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <container_name_1> [<container_name_2> ...]"
    exit 1
fi

# 循环遍历所有提供的容器名称
for container_name in "$@"; do
    # 检查容器是否存在
    echo "Checking for container: $container_name"
    container_id=$(docker ps -aq -f name=^/${container_name}$)

    if [ -z "$container_id" ]; then
        echo "Container with name $container_name does not exist or is not running."
        continue
    fi

    # 停止容器
    echo "Stopping container: $container_name"
    docker stop "$container_id"

    # 检查停止命令是否成功
    if [ $? -ne 0 ]; then
        echo "Failed to stop container: $container_name"
        continue
    fi

    # 删除容器
    echo "Removing container: $container_name"
    docker rm "$container_id"

    # 检查删除命令是否成功
    if [ $? -ne 0 ]; then
        echo "Failed to remove container: $container_name"
    fi
done

echo "Script completed."