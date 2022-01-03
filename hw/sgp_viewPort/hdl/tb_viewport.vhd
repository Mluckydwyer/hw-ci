--------------------------------------------------------------------------------
-- Jacob Betsworth
-- Department of Electrical And Computer Engineering
-- Iowa State University
-- 02/19/2021
--------------------------------------------------------------------------------
-- tb_viewport.vhd
--------------------------------------------------------------------------------
-- Description: Test bench for viewport
--              
-- Notes:
--------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library std;
use std.env.stop;
library work;
use work.tb_axi_helper.all;

entity tb_viewport is
    generic(gCLK_HPER : time := 50 ns);
end tb_viewport;

architecture behavioral of tb_viewport is
    constant cCLK_PER : time := gCLK_HPER * 2;
    
    component sgp_viewPort is

		generic (
			-- Parameters of AXI-Lite slave interface
			C_S_AXI_DATA_WIDTH	: integer	:= 32;
			C_S_AXI_ADDR_WIDTH	: integer	:= 10;
			
			-- Parameters for output vertex attribute stream
			C_NUM_VERTEX_ATTRIB : integer := 4
		);

		port (ACLK	: in	std_logic;
			ARESETN	: in	std_logic;

			-- Ports of AXI-Lite slave interface
			s_axi_lite_awaddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
			s_axi_lite_awprot	: in std_logic_vector(2 downto 0);
			s_axi_lite_awvalid	: in std_logic;
			s_axi_lite_awready	: out std_logic;
			s_axi_lite_wdata	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
			s_axi_lite_wstrb	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
			s_axi_lite_wvalid	: in std_logic;
			s_axi_lite_wready	: out std_logic;
			s_axi_lite_bresp	: out std_logic_vector(1 downto 0);
			s_axi_lite_bvalid	: out std_logic;
			s_axi_lite_bready	: in std_logic;
			s_axi_lite_araddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
			s_axi_lite_arprot	: in std_logic_vector(2 downto 0);
			s_axi_lite_arvalid	: in std_logic;
			s_axi_lite_arready	: out std_logic;
			s_axi_lite_rdata	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
			s_axi_lite_rresp	: out std_logic_vector(1 downto 0);
			s_axi_lite_rvalid	: out std_logic;
			s_axi_lite_rready	: in std_logic;        


			-- AXIS slave interface
			S_AXIS_TREADY	: out	std_logic;
			S_AXIS_TDATA	: in	std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
			S_AXIS_TLAST	: in	std_logic;
			S_AXIS_TVALID	: in	std_logic;

			-- AXIS master interface
			M_AXIS_TVALID	: out	std_logic;
			M_AXIS_TDATA	: out	std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
			M_AXIS_TLAST	: out	std_logic;
			M_AXIS_TREADY	: in	std_logic);

		attribute SIGIS : string; 
		attribute SIGIS of ACLK : signal is "Clk"; 

    end component;


    signal s_CLK    : std_logic;
    signal s_rst    : std_logic;

	-- Ports of AXI-Lite slave interface
	signal tb_s_axi_lite_awaddr		:  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal tb_s_axi_lite_awprot		:  std_logic_vector(2 downto 0);
	signal tb_s_axi_lite_awvalid	:  std_logic;
	signal tb_s_axi_lite_awready	:  std_logic;
	signal tb_s_axi_lite_wdata		:  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal tb_s_axi_lite_wstrb		:  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
	signal tb_s_axi_lite_wvalid		:  std_logic;
	signal tb_s_axi_lite_wready		:  std_logic;
	signal tb_s_axi_lite_bresp		:  std_logic_vector(1 downto 0);
	signal tb_s_axi_lite_bvalid		:  std_logic;
	signal tb_s_axi_lite_bready		:  std_logic;
	signal tb_s_axi_lite_araddr		:  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal tb_s_axi_lite_arprot		:  std_logic_vector(2 downto 0);
	signal tb_s_axi_lite_arvalid	:  std_logic;
	signal tb_s_axi_lite_arready	:  std_logic;
	signal tb_s_axi_lite_rdata		:  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal tb_s_axi_lite_rresp		:  std_logic_vector(1 downto 0);
	signal tb_s_axi_lite_rvalid		:  std_logic;
	signal tb_s_axi_lite_rready		:  std_logic;        

	-- AXIS slave interface
	signal tb_S_AXIS_TREADY	: 	std_logic;
	signal tb_S_AXIS_TDATA	: 	std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
	signal tb_S_AXIS_TLAST	: 	std_logic;
	signal tb_S_AXIS_TVALID	: 	std_logic;

	-- AXIS master interface
	signal tb_M_AXIS_TVALID	: 	std_logic;
	signal tb_M_AXIS_TDATA	: 	std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
	signal tb_M_AXIS_TLAST	: 	std_logic;
	signal tb_M_AXIS_TREADY	: 	std_logic;

    -- Testing signals
    signal s_testCount      : integer := 0;
    signal s_expected       : std_logic_vector(63 downto 0);
    signal test_diff        : std_logic_vector(63 downto 0);
    signal test_passed      : std_logic;

	signal  tb_t_axi_lite : t_axi_lite(
		aclk				=> s_CLK,
		aresetn				=> s_rst,
		s_axi_lite_awaddr	=> tb_s_axi_lite_awaddr,
		s_axi_lite_awprot	=> tb_s_axi_lite_awprot,
		s_axi_lite_awvalid	=> tb_s_axi_lite_awvalid,
		s_axi_lite_awready	=> tb_s_axi_lite_awready,
		s_axi_lite_wdata	=> tb_s_axi_lite_wdata,
		s_axi_lite_wstrb	=> tb_s_axi_lite_wstrb,
		s_axi_lite_wvalid	=> tb_s_axi_lite_wvalid,
		s_axi_lite_wready	=> tb_s_axi_lite_wready,
		s_axi_lite_bresp	=> tb_s_axi_lite_bresp,
		s_axi_lite_bvalid	=> tb_s_axi_lite_bvalid,
		s_axi_lite_bready	=> tb_s_axi_lite_bready,
		s_axi_lite_araddr	=> tb_s_axi_lite_araddr,
		s_axi_lite_arprot	=> tb_s_axi_lite_arprot,
		s_axi_lite_arvalid	=> tb_s_axi_lite_arvalid,
		s_axi_lite_arready	=> tb_s_axi_lite_arready,
		s_axi_lite_rdata	=> tb_s_axi_lite_rdata,
		s_axi_lite_rresp	=> tb_s_axi_lite_rresp,
		s_axi_lite_rvalid	=> tb_s_axi_lite_rvalid,
		s_axi_lite_rready	=> tb_s_axi_lite_rready);

	signal tb_t_axi 		: t_axi;
	signal s_AXIS_out       : t_axi_stream_out;
    signal s_AXIS_data      : t_axi_stream_data(1 downto 0);
    signal s_data0	        : std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
    signal s_data1	        : std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);

