from paramiko import SSHClient
from scp import SCPClient
import subprocess
import os

def scp_move(file, user, ip, remote_folder):
    print("start the process of transfering!...")
    p = subprocess.Popen(["scp", file, user + "@" + ip + ":" + remote_folder])
    os.waitpid(p.pid, 0)

