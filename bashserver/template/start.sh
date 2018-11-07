#!/bin/bash

#项目部署目录
pro_dir=$2
cd $pro_dir
PID=$(/usr/sbin/ss -n -t -l -p | grep :$1 | column -t | awk -F ',' '{print $(NF-1)}')
if [ -n "$PID" ]
then
	echo "服务正在运行，PID: $PID"
else
	echo "将要重启服务，端口号: $1"
	./startup.sh > /dev/null
	exit 0
fi
