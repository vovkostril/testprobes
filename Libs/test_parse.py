import serial_ssh, card
# from time import process_time
from datetime import datetime
import time


class test_parse:
    def __init__(self):
        self.cmd_set = ["do sh hw"]
        self.filefor = 'output.txt'
        self.certainline = "9   Ethernet   Ethernet     T32002.01...AH HP210670147     Operational"

    def parse(self, port):
        with open(self.filefor, 'w') as f:
            # serial_ssh.send_command(port, self.cmd_set)
            # f.close()
            f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))
            # print(f.closed)

        counter = 0

        with open(self.filefor, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            for line in fp:
                counter += 1
                # print("Line{}: {}".format(counter, line.strip()))
                if self.certainline in line:
                    print("FIND")
                    if "Operational" in line:
                        # print("Line{}: {}".format(counter, line.strip()))
                        break
            print("----------------------------------------------------------")

    def time_check(self, port, slot):
        st = time.time()
        card.card(port, slot)
        time.sleep(10)
        self.parse(port)
        et = time.time()
        elapsed_time = et - st - 10
        print('Execution time:', elapsed_time, 'seconds')
