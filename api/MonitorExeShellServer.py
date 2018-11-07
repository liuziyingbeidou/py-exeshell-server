from bottle import route,run,template,request
from traceback import print_exc
import sys
sys.path.append("..")
from common import Logger,exeshell
logger = Logger.Logger()

bash_server = "ssh 10.10.6.33 /data/jmap/"
bash_restart = "restartHadesServer.sh"
server_port = 7025

@route('/hades/monitor/agent/')
def server_status():
    '''check server status'''
    return {"status":"200","message":"SUCCESS","timestamp":'null',"error":'null',"path":'null'}

def check_shell_param(ip,port,deploy_path):
    '''check request param is null''' 
    if(not ip or not port or not deploy_path):
        logger.info("request param: ip=%s port=%s deploy_path=%s" % (str(ip),str(port),str(deploy_path)))
        return True

def exe_command(ssh_cmd):
    exe_result = exeshell.execute_command(ssh_cmd)
    logger.info("return value: %s (%s)" %(str(exe_result),str(ssh_cmd)))
    return exe_result

@route('/restartServer',method='post')
def restart_server_api():
    '''exe bash'''
    ip = request.forms.get('ip')
    port = request.forms.get('port')
    deploy_path = request.forms.get('deploy_path')
    try:
        if check_shell_param(ip,port,deploy_path):
            return "fail: incomplete parameters"
        else:
            ssh_cmd = bash_server + bash_restart + " " + str(ip) +" " + str(port) +" " + str(deploy_path)
            exe_result = exe_command(ssh_cmd)
            if(exe_result == str(0)):
                return "ok"
            else:
                return "fail: command execution failed"
    except Exception, e:
        print_exc()
        return "fail: " + e.message

run(host='0.0.0.0', port=server_port)
