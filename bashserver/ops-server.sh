#!/bin/bash
##
##1.选择操作类型
##2.选择服务
##脚本路径
#script_dir=/data/control_server_bash/
script_dir=/data/jmap/
echo ""
echo "-------------------------"
echo "     0.退出"
echo "     1.启动"
echo "     2.停止"
echo "     3.重启"
echo "-------------------------"

opr_list="0/1/2/3?"
opr_name="无"

while true
do
  read -p "请选择操作服务类型($opr_list)："  opr
  if [[ "$opr" -eq 0 ]]; then
     echo "选择的是 退出"
     exit
  elif [[ "$opr" -eq 1 ]]; then
     echo "选择的是 启动服务"
     opr_name="启动"
     break
  elif [[ "$opr" -eq 2 ]]; then
     echo "选择的是 停止服务"
     opr_name="停止"
     break
  elif [[ "$opr" -eq 3 ]]; then
     echo "选择的是 重启服务"
     opr_name="重启"
     break
  else
    echo "输入错误，请重新输入..."
  fi
done

#计数器
i=0
#脚本路径
cd $script_dir
path=$(pwd)
#输入服务名是否存在
ishas="N"

##echo "脚本目录：$path"

readproject(){
  #接收键盘输入服务名
  read -p "请输入服务名[回车-所有服务]：" in_project
}

readproject

#配置文件
ops_config=$path/conf/ops-server.properties
##echo "读取配置文件：$ops_config"

opr_server(){
  #$1 操作类型
  #首次读取配置文件行
  n=2
  while ((n<=$(cat $ops_config|grep -v ^$|wc -l)))
  do
    #echo "=== $(cat $ops_config|grep -v ^$|sed -n "${n}p")"
    ip=$(cat $ops_config|grep -v ^$|sed -n "${n}p"|awk '{print $1}')
    port=$(cat $ops_config|grep -v ^$|sed -n "${n}p"|awk '{print $2}')
    project_dir=$(cat $ops_config|grep -v ^$|sed -n "${n}p"|awk '{print $3}')
    if [[ $project_dir =~ $in_project ]] ;then
      ##包含
      echo "--------------------------------"
    else
      ##不包含
      ((n+=1))
      continue
    fi
    echo -e "\033[31m将要\033[0m $opr_name \033[31m$ip $port $project_dir\033[0m"
    read -p "是否继续(Y/N?)" in_is_continue
    is_continue=$(echo $in_is_continue | tr [a-z] [A-Z]) 
    if [ "$is_continue" = "Y" ]; then
      if [ "$1" -eq 1 ]; then
         source $path/startHadesServer.sh $ip $port $project_dir
         #echo "$project_dir"
      elif [ "$1" -eq 2 ]; then
         source $path/stopHadesServer.sh $ip $port $project_dir
         #echo "$project_dir"
      elif [ "$1" -eq 3 ]; then
         source $path/restartHadesServer.sh $ip $port $project_dir
         #echo "$project_dir"
      fi
      sleep 2
      echo "$opr_name $ip $port $project_dir (success)"
      echo "--------------------------------"
      sleep 1
    else
      echo -e "\033[33m放弃\033[0m $opr_name\033[33m $ip $port $project_dir\033[0m"
    fi
    ((n+=1))
  done
}

opr_server $opr
