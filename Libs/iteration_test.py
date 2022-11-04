


def iteration_test():
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

