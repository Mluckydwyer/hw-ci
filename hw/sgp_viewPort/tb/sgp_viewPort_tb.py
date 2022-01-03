from inspect import Parameter
import math
import os
import itertools
import logging
import os
from random import getrandbits
from remote_pdb import RemotePdb

from cocotbext.axi.axis import AxiStreamFrame

from cocotb_test.simulator import run
import pytest

import cocotb
from cocotb.clock import Clock
from cocotb.binary import BinaryValue
from cocotb.triggers import RisingEdge
from cocotb.regression import TestFactory
from cocotb.handle import SimHandleBase
from cocotb_bus.scoreboard import Scoreboard

from cocotbext.axi import AxiStreamBus, AxiStreamSource, AxiStreamSink, AxiStreamMonitor

NUM_SAMPLES = int(os.environ.get('NUM_SAMPLES', 3000))
DATA_WIDTH = int(cocotb.top.C_DATA_WIDTH)  # int(cocotb.parameters.C_DATA_WIDTH)
VHDL_SRC = ["adder_types.vhd", "basic_axi_adder.vhd"]
VERILOG_SRC = ["basic_axi_adder_wrapper.v"]


def gen_input(func=getrandbits):
    """Generate random value"""
    return func(DATA_WIDTH)


def gen_input_samples(num_samples=NUM_SAMPLES, func=getrandbits):
    """Generate random values to add togeather"""
    for _ in range(num_samples):
        yield gen_input(func)



class BasicAdderTB(object):
    """
    Checker for Basic Adder

    Args
        basic_adder_entity: handle to an instance of basic_adder
    """

    def __init__(self, basic_adder_entity: SimHandleBase):
        self.dut = basic_adder_entity
        #self.log = logging.getLogger("cocotb.tb")
        #self.log.setLevel(logging.INFO)
        self.clock = Clock(self.dut.aclk, 10, units='ns')
        cocotb.fork(self.clock.start())
        cocotb.fork(self.count_clocks())
        self.clock_count = 0

        self.axis_source_drv = AxiStreamSource(AxiStreamBus.from_prefix(self.dut, "s_axis"), self.dut.aclk, self.dut.aresetn, reset_active_level=False)
        # self.axis_source_mon = AxiStreamMonitor(AxiStreamBus.from_prefix(self.dut, "s_axis"), self.dut.aclk, self.dut.aresetn, reset_active_level=False)
        self.axis_sink_drv = AxiStreamSink(AxiStreamBus.from_prefix(self.dut, "m_axis"), self.dut.aclk, self.dut.aresetn, reset_active_level=False)
        
        # self.scoreboard = Scoreboard(self.dut)
        # self.scoreboard.add_interface()


    async def count_clocks(self):
        while True:
            await RisingEdge(self.dut.aclk)
            self.clock_count += 1


    async def reset_dut(self):
        self.dut.aresetn.value = 0
        for _ in range(3):
            await RisingEdge(self.dut.aclk)
        self.dut.aresetn.value = 1


    # Inital value and setup
    async def dut_setup(self):
        self.dut._log.info("Initialize and reset model")
        
        # Reset DUT
        await self.reset_dut()


    # Basic Axi Adder FModel
    def fmodel(self, a, b, data_width):
        # Sanity check, make sure we didn't done mess up
        if a > 2**data_width - 1:
            raise OverflowError(f'A: {a} overflows {data_width} bit representaion during fmodel calculation')
        if b > 2**data_width - 1:
            raise OverflowError(f'B: {b} overflows {data_width} bit representaion during fmodel calculation')

        # Perform the add
        add_val = a + b
        c = BinaryValue(value=add_val, n_bits=data_width+1, bigEndian=False)

        # Grab the parts we want
        exp_c = ((1 << data_width) - 1) & c.integer
        # exp_c = BinaryValue(value=add_val, n_bits=data_width, bigEndian=False).integer
        exp_carry = 1 if c.binstr[0] == '1' else 0
        self.dut._log.info(f'FModel:\tA + B = C\t=>\t{a} + {b} = {exp_c} (Carry: {exp_carry})')

        return {
            'c': exp_c,
            'carry': exp_carry
        }

    def compareResult(self, dut, hdl_result, exp):
        data_width = int(dut.C_DATA_WIDTH)  # Get parameterized data width
        dut._log.info(f'HDL Result: {hdl_result.tdata}\n')
        actual_c = (hdl_result.tdata[0] >> 1) & ((1 << data_width) - 1)  # grab bits of output bit vector for computed value
        actual_carry = hdl_result.tdata[0] & 1  # Grab carry bit
        actual = {
            'c': actual_c,
            'carry': actual_carry
        }
        dut._log.info(f'@{self.clock_count} Expected: {exp}\t\tActual: {actual}\n')
        
        # Perform assertions that actual == expected and log it accordingly
        if exp['c'] != actual['c']: dut._log.error(f'@{self.clock_count} \'c\' Does not match fmodel Expected: {exp["c"]}\t\tActual: {actual["c"]}\n')
        if exp['carry'] != actual['carry']: dut._log.error(f'@{self.clock_count} \'carry\' Does not match fmodel Expected: {exp["carry"]}\t\tActual: {actual["carry"]}\n')
        assert exp['c'] == actual['c'] and exp['carry'] == actual['carry'], f'@{self.clock_count} FModel does not match HDL output - Expected: {exp}\t\tActual: {actual}\n'


# CocoTB Test factory. Used for generating tests
# if cocotb.SIM_NAME:
#     factory = TestFactory(run_test)
#     factory.add_option("payload_lengths", [size_list])
#     factory.add_option("payload_data", [incrementing_payload])
#     factory.add_option("idle_inserter", [None, cycle_pause])
#     factory.add_option("backpressure_inserter", [None, cycle_pause])
#     factory.generate_tests()