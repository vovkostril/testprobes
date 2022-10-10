import random
import os
import shutil
# import tueth
from Libs import probe_gui, test_scrapy

if __name__ == '__main__':

    p = 1
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
        # p = os.system(r"robot -d Results .\Tests\th-mylib.robot")
        # p = os.system(r"robot -d Results .\Tests\button.robot")
        # p = os.system(r"robot -d Results .\Tests\hw-th.robot")
        p = os.system(r"robot -d Results .\Tests\ptp.robot")
        print(p)

        parent_dir = "C:/Users/anastasiia/PycharmProjects/tributary/Results/"

        # new_one_dir = r"test-out" + str(random.randint(1, 2078)) + "/"
        new_one_dir = r"test-ptp-web-" + str(random.randint(1, 2078)) + "/"

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

    # else:
        # test_hw = tueth.sh_hw('COM3')
        # print(test_hw)
