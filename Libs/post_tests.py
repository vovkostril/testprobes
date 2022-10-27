import xml.etree.ElementTree as ET
from datetime import datetime


def xml_output_counter(xml_file):
    result = None
    tree = ET.parse(xml_file)
    root = tree.getroot()
    root1 = root[1]
    for x in root1.iter():
        # print(str(x.attrib) + " + " + str(x.tag) + str(x))
        if "Element 'stat' at " in str(x):
            print("-------------------------------------")
            result = x.attrib
            print("Here is the result of the test run: " + str(result))
            print("-------------------------------------")
            break
    with open('results.txt', 'w') as f:
        f.write(str(datetime.now()) + '\n' + "Here is the result of the test run: " + str(result))
    return result
