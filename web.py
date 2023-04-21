import os
from time import sleep
from Libs import post_tests
from Libs import zip_move_scp

def web_test(revision):
    origin_dir  = os.getcwd() + "/"
    parent_dir = origin_dir + "Web/"
    revision = str(revision)

    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    # start testing
    print("Result: ")

    # print(p)

    post_tests.xml_output_counter(parent_dir + "output.xml")
    sleep(5)
    result1 = zip_move_scp.move_move(parent_dir, origin_dir, revision, name="result")
    sleep(5)

