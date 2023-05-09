# Design
create_design counter
add_design_file -V_2001 counter.v
set_top_module counter
add_constraint_file constraints.sdc

# Device target
#target_device GEMINI_10x8
target_device 1GE100

# Compilation
synthesize delay
pin_loc_assign_method free
packing
place
route
sta
bitstream 
