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
                 device):

