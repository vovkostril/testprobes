# TODO ping - for test, fpga, active/standby - from CLI for comparing
# from Libs \
import pyserial_test
import serial_ssh

class pre_tests:
    def __init__(self):
        self.cmd_set = "sh version"
        self.filever = 'versionser.txt'
        self.fildo = 'reduconsole.txt'
        self.port = "COM3"

    def parse(self, port, swversion, code_revision, fpga):
        counter = 0
        checker = 0
        pyserial_test.serial_test(port, command=b'do sh version\r')
        with open(self.filever, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            check_lines = ["Version : " + swversion, "Revision    : " + code_revision, "FPGA Version   "
                                                                                                     " : " + fpga]
            certainline = check_lines[0]
            for line in fp:
                if counter == 0:
                    print("DAY TIME" + line)
                counter += 1
                # print("Line{}: {}".format(counter, line.strip()))
                if certainline in line:
                    print(line)
                    print("\nOK")
                    checker += 1
                if check_lines[1] in line:
                    print(line)
                    print("\n2 OK")
                    checker += 1
                if check_lines[2] in line:
                    print(line)
                    print("\n3 OK")
                    checker += 1
            print("----------------------------------------------------------")

        

            return str(checker)

    def redu_test(self, port):
        counter = 0
        checker = 0
        pyserial_test.serial_test(port)
        with open(self.filever, 'r') as fp:
            print("----------------------------------------------------------")
            print(fp.readline())
            print("----------------------------------------------------------")
            for line in fp:
                counter += 1
