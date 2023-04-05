import os
import shutil
import glob
from datetime import datetime

def zip_zip(dir, files):
    
    print("Start zipping...")

    e = datetime.now()
    new_zip = "latest-" + str(e.year) + "-" + str(e.month) + "-" + str(e.day)
    dir2 = dir2 + new_zip + ".zip"

    shutil.make_archive(new_zip, "zip", files)

    if os.path.isfile(dir2):
        print("Zip ok!")
    else:
        print("Zip is not ok!")