begin

	TM: sgp_viewPort
	port map(ACLK	=>s_CLK,
			ARESETN	=>s_rst,

			-- Ports of AXI-Lite slave interface
			s_axi_lite_awaddr	=>tb_s_axi_lite_awaddr,
			s_axi_lite_awprot	=>tb_s_axi_lite_awprot,
			s_axi_lite_awvalid	=>tb_s_axi_lite_awvalid,
			s_axi_lite_awready	=>tb_s_axi_lite_awready,
			s_axi_lite_wdata	=>tb_s_axi_lite_wdata,
			s_axi_lite_wstrb	=>tb_s_axi_lite_wstrb,
			s_axi_lite_wvalid	=>tb_s_axi_lite_wvalid,
			s_axi_lite_wready	=>tb_s_axi_lite_wready,
			s_axi_lite_bresp	=>tb_s_axi_lite_bresp,
			s_axi_lite_bvalid	=>tb_s_axi_lite_bvalid,
			s_axi_lite_bready	=>tb_s_axi_lite_bready,
			s_axi_lite_araddr	=>tb_s_axi_lite_araddr,
			s_axi_lite_arprot	=>tb_s_axi_lite_arprot,
			s_axi_lite_arvalid	=>tb_s_axi_lite_arvalid,
			s_axi_lite_arready	=>tb_s_axi_lite_arready,
			s_axi_lite_rdata	=>tb_s_axi_lite_rdata,
			s_axi_lite_rresp	=>tb_s_axi_lite_rresp,
			s_axi_lite_rvalid	=>tb_s_axi_lite_rvalid,
			s_axi_lite_rready	=>tb_s_axi_lite_rready,        


			-- AXIS slave interface
			S_AXIS_TREADY	=>tb_S_AXIS_TREADY,
			S_AXIS_TDATA	=>tb_S_AXIS_TDATA,
			S_AXIS_TLAST	=>tb_S_AXIS_TLAST,
			S_AXIS_TVALID	=>tb_S_AXIS_TVALID,

			-- AXIS master interface
			M_AXIS_TVALID	=>tb_M_AXIS_TVALID,
			M_AXIS_TDATA	=>tb_M_AXIS_TDATA,
			M_AXIS_TLAST	=>tb_M_AXIS_TLAST,
			M_AXIS_TREADY	=>tb_M_AXIS_TREADY);


    P_CLK: process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TB: process
    begin
	
		--Test Format
		--s_rst <= '1';
		--tb_S_AXIS_TDATA	 <= --512 bits
		--tb_S_AXIS_TLAST	 <= --1 bit
		--tb_S_AXIS_TVALID   <= --1 bit
		--tb_M_AXIS_TREADY 	 <= --1 bit
		--wait for s_CLK;
	
		tb_S_AXIS_TDATA <= s_AXIS_out.s_axis_tdata;
        tb_S_AXIS_TLAST <= s_AXIS_out.s_axis_tlast;
        tb_S_AXIS_TVALID <= s_AXIS_out.s_axis_tvalid;
		
		s_CLK <= s_AXIS_in.aclk;
        s_rst <= s_AXIS_in.aresetn;
        s_AXIS_in.s_axis_tready <= tb_AXIS_TREADY;
		
		-- RESET
        s_rst <= '1';
        wait for cCLK_PER*2;
        s_rst <= '0';
        wait for cCLK_PER*2;
		
		
		
		
    end process;
end behavioral;
