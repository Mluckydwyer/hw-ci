library ieee;
use ieee.std_logic_1164.all;

package tb_axi_helper is
	-- Parameters of AXI-Lite slave interface
	constant C_S_AXI_DATA_WIDTH	: integer	:= 32;
	constant C_S_AXI_ADDR_WIDTH	: integer	:= 10;

	-- Parameters of AXI master interface
	constant C_M_AXI_BURST_LEN	: integer	:= 16;
	constant C_M_AXI_ID_WIDTH	: integer	:= 4;
	constant C_M_AXI_ADDR_WIDTH	: integer	:= 32;
	constant C_M_AXI_DATA_WIDTH	: integer	:= 32;

	-- Testbench values
	constant gCLK_HPER 			: time 		:= 50 ns;
	constant cCLK_PER 			: time 		:= gCLK_HPER * 2;
	
	
	-- AXI-Lite Type
	type t_axi_lite is record
		aclk				: std_logic;
		aresetn				: std_logic;
		s_axi_lite_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_lite_awprot	: std_logic_vector(2 downto 0);
		s_axi_lite_awvalid	: std_logic;
		s_axi_lite_awready	: std_logic;
		s_axi_lite_wdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_lite_wstrb	: std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		s_axi_lite_wvalid	: std_logic;
		s_axi_lite_wready	: std_logic;
		s_axi_lite_bresp	: std_logic_vector(1 downto 0);
		s_axi_lite_bvalid	: std_logic;
		s_axi_lite_bready	: std_logic;
		s_axi_lite_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_lite_arprot	: std_logic_vector(2 downto 0);
		s_axi_lite_arvalid	: std_logic;
		s_axi_lite_arready	: std_logic;
		s_axi_lite_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_lite_rresp	: std_logic_vector(1 downto 0);
		s_axi_lite_rvalid	: std_logic;
		s_axi_lite_rready	: std_logic;   
	end record t_axi_lite;

	
	-- AXI-Stream Type
	type t_axi_stream is record
		aclk			: std_logic;
		aresetn			: std_logic;
		s_axis_tready	: std_logic;
		s_axis_tdata	: std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
		s_axis_tlast	: std_logic;
		s_axis_tvalid	: std_logic;
	end record t_axi_stream;
	
	type t_axi_stream_data is array (positive range<>) of std_logic_vector(C_NUM_VERTEX_ATTRIB*128-1 downto 0);
	
	
	-- AXI4-Full Type
	type t_axi is record
		aclk			: std_logic;
		aresetn			: std_logic;
		m_axi_awid		: std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_awaddr	: std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_awlen		: std_logic_vector(7 downto 0);
		m_axi_awsize	: std_logic_vector(2 downto 0);
		m_axi_awburst	: std_logic_vector(1 downto 0);
		m_axi_awlock	: std_logic;
		m_axi_awcache	: std_logic_vector(3 downto 0);
		m_axi_awprot	: std_logic_vector(2 downto 0);
		m_axi_awqos		: std_logic_vector(3 downto 0);
		m_axi_awvalid	: std_logic;
		m_axi_awready	: std_logic;
		m_axi_wdata	    : std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		m_axi_wstrb	    : std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		m_axi_wlast	    : std_logic;
		m_axi_wvalid	: std_logic;
		m_axi_wready	: std_logic;
		m_axi_bid	    : std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_bresp	    : std_logic_vector(1 downto 0);
		m_axi_bvalid	: std_logic;
		m_axi_bready	: std_logic;
		m_axi_arid	    : std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_araddr	: std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_arlen	    : std_logic_vector(7 downto 0);
		m_axi_arsize	: std_logic_vector(2 downto 0);
		m_axi_arburst	: std_logic_vector(1 downto 0);
		m_axi_arlock	: std_logic;
		m_axi_arcache	: std_logic_vector(3 downto 0);
		m_axi_arprot	: std_logic_vector(2 downto 0);
		m_axi_arqos	    : std_logic_vector(3 downto 0);
		m_axi_arvalid	: std_logic;
		m_axi_arready	: std_logic;
		m_axi_rid	    : std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_rdata	    : std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		m_axi_rresp	    : std_logic_vector(1 downto 0);
		m_axi_rlast	    : std_logic;
		m_axi_rvalid	: std_logic;
		m_axi_rready	: std_logic);
	end record t_axi;
	
	
	-- ~~~ Axi-Lite Functions/Procedures ~~~
	-- Write from master to slave on axi-lite bus
	procedure axi_lite_write(axi	: t_axi_lite,
							addr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0),
							data	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0),
							correct	: std_logic)
	begin
		axi.s_axi_lite_awaddr <= addr;
		axi.s_axi_lite_wdata <= data;
		axi.s_axi_lite_wstrb <= (others => '1');
		axi.s_axi_lite_awvalid <= '1';
		axi.s_axi_lite_wvalid <= '1';
		axi.s_axi_lite_bready <= '1';
		wait until ((axi.s_axi_lite_awready='1') and (axi.s_axi_lite_wready='1')) for cCLK_PER * 10;
		if ((axi.s_axi_lite_awready='0') or (axi.s_axi_lite_wready='0')) then
			correct <= '0';
			report "AXI Lite ready signals not correcly asserted";
			return;
		end if;
		
		axi.s_axi_lite_awaddr <= (others => '0');
		axi.s_axi_lite_wdata <= (others => '0');
		axi.s_axi_lite_wstrb <= (others => '0');
		axi.s_axi_lite_awvalid <= '0';
		axi.s_axi_lite_wvalid <= '0';
		wait until axi.s_axi_lite_bvalid='1' for for cCLK_PER * 10;
		if axi.s_axi_lite_bvalid='0' then
			correct <= '0';
			report "AXI Lite VALID signal not correcly asserted";
			return;
		end if;
		
		axi.s_axi_lite_bready <= '0';
		correct <= '1'
	end procedure axi_lite_write;
	
	
	-- ~~~ Axi-Stream Functions/Procedures ~~~
	-- Write to axi-stream bus from master to slave
	procedure axi_stream_write(axi	  : t_axi_stream,
							  data	  : t_axi_stream_data,
							  correct : std_logic)
	begin
		axi.s_axis_tvalid <= '1';
	
		wait until axi.s_axis_tready='1' for cCLK_PER * 10;
		if axi.s_axis_tready='0' then
			correct <= '0';
			report "AXI Stream ready signal not correcly asserted in time";
			return;
		end if;
		
		-- Send data across bus
		for I in data'LENGTH loop
			axi.s_axis_tdata <= data(I);
			
			-- Last Packet
			if I=(data'LENGTH - 1) then
				axi.s_axis_tlast <= '1';
			end if;
			
			-- Wait till slave is ready again
			if axi.s_axis_tready='0' then
				wait until axi.s_axis_tready='1' for cCLK_PER * 10;
				if axi.s_axis_tready='0' then
					correct <= '0';
					report "AXI Stream ready signal not correcly asserted in time";
					return;
				end if;
			else
				wait for cCLK_PER;
			end if;
		end loop;
		axi.s_axis_tvalid <= '0';
		axi.s_axis_tlast <= '0';
		axi.s_axis_tdata <= (others => '0');
		
	end procedure axi_lite_write;

end tb_axi_helper;