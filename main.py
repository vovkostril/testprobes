import random
import os
import shutil
import sys
from time import sleep
from Libs import post_tests
import datetime

# from robotframework import ExecutionResult

if __name__ == '__main__':

    p = None  # TODO check statuses of PASS and return to gmail
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
            p = os.system(r"robot -d Results .\Tests\web-hw.robot")
            intel = intel + 1
            print(p)
            sleep(10)

            # new_one_dir = r"test-out" + str(random.randint(1, 2078)) + "/"
            new_one_dir = r"results-" + folder_random + "-" + "iteration-" + str(intel) + "/"

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
            if result_from == "7":
                print("OK!")
                counter = counter + 1
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

            print("------------------------------------------")
            print(counter)

    e = datetime.datetime.now()
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
