import os
from time import sleep
from Libs import post_tests
# from getpass import getpass
from Libs import zip_move_scp
import webbrowser

def web_test(revision, p):
    origin_dir  = os.getcwd() + "/"
    parent_dir = origin_dir + "Web/"
    revision = str(revision)

    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    # start testing
    print("Result: ")

    print(p)

    post_tests.xml_output_counter(parent_dir + "output.xml")
    sleep(5)
    result1 = zip_move_scp.move_move(parent_dir, origin_dir, revision, name="result")
    sleep(5)
    webbrowser.open(result1+"log.html")

web_test(revision=3060, p=os.system(r"robot -d Web .\Tests\playw.robot"))

#