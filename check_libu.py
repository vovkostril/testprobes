from conmaster import test_commands

test_commands.send_cmd(comport="COM3", host=None, cmd="do sh hw\r", file_name="checks_lib")