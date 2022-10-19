import random
import os
import shutil
import sys
from time import sleep
from Libs import post_tests

# from robotframework import ExecutionResult

if __name__ == '__main__':

    p = 2  # TODO check statuses of PASS and return to gmail

    # post_tests.xml_output_counter(r".\Results\output.xml")

    # test_parse.test_parse().time_check("COM3", "9")
    # test_parse.parser().parse("COM3", "9   Ethernet   Ethernet     T32002.01...AH HP210670147     Operational")

    # p2 = os.system(r"robot -d Results .\Tests\new-lib.robot")

    # result_scra = test_scrapy.relax("http://192.168.0.3/index.htm")

    # p1 = probe_gui.first_view("http://192.168.0.3/index.htm")

    # p = os.system(r"robot -d Results .\Tests\web-th.robot")
    # p = os.system(r"robot -d Results .\Tests\th-web.robot")
    # p = os.system(r"robot -d Results .\Tests\test-ckick.robot")
    # p = os.system(r"robot -d Results .\Tests\test-locators.robot")
    # p = os.system(r"robot -d Results .\Tests\test-dnwp-elements.robot")
    # p = os.system(r"robot -d Results .\Tests\th-mylib.robot")

    if p:
        print("------------------ Tests Start ------------------\n")
        # p = os.system(r"robot -d Results .\Tests\th-mylib.robot")
        # p = os.system(r"robot -d Results .\Tests\button.robot")
        # p = os.system(r"robot -d Results .\Tests\hw-th.robot")
        # p = os.system(r"robot -d Results .\Tests\ptp.robot")
        # p = os.system(r"robot -d Results .\Tests\shut_ptp.robot")
        # p = os.system(r"robot -d Results .\Tests\tributary_inva.robot")
        intel = 0
        counter = 0
        folder_random = str(random.randint(2078, 5078))
        while intel < 5:
            print("Iteration: " + str(intel) + "\n")
            p = os.system(r"robot -d Results .\Tests\web-hw.robot")
            intel = intel + 1
            print(p)
            sleep(10)

            parent_dir = "C:/Users/anastasiia/PycharmProjects/tributary/Results/"

            # new_one_dir = r"test-out" + str(random.randint(1, 2078)) + "/"
            new_one_dir = r"prelast-results-" + folder_random + "-" + str(intel) + "/"

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
        # result = ExecutionResult(dest_folder + 'output.xml')
        # result.configure(stat_config={'suite_stat_level': 2,
        #                               'tag_stat_combine': 'tagANDanother'})
        # stats = result.statistics
        # print(stats.total.critical.failed)
        # print(stats.total.critical.passed)
        # print(stats.tags.combined[0].total)

    # else:
    # test_hw = tueth.sh_hw('COM3')
    # print(test_hw)
