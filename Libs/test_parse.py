import time
# from time import process_time
from datetime import datetime
import card, serial_ssh, pyserial_test


class test_parse:
    def __init__(self):
        self.cmd_set = ["do sh hw"]
        self.filefor = 'output.txt'
        self.filepower = 'pw.txt'
        self.filesshpower = 'sshpower.txt'

    def parse_noport(self, port, slot):
        with open(self.filefor, 'w') as f:
            f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))

        counter = 0

        with open(self.filefor, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            certainline = str(slot) + "   Ethernet   Ethernet"
            print(certainline)
            for line in fp:
                counter += 1
                if certainline in line and "Operational" in line:
                    print(line)
                    print("\nOK")
                    return 1
            print("----------------------------------------------------------")

    def power_card_check(self, port, slot, active=True):
        with open(self.filepower, 'w') as f:
            # f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))
            f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))

        counter = 0

        with open(self.filepower, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            certainline = str(slot) + "   PWR"
            #                            "    17.D  - "
            print(certainline)
            for line in fp:
                counter += 1
                test_active = 0
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line and "Operational" in line:
                    if certainline in line and "Operational *" in line:
                        print("Active!")
                        test_active = 1
                    print(line)
                    print("\nOK")
                    return str(1 + test_active)
                    # print("Line{}: {}".format(counter, line.strip()))
                    # break
            print("----------------------------------------------------------")

    def ssh_card_status(self, ip, slot, active=True):
        with open(self.filesshpower, 'w') as f:
            # f.write(str(datetime.now()) + serial_ssh.send_command(port, self.cmd_set))
            # f.write(str(datetime.now()) + serial_ssh.execute_cmd(self.cmd_set[0], ip))
            f.write(str(datetime.now()) + str(serial_ssh.ssh_connect(host=ip, cmd=self.cmd_set[0])))

        counter = 0

        with open(self.filesshpower, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            certainline = str(slot) + "   PWR 48VBE  PWR 48VBE"
            print(certainline)
            for line in fp:
                counter += 1
                test_active = 0
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line: 
                    if active and "Operational" in line:
                        if certainline in line and "Operational *" in line:
                            print("Active!")
                            test_active = 1
                print(line)
                print("\nOK")
                return str(1 + test_active)

    # check times between processes
    def time_check(self, port, slot):
        result = None
        st = time.time()
        card.card(port, slot, serial=True, ip="192.168.0.4")
        time.sleep(10)
        if self.parse_noport(port, slot):
            result = "PASS"
        # self.parse(port)
        et = time.time()
        elapsed_time = et - st - 10
        print('Execution time:', elapsed_time, 'seconds')
        return result

    def reboot_after():
        pyserial_test.serial_test(comport="COM3", command="reload cold", filever="reboot.txt",)
