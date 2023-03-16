import os
from time import sleep
from Libs import post_tests
# from getpass import getpass
from Libs import zip_move_scp
import webbrowser
# from robotframework import ExecutionResult
#
#origin_dir  = "C:/Users/anastasiia/.vscode/tri/tributary/"
#parent_dir = "C:/Users/anastasiia/.vscode/tri/tributary/Results/"
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

    p = p

    print(p)

    post_tests.xml_output_counter(r".\Results\output.xml")
    sleep(5)
    # webbrowser.open(r".\Results\log.html")
    result1 = zip_move_scp.move_move(parent_dir, origin_dir, revision, additional_text)
    sleep(5)
    webbrowser.open(result1+"log.html")
    #
    # result2 = zip_move_scp.zip_zip(result1, dst_path_copy)

# format robot file
if __name__ == '__main__':
    #
    test(revision=3060, p=os.system(r"robot -d Results .\Tests\ptp.robot"), additional_text="ptp")

# add the mail sending process
