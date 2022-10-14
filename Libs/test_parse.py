import time
# from time import process_time
from datetime import datetime

from Libs import card
from Libs import serial_ssh


class test_parse:
    def __init__(self):
        self.cmd_set = ["do sh hw"]
        self.filefor = 'output.txt'

    def parse(self, port):
        with open(self.filefor, 'w') as f:
            f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))

        counter = 0

        with open(self.filefor, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            certainline = str(port) + "   Ethernet   Ethernet     T32002.01...AH HP210670147     Operational"
            print(certainline)
            for line in fp:
                counter += 1
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line:
                    if "Operational" in line:
                        print("OK")
                        return 1
                        # print("Line{}: {}".format(counter, line.strip()))
                        # break
            print("----------------------------------------------------------")

    def time_check(self, port, slot):
        result = None
        st = time.time()
        card.card(port, slot, serial=True, ip="192.168.0.4")
        time.sleep(10)
        if self.parse(port):
            result = "PASS"
        # self.parse(port)
        et = time.time()
        elapsed_time = et - st - 10
        print('Execution time:', elapsed_time, 'seconds')
        return result
