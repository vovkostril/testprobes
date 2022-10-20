from datetime import datetime
import serial
from time import sleep


def serial_testof_test(comport):
    serial_connection = serial.Serial(port=comport, baudrate=115200, timeout=5)

    if serial_connection.isOpen():
        serial_connection.write(b'admin\r')
        sleep(0.5)
        serial_connection.write(b'\r')
        sleep(0.5)
        serial_connection.write(b'sh version\r')

        print("processing request...")

        while 1:
            res = serial_connection.readline().decode()
            print(res)
            if len(res) > 0:
                res.rstrip()
            else:
                break
    print("close connection.")
    serial_connection.close()


def serial_test(comport, command=None):
    filever = 'versionser.txt'
    serial_connection = serial.Serial(port=comport, baudrate=115200, timeout=5)

    if serial_connection.isOpen():
        serial_connection.write(b'admin\r')
        sleep(0.5)
        serial_connection.write(b'\r')
        sleep(0.5)
        serial_connection.write(b'sh version\r')

        print("processing request...")

        with open(filever, 'w') as f:
            f.write(str(datetime.now()))
            while 1:
                f.write(serial_connection.readline().decode())
                res = serial_connection.readline()
                if len(res) > 0:
                    res.rstrip()
                else:
                    break
    print("close connection.")
    serial_connection.close()

    # while 1:
    # print(serial_connection.read(500).decode())
    # res = serial_connection.readline()
    # dec = res.decode()
    # print(dec)
    # if len(res) > 0:
    #     res.rstrip()
    # else:
    #     break
    # with open(filever, 'w') as f:
    # f.write(str(datetime.now()) + serial_connection.read(10000).decode())
    # print("processing writing to file...")


"""
            res = serial_connection.read(10000)
            print("here is res: ")
            print(res.decode())
            if len(res) > 0:
                print(res.rstrip())
            else:
                break



    serial_connection.write(b'r')

    byte = serial_connection.read(20)

    print("bytes: ")
    print(byte)

    buffer = serial_connection.inWaiting()

    if buffer:
        print("in if")
        # data = serial_connection.read(10).decode('utf-8')
        data = byte + serial_connection.read(buffer)
        print("...processing")
        print(data)
        print("...again processing")

    print("out if")

    # serial_connection.close()

    # res = serial_connection.readline().decode('utf-8')
    # print(res)
"""
