# Makefile

# defaults
SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl
VHDL_SOURCES += $(PWD)/../src/*.vhd
# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = kitt_leds
# MODULE is the basename of the Python test file
MODULE = kitt_tb
# Simulator arguments
SIM_ARGS=--wave=wave.ghw -gg_leds=8
# SIM_ARGS=--wave=wave.vcd -gg_leds=8
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim