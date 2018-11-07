#!/bin/bash

#根据端口号查询对应的pid
pro_dir=$2
cd $pro_dir
PID=$(/usr/sbin/ss -n -t -l -p | grep :$1 | column -t | awk -F ',' '{print $(NF-1)}')
if [ -n "$PID" ]
then
	echo "服务PID: $PID, 将要kill"
	kill $PID
	sleep 5
	./startup.sh > /dev/null
	exit -1
else
	echo "将要重启服务，端口号: $1"
	./startup.sh > /dev/null
	exit -1
fi
