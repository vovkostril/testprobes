from paramiko import SSHClient
import paramiko
from scp import SCPClient
import subprocess
import os
from getpass import getpass
from datetime import datetime

def scp_move(file, user, ip, remote_folder):
    print("start the process of transfering!...")
    p = subprocess.Popen(["scp", file, user + "@" + ip + ":" + remote_folder])
    os.waitpid(p.pid, 0)

def paramico_scp(file, user, ip, password, remote_folder):
    # print("start the process of transfering!...")
    ssh = SSHClient()
    # ssh.load_system_host_keys()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=ip, username=user, password=password, timeout=5, allow_agent=False,look_for_keys=False)
    scp = SCPClient(ssh.get_transport())
    scp.put(file, remote_folder)
    
def scp_transfer(file, user, ip, password, remote_folder):
    
    file_scp = "C:/Users/anastasiia/.vscode/tri/tributary/" + file

    if not os.path.exists(file_scp):
        with open(file_scp, 'w') as f:
            f.write(str(datetime.now()) + "Nastya Mowed.")
            print("Was created the file.")
    else:
        print("File for scp exitst. Continue...")
    
    print("------------------------- Start transfering -------------------------")
    result_scp = paramico_scp(file_scp, user, ip, password, remote_folder)
    print("------------------------- Stop transfering -------------------------")