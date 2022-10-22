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
    if not "constr" in d:
        shutil.rmtree(d)
        
for f in files_list:
    if not "clean.py" in f and not "build.py" in f and not "quartus.build" in f:
        os.remove(f)