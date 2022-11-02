import random
import os
import shutil
from pathlib import Path
import glob
from time import sleep
from datetime import datetime
from getpass import getpass
from Libs import scp_moves

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
    
        shutil.move(result_dir, dest_folder)
        print(result_dir + " was moved to " + dest_folder)
        print("Results also were moved!")

        shutil.move(pw_dir, dest_folder)
        shutil.move(pwssh_dir, dest_folder)
        print(pw_dir + " was moved to " + dest_folder)
        print(pwssh_dir + " was moved to " + dest_folder)
  
        print("Done movement block!")    

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
    print('Moved zip. ' + dst_path_copy)
    shutil.rmtree(parent_dir)
    print("Done zip block!")

#after moves and zip - scp to testautomatisation server
def scp_scp(path_file, file, user, ip, password, remote_folder):
    print("start scp block\n")

    scp_moves.scp_transfer(path_file, file, user, ip, password, remote_folder)