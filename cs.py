import csv
with open(r'C:\Users\Anastasia\Downloads\borg_rozstrochku_2023-03-01.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    for row in spamreader:
        print(', '.join(row))