# TODO ping - for test, fpga, active/standby - from CLI for comparing
from Libs import serial_ssh, pyserial_test
from datetime import datetime
from time import sleep


class pre_test:
    def __init__(self):
        self.cmd_set = "sh version"
        self.filever = 'versionser.txt'
        self.port = "COM3"

    def parse(self):
        counter = 0
        pyserial_test.serial_test(self.port)
        with open(self.filever, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            check_lines = ["Software Version : CM Native CE R4.4", "Code Revision    : 2744", "FPGA2 Version    : 1"]
            certainline = check_lines[0]
            print(certainline)
            for line in fp:
                counter += 1
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line:
                    print(line)
                    print("\nOK")
                    return 1
                    # print("Line{}: {}".format(counter, line.strip()))
                    # break
            print("----------------------------------------------------------")


"""
        counter = 0
        checker = 0

        with open(self.filever, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            check_lines = ["Software Version : CM Native CE R4.4", "Code Revision    : 2744", "FPGA2 Version    : 1"]
            for line in fp:
                counter += 1
                print(line)
            # for line in fp:
            #     counter += 1
            #     if check_lines[0] or check_lines[1] or check_lines[2] in line:
            #         print(line)
            #         print("\nOK")
            #         checker += 1
            print("----------------------------------------------------------")



            for line in fp:
                counter += 1
                if check_lines[0] in line:
                    print(line)
                    print("OK")
                    checker += 1
                    break
            for line in fp:
                counter += 1
                if check_lines[1] in line:
                    print(line)
                    print("OK")
                    checker += 1
                    break
            for line in fp:
                counter += 1
                if check_lines[2] in line:
                    print(line)
                    print("OK")
                    checker += 1
                    break
            return checker
"""
