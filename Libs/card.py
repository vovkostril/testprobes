import serial_ssh


def card(comport, slot):
    command = ["do no hw slot " + slot]
    result = serial_ssh.send_command(comport, command)
    return result
