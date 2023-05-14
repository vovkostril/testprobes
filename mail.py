import os

os.system('mail -s "Automated Test Results First" anastasiia.vovkostril@dnwpartners.com -A test.zip -rlab-test@dnwpartners.com < mail.txt')
print("Done!")
