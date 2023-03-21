import time
import os
import sys
import serial_ssh

class shut_nocard:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.read = None
        self.serial = None
        self.ssh = None

    def read_serial(self):
        pass

    def open_serials(self):
        pass

    def shut_down_port(self, kera, port):
        print("---------------------------- TEST SHUT on %s ----------------------------" % port)
        shut_set = ["int " + port, "shutdown", "exit", "do sh int " + port + " status"]
        serial_ssh.send_command(kera, shut_set)
        test_holdover = serial_ssh.send_command(kera, ["do sh ptp 0 slave"])
        return test_holdover

    def up_down_port(self, kera, port):
        print("---------------------------- TEST UP on %s ----------------------------" % port)
        shut_set = ["int " + port, "no shutdown", "exit", "do sh int " + port + " status"]
        serial_ssh.send_command(kera, shut_set)
        time.sleep(20)
        test_locked = serial_ssh.send_command(kera, ["do sh ptp 0 slave"])
        return test_locked

    def test_shutdown_port(self, kera, port):

        self.shut_down_port(kera, port)  # think!
        time.sleep(35)
        self.up_down_port(kera, port)
        time.sleep(30)

        guest = serial_ssh.send_command(kera, ["do sh ptp 0 slave"])  # could be a problem with ssh connector
        time.sleep(20)
        print(guest)

        try:
            # guest = self.ssh.send("sh ptp 0 slave")
            # guest = self.ssh.send("do sh ptp 0 slave")  # could be a problem with ssh connector
            time.sleep(5)
            # print(guest)

            self.disconnect()
            # return guest
        except:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            frame = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            # return exc_type, frame, exc_tb.tb_lineno
        return guest

    def test_conn(self):
        pass

    def active(self):
        pass

    def disconnect(self):
        pass
