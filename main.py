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
from Libs import zip_move_scp, iteration_test
# from robotframework import ExecutionResult

if __name__ == '__main__':

    pp = 15

    origin_dir  = "C:/Users/anastasiia/.vscode/tri/tributary/"
    parent_dir = "C:/Users/anastasiia/.vscode/tri/tributary/Results/"
    revision = str(2835)
    folder_random = str(random.randint(2078, 5078)) + "-" + "revision-" + str(revision)
    dst_path_copy = r"C:/Users/anastasiia/PycharmProjects/TestResults/"

    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    # start testing
    print("Result: ")

    if pp == None:
        p = r"robot -d Results .\Tests\iteration_test.robot"
        result = iteration_test.iteration_test(p=p, c=10, parent_dir=parent_dir, origin_dir=origin_dir)
        # result3 = zip_move_scp.scp_scp(result, "anastasiia", ip="192.168.10.31", password=getpass(), remote_folder="/home/anastasiia")


    if pp:
        p = os.system(r"robot -d Results .\Tests\latest.robot")
        print(p)

        result_from = post_tests.xml_output_counter(r".\Results\output.xml")
        result1 = zip_move_scp.move_move(parent_dir, origin_dir, revision)
        # sleep(5)
        # result2 = zip_move_scp.zip_zip(result1, dst_path_copy)
        # scp!
        # result3 = zip_move_scp.scp_scp(result2, "anastasiia", ip="192.168.10.31", password=getpass(), remote_folder="/home/anastasiia")





    # have tried the robot framework api for parse result - unsuccesful 
    # result = ExecutionResult(dest_folder + 'output.xml')
    # result.configure(stat_config={'suite_stat_level': 2,
    #                               'tag_stat_combine': 'tagANDanother'})
    # stats = result.statistics
    # print(stats.total.critical.failed)
    # print(stats.total.critical.passed)
    # print(stats.tags.combined[0].total)
