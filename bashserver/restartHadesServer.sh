#!/bin/bash

##$1 ip $2 port $3 部署目录
##重启服务

##脚本路径
script_dir=/data/jmap/
cd $script_dir
path=$(pwd)

ip=$1
port=$2
deploy_path=$3
native_ip="10.10.6.33"

if [ -z "$deploy_path" ]; then
  echo "---监控服务--实例部署目录为空---"
  exit
fi

if [ "$native_ip" == "$ip" ]; then
  echo "---分发脚本 开始---"
  mkdir -p $deploy_path/bin
  sleep 3
  cp -p ./template/{restart.sh,show-busy-java-threads} $deploy_path/bin/
  echo "---分发脚本 结束---"
  sleep 3
  echo "-----($ip:$port)重启服务_开始-----"
  $deploy_path/bin/restart.sh $port $deploy_path
  echo "-----($ip:$port)重启服务_结束-----"
else
  echo "---分发脚本 开始---"
  ssh $ip "mkdir -p $deploy_path/bin"
  sleep 3
  scp -p ./template/{restart.sh,show-busy-java-threads} $ip:$deploy_path/bin/
  echo "---分发脚本 结束---"
  sleep 3
  echo "-----($ip:$port)重启服务_开始-----"
  ssh $ip "source /etc/profile;$deploy_path/bin/restart.sh $port $deploy_path"
  echo "-----($ip:$port)重启服务_结束-----"
fi
