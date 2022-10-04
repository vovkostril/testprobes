import serial_ssh


def sh_hw(comport):
    ret = None
    state = ["Operational"]
    rets = ["9   Ethernet   Ethernet     T32002.01...AH HP210670147     " + state[0],
            "10   Ethernet   Ethernet     T32002.01...AB HP154160239     " + state[0]]
    sourceFile = open('log.txt', 'w')
    print("----------------------------------------------------")
    set_cmd = ["do sh hw"]
    result = serial_ssh.send_command(comport, set_cmd)
    print("----------------------------------------------------")
    print(result, file=sourceFile)
    sourceFile.close()
    with open('demo.txt') as f:
        # lines = f.readline()
        # lines = f.readlines()
        # [print(line) for line in f.readlines()]
        for line in f.readlines():
            if rets[0] and rets[1] in line:
                print("PASS!!")
                ret = "PASS"
#             else:
#                 ret = "NOT PASS"
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
