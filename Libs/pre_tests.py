# TODO ping - for test, fpga, active/standby - from CLI for comparing
from Libs import serial_ssh
from datetime import datetime
from time import sleep


class pre_test:
    def __init__(self):
        self.cmd_set = ["do sh version"]
        self.filever = 'version.txt'

    def parse(self, port):
        result = serial_ssh.send_command(port, self.cmd_set)
        with open(self.filever, 'w') as f:
            f.write(str(datetime.now()) + result)
            sleep(5)

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


"""
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
