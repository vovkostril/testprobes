import serial_ssh


def sh_hw(comport):
    ret = None
    print("----------------------------------------------------")
    set_cmd = ["do sh hw"]
    result = serial_ssh.send_command(comport, set_cmd)
    for i in result:
        print(result)
    print("----------------------------------------------------")

    if 'Ethernet' in result:
        if 'Operational' in result:
            ret = "PASS"
    else:
        ret = "NOT PASS"
    return ret
