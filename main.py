import os
from time import sleep
from Libs import post_tests
# from getpass import getpass
from Libs import zip_move_scp
import webbrowser
# from robotframework import ExecutionResult
#
#
def test(revision, p, additional_text):
    origin_dir  = "C:/Users/anastasiia/.vscode/tri/tributary/"
    parent_dir = "C:/Users/anastasiia/.vscode/tri/tributary/Results/"
    # C:\Users\anastasiia\.vscode\mac_table
    revision = str(revision)

    # dst_path_copy = r"C:/Users/anastasiia/PycharmProjects/TestResults/"

    if not os.path.exists(parent_dir):
        os.mkdir(parent_dir)

    # start testing
    print("Result: ")

    print(p)

    post_tests.xml_output_counter(r".\Results\output.xml")
    sleep(5)
    # webbrowser.open(r".\Results\log.html")
    result1 = zip_move_scp.move_move(parent_dir, origin_dir, revision, additional_text)
    sleep(5)
    webbrowser.open(result1+"log.html")
    #
# format robot file
if __name__ == '__main__':
    #
    test(revision=1111, p=os.system(r"robot -d Results .\Tests\playw.robot"), additional_text="vlan")

# add the mail sending process
