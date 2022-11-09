import random
import os
import shutil
from pathlib import Path
import sys
import glob
from time import sleep
from datetime import datetime
from Libs import post_tests
from getpass import getpass
from Libs import zip_move_scp


def iteration_test(p, c, parent_dir, origin_dir):

    print("------------------ Iteration Tests Start ------------------\n")

    intel = 0
    counter = 0
    while intel < c:
        print("Iteration: " + str(intel) + "\n")
        os.system(p)
        print(p)
        sleep(10)
        intel = intel + 1

        post_tests.xml_output_counter(parent_dir + r"output.xml")

        folder_random =  r"k-" + str(random.randint(1, 102078))

        new_one_dir = r"iterationtests-" + folder_random + "-" + "console-" + str(intel) + "/"

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

        print(counter)

