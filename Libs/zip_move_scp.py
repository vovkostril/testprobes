import random
import os
import shutil
import glob
from paramiko import SSHClient
import paramiko
from scp import SCPClient
import os
from datetime import datetime

# for moving results
def move_move(parent_dir, origin_dir, revision, name):

    # folder_random = "revision" + str(revision) + additional_text + "-" + str(0)
    new_one_dir = "revision" + str(revision) + name + "-" + str(0) + "/"

    new_dir = os.path.join(parent_dir, new_one_dir)
    
    if os.path.exists(new_dir):
#         os.mkdir(new_dir)
#     else:
        while os.path.exists(new_dir):
            iind = new_dir.split("-")
            iind = iind[1].split(".")
            ind = iind[0]
            iiind = ind[0].split("/")
            n = int(iiind[0])
            if len(ind) > 2:
                n = str(ind[0]) + str(ind[1])
                n = int(n)
            new_one_dir = "revision" + str(revision) + name + "-" + str(n+1) + "/"
            new_dir = os.path.join(parent_dir, new_one_dir)
    
    os.mkdir(new_dir)

    print("Results moves: ")

    dest_folder = new_dir

    for files in glob.glob(parent_dir + '*.html'):
        print("test with html: ")
        if files:
            print(files + "---------------- was moved to ----------------" + new_dir)
            shutil.move(files, new_dir)
        
    for files in glob.glob(parent_dir + '*.xml'):
        print("test with xml: ")
        if files:
            print(files + "---------------- was moved to ----------------" + new_dir)
            shutil.move(files, new_dir)
        
    for files in glob.glob(parent_dir + '*.png'):
        print("test with scrinshotes: ")
        if files:
            print(files + "---------------- was moved to ----------------" + new_dir)
            shutil.move(files, new_dir)

    print("test with txt: ")

    for files in glob.glob(origin_dir + '*.txt'):
        if files:
            print(files + "---------------- was moved to ----------------" + new_dir)
            shutil.move(files, new_dir)
  
    print("Done movement block!")

    if os.path.exists(parent_dir+"browser"):
        for files in glob.glob(parent_dir+"browser"):
            print(files + "---------------- was moved to ----------------" + new_dir)
            shutil.move(files, new_dir)

    return dest_folder  

#after moving - zip
def zip_zip(parent_dir, dst_path_copy, additional_text, dir2):
    
    print("Start zipping...")

    e = datetime.now()
    new_zip = additional_text + "-latest-" + str(e.year) + "-" + str(e.month) + "-" + str(e.day)
    dir2 = dir2 + new_zip + ".zip"

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


