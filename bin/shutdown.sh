#!/bin/bash

cd ../api/
echo "正在结束MonitorExeShellServer服务..."
PID=`ps -ef|grep MonitorExeShellServer|grep -v grep |awk '{print $2}'`

if [ $? -eq 0 -a -n "$PID" ] ; then
        echo "开始正常结束进程$PID"
        kill $PID

        sleep 10

        NEW_PID=`ps -ef|grep MonitorExeShellServer|grep -v grep |awk '{print $2}'`

        if [ -n "$NEW_PID" ] ; then
      echo "未能正常结束，即将强制杀死进程..."
      kill -9 $PID
  fi
fi

