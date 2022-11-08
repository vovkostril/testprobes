import pyserial_test
from datetime import datetime

def clear_reboot(comport="COM3", consolefile="reboot.txt", command="reload cold"):

    with open(consolefile, 'w') as f:
        print("start rebooting...")
        f.write(str(datetime.now()) + str(pyserial_test.serial_test(comport=comport, command=command, filever=consolefile)))
