import serial


def serial_test(comport, command):
    serial_connection = serial.Serial(comport, 115200, timeout=20)
    serial_connection.write(command)
    res = serial_connection.read(2)
    print(res)
    serial_connection.close()

