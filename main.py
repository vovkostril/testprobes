import random
import os
import shutil

if __name__ == '__main__':
    print('PyCharm')

    # p = os.system(r"robot -d Results .\Tests\web-th.robot")
    # p = os.system(r"robot -d Results .\Tests\th-web.robot")
    p = os.system(r"robot -d Results .\Tests\test-ckick.robot")
    print(p)

    parent_dir = "C:/Users/anastasiia/PycharmProjects/tributary/Results/"

    # new_one_dir = r"test-out" + str(random.randint(1, 2078)) + "/"
    new_one_dir = r"test-th" + str(random.randint(1, 2078)) + "/"

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
