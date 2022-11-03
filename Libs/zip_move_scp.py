import random
import os
import shutil
from pathlib import Path
import glob
from time import sleep
from paramiko import SSHClient
import paramiko
from scp import SCPClient
import subprocess
import os
from getpass import getpass
from datetime import datetime

# for moving results
def move_move(parent_dir, origin_dir):

        new_one_dir = r"LatestpowerandHw-" + str(random.randint(1, 2078)) + "/"

        new_dir = os.path.join(parent_dir, new_one_dir)
        if not os.path.exists(new_dir):
            os.mkdir(new_dir)


        old_locations = ["log.html",
                         "output.xml",
                         "report.html"]

        dest_folder = new_dir

        for file in old_locations:
            souse = parent_dir + file
            destination = dest_folder + file
            shutil.move(souse, destination)
            print("------------------------------------------")
            print(file + " was moved to " + destination)

        print("test with scrinshotes: ")

        for files in glob.glob(parent_dir + '*.png'):
            if files:
                print(files + " was moved to " + new_dir)
                shutil.move(files, new_dir)

        result_dir = origin_dir + "results.txt"
        pw_dir = origin_dir + "pw.txt"
        pwssh_dir = origin_dir + "sshpower.txt"
        versionserial = origin_dir + "versionser.txt"
        outputfile = origin_dir + "output.txt"

        if not os.path.exists(result_dir):
            print("there is no: " + result_dir)
        else:
            shutil.move(result_dir, dest_folder)
            print(result_dir + " was moved to " + dest_folder)
            print("Results also were moved!")

        if not os.path.exists(pw_dir):
            print("there is no: " + pw_dir)
        else:
            shutil.move(pw_dir, dest_folder)
            print(pw_dir + " was moved to " + dest_folder)

        if not os.path.exists(pwssh_dir):
            print("there is no: " + pwssh_dir)
        else:
            shutil.move(pwssh_dir, dest_folder)
            print(pwssh_dir + " was moved to " + dest_folder)

        if not os.path.exists(outputfile):
            print("there is no: " + outputfile)
        else:
            shutil.move(outputfile, dest_folder)
            print(outputfile + " was moved to " + dest_folder)

        if not os.path.exists(versionserial):
            print("there is no: " + versionserial)
        else:
            print("File for console output exitst. Continue...")
            shutil.move(versionserial, dest_folder)
            print("serial output was moved: " + dest_folder)
  
        print("Done movement block!")
        return dest_folder  

#after moving - zip
def zip_zip(parent_dir, dst_path_copy):
    
    print("Start zipping...")

    e = datetime.now()
    new_zip = str(random.randint(5809, 9078)) + "-latest-" + str(e.year) + "-" + str(e.month) + "-" + str(e.day)
    dir2 = "C:/Users/anastasiia/.vscode/tri/tributary/" + new_zip + ".zip"

    shutil.make_archive(new_zip, "zip", parent_dir)

    if os.path.isfile(dir2):
        print("Zip ok!")
    else:
        print("Zip is not ok!")

    shutil.move(dir2, dst_path_copy)
    print('Moved zip. ' + dst_path_copy + new_zip)
    result = dst_path_copy + new_zip + ".zip"
    print(result)
    shutil.rmtree(parent_dir)
    print("Done zip block!")
    return result

#after moves and zip - scp to testautomatisation server
def paramico_scp(file, user, ip, password, remote_folder):
    ssh = SSHClient()
    # ssh.load_system_host_keys()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=ip, username=user, password=password, timeout=5, allow_agent=False,look_for_keys=False)
    scp = SCPClient(ssh.get_transport())
    scp.put(file, remote_folder)
    

def scp_scp(file_scp, user, ip, password, remote_folder):
    print("start scp block\n")

    if not os.path.exists(file_scp):
        with open(file_scp, 'w') as f:
            f.write(str(datetime.now()) + "Nastya Mowed.")
            print("Was created the file.")
    else:
        print("File for scp exitst. Continue...")
    
    print("------------------------- Start transfering -------------------------")
    paramico_scp(file_scp, user, ip, password, remote_folder)
    print("------------------------- Stop transfering -------------------------")
    # scp_moves.scp_transfer(path_file, file, user, ip, password, remote_folder)


