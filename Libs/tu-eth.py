import serial_ssh


def sh_hw(comport):
    print("----------------------------------------------------")
    set_cmd = ["do sh hw"]
    serial_ssh.send_command(comport, set_cmd)
    print("----------------------------------------------------")
