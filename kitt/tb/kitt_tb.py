import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
  PERIOD = 10
  cocotb.start_soon(Clock(dut.clk_in, 1, units='ns').start())

  dut.reset_in = 0
  await Timer(20*PERIOD, units='ns')

  dut.reset_in = 1
  await Timer(20*PERIOD, units='ns')
  dut.reset_in = 0
  await Timer(20*PERIOD, units='ns')

    