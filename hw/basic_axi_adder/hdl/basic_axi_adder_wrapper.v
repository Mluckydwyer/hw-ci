// Verilog Wrapper for the Basic Axi Adder

// parameter C_DATA_WIDTH = 32;

module basic_axi_adder_wrapper #(
    parameter C_DATA_WIDTH=32,
    parameter TEST_ID=0
) (
    input                           aclk,
    input                           aresetn,

    // AXIS slave interface
    output                          s_axis_tready,
    input [C_DATA_WIDTH*2-1:0]     s_axis_tdata,
    input                          s_axis_tlast,
    input                          s_axis_tvalid,
    input [7:0]                    s_axis_tid,

    // AXIS master interface
    output                          m_axis_tvalis,
    output [C_DATA_WIDTH:0]         m_axis_tdata,
    output                          m_axis_tlast,
    input                          m_axis_tready,
    output [7:0]                   m_axis_tid
);

// CocoTB Wave Dump Macro
`ifdef COCOTB_SIM
initial begin
//   string file = "";
//   $sformat(file, "basic_axi_adder_wrapper.vcd");
//   $dumpfile(file);
  $dumpfile("basic_axi_adder_wrapper.vcd");
  $dumpvars;
  #10;
end
`endif

// wire [32:0] test;
//m_axis_tdata = test;

basic_axi_adder #(
    .C_DATA_WIDTH(C_DATA_WIDTH)
) i_basic_axi_adder (
    .ACLK(aclk),
    .ARESETN(aresetn),
    
    // Axi Stream In (Slave)
    .s_axis_tready(S_AXIS_TREADY),
    .S_AXIS_TDATA(s_axis_tdata),
    .S_AXIS_TLAST(s_axis_tlast),
    .S_AXIS_TVALID(s_axis_tvalid),
    .S_AXIS_TID(s_axis_tid),

    // Axi Stream Out (Master)
    .M_AXIS_TVALID(m_axis_tvalid),
    .M_AXIS_TDATA(m_axis_tdata),
    .M_AXIS_TLAST(m_axis_tlast),
    .m_axis_tready(M_AXIS_TREADY),
    .M_AXIS_TID(m_axis_tid)
);

endmodule