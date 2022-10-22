# -------------------------------------------------------------------------- #
# Packages
# -------------------------------------------------------------------------- #
import os, glob, shutil


# -------------------------------------------------------------------------- #
# Clean routine
# -------------------------------------------------------------------------- #
dirs_list  = glob.glob("./*/")
files_list = glob.glob("./*.*")

for d in dirs_list:
    if not "tv" in d:
        shutil.rmtree(d)
        
for f in files_list:
    if not "clean.py" in f and not "build.py" in f:
        os.remove(f)
        
if os.path.exists("transcript"):
    os.remove("transcript")
