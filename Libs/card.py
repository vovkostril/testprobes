from Libs import serial_ssh


def card(comport, slot, ip, serial=True):
    command = ["no hw slot " + slot]
    if serial:
        result = serial_ssh.send_command(comport, command)
    else:
        result = serial_ssh.execute_cmd(command[0], ip)
    return result


def from_cmd(comport, ip, serial=True):
    command = ["do sh hw"]
    if serial:
        result = serial_ssh.send_command(comport, command)
    else:
        result = serial_ssh.execute_cmd(command[0], ip)
    return result
