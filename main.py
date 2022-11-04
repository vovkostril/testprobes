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
        p = os.system(r"robot -d Results .\Tests\iteration_test.robot")
        print(p)

        result_from = post_tests.xml_output_counter(r".\Results\output.xml")
        result1 = zip_move_scp.move_move(parent_dir, origin_dir)
        # print(result1)
        # sleep(5)
        # result2 = zip_move_scp.zip_zip(result1, dst_path_copy)
        # scp!
        # result3 = zip_move_scp.scp_scp(result2, "anastasiia", ip="192.168.10.31", password=getpass(), remote_folder="/home/anastasiia")


    # result = ExecutionResult(dest_folder + 'output.xml')
    # result.configure(stat_config={'suite_stat_level': 2,
    #                               'tag_stat_combine': 'tagANDanother'})
    # stats = result.statistics
    # print(stats.total.critical.failed)
    # print(stats.total.critical.passed)
    # print(stats.tags.combined[0].total)
