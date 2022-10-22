# -------------------------------------------------------------------------- #
# Packages
# -------------------------------------------------------------------------- #
import os, glob


# -------------------------------------------------------------------------- #
# Build routine
# -------------------------------------------------------------------------- #
MODELSIM_CMD = 'vsim -c -do "project new . proj; project open proj.mpf'

db_verilog_files_list  = glob.glob("../db/*.v")
db_sverilog_files_list = glob.glob("../db/*.sv")
tb_verilog_files_list  = glob.glob("../tb/*.v")
tb_sverilog_files_list = glob.glob("../tb/*.sv")

for file in db_verilog_files_list:
    MODELSIM_CMD += '; project addfile ' + file.replace("\\","/")
    
for file in db_sverilog_files_list:
    MODELSIM_CMD += '; project addfile ' + file.replace("\\","/")
    
for file in tb_verilog_files_list:
    MODELSIM_CMD += '; project addfile ' + file.replace("\\","/")
    
for file in tb_sverilog_files_list:
    MODELSIM_CMD += '; project addfile ' + file.replace("\\","/")
    
MODELSIM_CMD += '; quit"'

os.system(MODELSIM_CMD)
