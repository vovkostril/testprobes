import random
import os
import shutil
from pathlib import Path
import sys
import glob
from time import sleep
# from Libs import post_tests, serial_ssh, pyserial_test
# from Libs import pre_tests
from datetime import datetime

from Libs import post_tests

# from robotframework import ExecutionResult

if __name__ == '__main__':

    p = None  # TODO check statuses of PASS and return to gmail
    d = 1
    t = None
    c = None

    # result = pre_tests.pre_test().parse("COM3")
    # result = serial_ssh.send_command("COM3", ["do sh version"])
    print("result: \n")
    # result = pyserial_test.serial_test("COM3")
    # result = pre_tests.pre_test().parse("COM3")
    # result = pre_tests.pre_test().parse()
    # result = pre_tests.pre_test().parse()

    parent_dir = "C:/Users/anastasiia/PycharmProjects/tributary/Results/"
    folder_random = str(random.randint(2078, 5078))
    dst_path_copy = r"C:/Users/anastasiia/PycharmProjects/TestResults/"
    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    if p:
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
            # TODO new location for screenshots
            result_from = post_tests.xml_output_counter(r".\Results\output.xml")

            # if result_from == "7":
            #     print("OK!")
            #     counter = counter + 1

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

    if d:
        p = os.system(r"robot -d Results .\Tests\time.robot")
        print(p)

        new_one_dir = r"Web-" + str(random.randint(1, 2078)) + "/"
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
        # TODO new location for screenshots

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

        result_dir = r"C:/Users/anastasiia/PycharmProjects/tributary/"
        shutil.move(result_dir, dest_folder)
        print("Results also were moved!")
        print("Finish!")

    if t:
        p = os.system(r"robot -d Results .\Tests\console_pretest.robot")
        print(p)

        new_one_dir = r"Pretest-" + str(random.randint(1, 2078)) + "/"
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
        # TODO new location for screenshots
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

    if c:
        e = datetime.now()
        new_zip = str(random.randint(5809, 9078)) + "-latest-" + str(e.year) + "-" + str(e.month) + "-" + str(e.day)
        dir2 = "C:/Users/anastasiia/PycharmProjects/tributary/" + new_zip + ".zip"

        shutil.make_archive(new_zip, "zip", parent_dir)

        if os.path.isfile(dir2):
            print("ZIP OK")
        else:
            print("ZIP NOT OK!")

        shutil.move(dir2, dst_path_copy)
        print('MOVED ZIP!')
        shutil.rmtree(parent_dir)
        print("DONE!")

    # result = ExecutionResult(dest_folder + 'output.xml')
    # result.configure(stat_config={'suite_stat_level': 2,
    #                               'tag_stat_combine': 'tagANDanother'})
    # stats = result.statistics
    # print(stats.total.critical.failed)
    # print(stats.total.critical.passed)
    # print(stats.tags.combined[0].total)
