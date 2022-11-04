import random
import os
import shutil
from pathlib import Path
import sys
import glob
from time import sleep
from datetime import datetime
from Libs import scp_moves
from Libs import post_tests
from getpass import getpass
from Libs import zip_move_scp
# from robotframework import ExecutionResult

if __name__ == '__main__':
    
    pp = None  # TODO check statuses of PASS and return to gmail
    d = None
    t = None
    c = None
    r = 15

    # result2 = "C:/Users/anastasiia/PycharmProjects/TestResults/6612-latest-2022-11-3.zip"
    # result3 = zip_move_scp.scp_scp(result2, "anastasiia", ip="192.168.10.31", password=getpass(), remote_folder="/home/anastasiia")

    origin_dir  = "C:/Users/anastasiia/.vscode/tri/tributary/"
    parent_dir = "C:/Users/anastasiia/.vscode/tri/tributary/Results/"
    folder_random = str(random.randint(2078, 5078))
    dst_path_copy = r"C:/Users/anastasiia/PycharmProjects/TestResults/"

    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    print("Result: ")

    # start testing

    if r:
        # p = os.system(r"robot -d Results .\Tests\power_cards.robot")
        # p = os.system(r"robot -d Results .\Tests\power_cards_hw_cards.robot")
        p = os.system(r"robot -d Results .\Tests\latest.robot")
        print(p)

        result_from = post_tests.xml_output_counter(r".\Results\output.xml")
        result1 = zip_move_scp.move_move(parent_dir, origin_dir)
        print(result1)
        sleep(5)
        result2 = zip_move_scp.zip_zip(result1, dst_path_copy)
        # scp!
        result3 = zip_move_scp.scp_scp(result2, "anastasiia", ip="192.168.10.31", password=getpass(), remote_folder="/home/anastasiia")

    if d:
        p = os.system(r"robot -d Results .\Tests\power_cards.robot")
        print(p)

        new_one_dir = r"Power-" + str(random.randint(1, 2078)) + "/"
        new_dir = os.path.join(parent_dir, new_one_dir)
        if not os.path.exists(new_dir):
            os.mkdir(new_dir)

        result_from = post_tests.xml_output_counter(r".\Results\output.xml")

        old_locations = ["log.html",
                         "output.xml",
                         "report.html"]

        print('\nNamed with wildcard ?:')

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

        result_dir = r"C:/Users/anastasiia/.vscode/tri/tributary/results.txt"
        # result_dir = r"C:/Users/anastasiia/PycharmProjects/tributary/"
        shutil.move(result_dir, dest_folder)
        print(result_dir + " was moved to " + dest_folder)
        print("Results also were moved!")
        pw_dir = r"C:/Users/anastasiia/.vscode/tri/tributary/pw.txt"
        pwssh_dir = r"C:/Users/anastasiia/.vscode/tri/tributary/sshpower.txt"
        shutil.move(pw_dir, dest_folder)
        shutil.move(pwssh_dir, dest_folder)
        print(pw_dir + " was moved to " + dest_folder)
        print(pwssh_dir + " was moved to " + dest_folder)
        print("Pw CLI also was moved!")
        print("Finish!")    


    if pp:
        print("------------------ Tests Start ------------------\n")
        intel = 0
        counter = 0
        while intel < 2:
            print("Iteration: " + str(intel) + "\n")
            p = os.system(r"robot -d Results .\Tests\console_pretest.robot")
            intel = intel + 1
            print(p)
            sleep(10)

            # new_one_dir = r"test-out" + str(random.randint(1, 2078)) + "/"
            # new_one_dir = r"pretest-" + folder_random + "-" + "iteration-" + str(intel) + "/"
            new_one_dir = r"pretest-" + folder_random + "-" + "console-" + str(intel) + "/"

            new_dir = os.path.join(parent_dir, new_one_dir)

            if not os.path.exists(new_dir):
                os.mkdir(new_dir)

            # print("Moved everything ones, please, delete or comment this code!")
            # for fila_name in os.listdir(parent_dir):
            #     s = parent_dir + fila_name
            #     d = new_dir + fila_name

            #     if os.path.isfile(s):
            #         shutil.move(s, d)
            #         print("Moved! --- " + s)
            result_from = post_tests.xml_output_counter(r".\Results\output.xml")


            if os.path.isfile('filename.txt'):
                print("File exist")
            else:
                print("File not exist")

            old_locations = ["log.html",
                             "output.xml",
                             "report.html"]

            print('\nNamed with wildcard ?:')
            for files in glob.glob(parent_dir + '?.png'):
                print(files)

            dest_folder = new_dir

            for file in old_locations:
                souse = parent_dir + file
                destination = dest_folder + file
                shutil.move(souse, destination)
                print("------------------------------------------")
                print(file + " was moved to " + destination)

            print("------------------------------------------")
            print(counter)


    # result = ExecutionResult(dest_folder + 'output.xml')
    # result.configure(stat_config={'suite_stat_level': 2,
    #                               'tag_stat_combine': 'tagANDanother'})
    # stats = result.statistics
    # print(stats.total.critical.failed)
    # print(stats.total.critical.passed)
    # print(stats.tags.combined[0].total)
