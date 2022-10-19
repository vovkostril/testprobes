import xml.etree.ElementTree as ET


def xml_output_counter(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    root1 = root[1]
    print(root1)
    # root = ET.fromstring
    for x in root1.findall('tag'):
        print(x.text)

