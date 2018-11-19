#!/bin/bash

echo "端口号：$$1"
#根据端口号查询对应的pid
PID=$(/usr/sbin/ss -n -t -l -p | grep :$1 | column -t | awk -F ',' '{print $(NF-1)}')
echo "进程号：$PID"
if [ -n "$PID" ]
then
	echo "服务PID: $PID, 将要kill"
	kill -9 $PID
	exit -1
else
	echo "找不到要停止的服务，端口号: $1"
	exit -1
fi
