import serial_ssh


def sh_hw(comport):
    ret = None
    ret2 = " 9   Ethernet   Ethernet"
    sourceFile = open('demo.txt', 'w')
    print("----------------------------------------------------")
    set_cmd = ["do sh hw"]
    result = serial_ssh.send_command(comport, set_cmd)
    print(result, file=sourceFile)
    sourceFile.close()
    with open('demo.txt') as f:
        # lines = f.readline()
        # lines = f.readlines()
        # [print(line) for line in f.readlines()]
        for line in f.readlines():
            if ret2 in line:
                print("PASS")
                ret = "PASS"
            else:
                ret = "NOT PASS"
    print("----------------------------------------------------")
    return ret


"""
    if 'Ethernet' in result:
        if 'Operational' in result:
            ret = "PASS"
    else:
        ret = "NOT PASS"
    return ret
"""
