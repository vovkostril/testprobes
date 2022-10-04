import io
import re
import serial
import telnetlib


class ConnectorBase:
    def __init__(self,
                 ip,
                 host,
                 username,
                 password,
                 port,
                 device,
                 settings):
        self.settings = {
            "port": "COM3",
            "baudrate": 115200,
            "bytesize": serial.EIGHTBITS,
            "parity": serial.PARITY_NONE,
            "stopbits": serial.STOPBITS_ONE
        }

    def open_session(self):
        pass

    def read_session(self):
        pass

    def close_session(self):
        pass

