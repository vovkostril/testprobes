import serial_ssh


def card(comport, slot):
    command = ["no hw slot " + slot]
    result = serial_ssh.send_command(comport, command)
    return result


def from_cmd(comport):
    command = ["do sh hw"]
    result = serial_ssh.send_command(comport, command)
    return result
