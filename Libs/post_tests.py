import xml.etree.ElementTree as ET


def xml_output_counter(xml_file):
    result_pass = None
    tree = ET.parse(xml_file)
    root = tree.getroot()
    root1 = root[1]
    for x in root1.iter():
        if "Element 'stat' at" in str(x):
            result = x.attrib
            result_pass = result.get('pass')
            if result.get('fail') == "0":
                # print("PASS: " + result.get('pass'))
                # print("FAIL: " + result.get('fail'))
                break
    return result_pass
