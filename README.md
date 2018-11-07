工程结构：
hades-exeshell-server - 执行shell接口服务
  - api - 对外接口
          -- bottle.py python web 框架文件
          -- MonitorExeShellServer.py 对外提供执行shell接口 ☆
              --- /hades/monitor/agent/ 监控服务状态接口
              --- /restartServer 重启服务接口
          -- startup.sh 启动MonitorExeShellServer服务脚本        
  - common - 公共组件
                     -- __init__.py package的标识
                     -- exeshell.py 执行shell工具
                     -- Logger.py 日志组件
                     -- sysPath.py 获取执行脚本上级目录                  
  - bin - 重启/停止脚本
          -- restart.sh 重启脚本
          -- shutdown.sh 停止脚本    
  - bashserver - 存储bash脚本（子工程）
                        -- restartHadesServer.sh 重启服务公共脚本
                        -- startHadesServer.sh 启动服务公共脚本
                        -- stopHadesServer.sh 停止服务公共脚本
                        -- template 存储脚本模板
                                             -- restart.sh 重启模板
                                             -- start.sh 启动模板
                                             -- stop.sh 停止模板
                        -- ops-server.sh 根据ops-server.properties配置手动启动/停止/重启服务（可选）
                        -- conf 存储配置文件
                                   -- ops-server.properties 配置服务文件（可选）
  - logs 存储日志文件
  
注意事项：
1. MonitorExeShellServer.bash_server ☆
    配置bash脚本所在服务器位置
    格式：
          远程目录：
              bash_server = "ssh 127.0.0.33 /data/jmap/"
          本地目录：（即hades-exeshell-server和bashserver在同一机器）
              bash_server = "/data/jmap/" 
2. MonitorExeShellServer.bash_restart
    配置bash脚本全名称
    格式：bash_restart = "restartHadesServer.sh"
3. MonitorExeShellServer.server_port
    配置服务端口号
    格式：server_port = 7025
4. hades-exeshell-server所在服务必须能够ssh(免密登录)到bashserver所在服务 ☆
5. bashserver所在服务能够ssh到各个实例所在服务 ☆
6. 建议hades-exeshell-server和bashserver部署到同一机器，减少ssh次数同时方便部署
