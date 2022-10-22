# -------------------------------------------------------------------------- #
# Packages
# -------------------------------------------------------------------------- #
import os, sys


# -------------------------------------------------------------------------- #
# Initialization
# -------------------------------------------------------------------------- #
sys.version_info
if sys.version_info[0] == 2:
    PYTHON_3 = False
elif sys.version_info[0] == 3:
    PYTHON_3 = True


# -------------------------------------------------------------------------- #
# Build routine
# -------------------------------------------------------------------------- #
if not PYTHON_3:
    TOP_LEVEL = raw_input("Enter top-level module: ")
elif PYTHON_3:
    TOP_LEVEL =     input("Enter top-level module: ")

os.system("quartus_sh -t quartus.build " + TOP_LEVEL)
