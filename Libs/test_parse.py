import time
# from time import process_time
from datetime import datetime
import card
import serial_ssh


class test_parse:
    def __init__(self):
        self.cmd_set = ["do sh hw"]
        self.filefor = 'output.txt'

    def parse(self, port, slot):
        with open(self.filefor, 'w') as f:
            f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))

        counter = 0

        with open(self.filefor, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            certainline = str(slot) + "   Ethernet   Ethernet"
            # certainline = str(slot) + "   Ethernet   Ethernet     T32002.01...AB HP154160239     Operational    37 " \
            #                            "    17.D  - "
            print(certainline)
            for line in fp:
                counter += 1
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line and "Operational" in line:
                    print(line)
                    print("\nOK")
                    return 1
                    # print("Line{}: {}".format(counter, line.strip()))
                    # break
            print("----------------------------------------------------------")

    def time_check(self, port, slot):
        result = None
        st = time.time()
        card.card(port, slot, serial=True, ip="192.168.0.4")
        time.sleep(10)
        if self.parse(port, slot):
            result = "PASS"
        # self.parse(port)
        et = time.time()
        elapsed_time = et - st - 10
        print('Execution time:', elapsed_time, 'seconds')
        return result
