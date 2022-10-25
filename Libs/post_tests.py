import xml.etree.ElementTree as ET
from datetime import datetime


def xml_output_counter(xml_file):
    result = None
    result_pass = None
    tree = ET.parse(xml_file)
    root = tree.getroot()
    root1 = root[1]
    for x in root1.iter():
        if "Element 'stat' at" in str(x):
            result = x.attrib
            print(result)
            result_pass = result.get('pass')
            if result.get('fail') == "0":
                # print("PASS: " + result.get('pass'))
                # print("FAIL: " + result.get('fail'))
                break
    with open('results.txt', 'w') as f:
        f.write(str(datetime.now()) + str(result))
    return result_pass
