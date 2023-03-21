from datetime import datetime
import serial
from time import sleep

def serial_test(comport, command=None, filever=None):
    filever = 'versionser.txt'
    serial_connection = serial.Serial(port=comport, baudrate=115200, timeout=10)

    if serial_connection.isOpen():
        serial_connection.set_buffer_size(rx_size=12800, tx_size=12800)
        serial_connection.reset_input_buffer()
        serial_connection.write(b'\r')
        sleep(0.5)
        serial_connection.write(b'admin\r')
        sleep(0.5)
        serial_connection.write(b'\r')
        sleep(0.5)
        # version = b'do sh version\r'
        if "Wrong username or password!" in serial_connection.readline().decode():
            print("You are in checking block.")
            sleep(0.5)
            serial_connection.write(b'\r')
            serial_connection.write(b'admin\r')
            sleep(0.5)
        serial_connection.write(command)
        sleep(0.5)
        print("processing request...")

        with open(filever, 'w') as f:
            f.write(str(datetime.now()))
            while 1:
                r = serial_connection.readline().decode()
                print(r)
                f.write(r)
                sleep(0.2)
                if len(r) > 0:
                    r.rstrip()
                else:
                    break
    print("close connection.")
    print("done.")
    serial_connection.close()

