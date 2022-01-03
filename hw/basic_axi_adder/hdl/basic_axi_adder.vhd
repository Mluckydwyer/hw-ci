-------------------------------------------------------------------------
-- Matthew Dwyer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- basic_axi_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a basic axi adder
-- adds two integer values togeather
--
-- NOTES:
-- 09/03/21 by MPD::Addapted to 482X for adder example
-------------------------------------------------------------------------

library work;
-- package types is new work.adder_types generic map (
--       C_DATA_WIDTH => 32
--     );
-- use work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity basic_axi_adder is
  generic(
      -- Parameters of Adder
      C_DATA_WIDTH : integer := 32
    );

	port (
    ACLK	: in	std_logic;
		ARESETN	: in	std_logic;       

    -- AXIS slave interface
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(C_DATA_WIDTH*2-1 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
    S_AXIS_TID    : in  std_logic_vector(7 downto 0);

    -- AXIS master interface
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(C_DATA_WIDTH downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic;
    M_AXIS_TID    : out  std_logic_vector(7 downto 0)
);

attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end basic_axi_adder;


architecture behavioral of basic_axi_adder is

    -- Intermediate values for viewport transformation. 
    signal s_a : signed(C_DATA_WIDTH-1 downto 0);
    signal s_b : signed(C_DATA_WIDTH-1 downto 0);
    signal s_result : std_logic_vector(C_DATA_WIDTH-1 downto 0);
    signal s_carry : std_logic;
    signal s_input : std_logic_vector(C_DATA_WIDTH*2-1 downto 0);
    signal s_output : std_logic_vector(C_DATA_WIDTH downto 0);
    signal s_add_out : signed(C_DATA_WIDTH downto 0);
    signal s_id_reg : std_logic_vector(7 downto 0);

    type STATE_TYPE is (WAIT_FOR_VALUES, ADD);
    signal state : STATE_TYPE;
    signal adder_debug : std_logic_vector(31 downto 0);

begin

    -- Interface signals
    M_AXIS_TDATA <= s_output;
    S_AXIS_TREADY <= '1' when state = WAIT_FOR_VALUES else
                     '0';

    -- Internal signals
    s_a <= signed(s_input(C_DATA_WIDTH*2-1 downto C_DATA_WIDTH));
    s_b <= signed(s_input(C_DATA_WIDTH-1 downto 0));

    -- Build output
    s_output(C_DATA_WIDTH downto 1) <= std_logic_vector(s_add_out(C_DATA_WIDTH-1 downto 0));
    -- s_output(C_DATA_WIDTH downto 1) <= std_logic_vector(s_result);
    s_output(0) <= std_logic(s_add_out(C_DATA_WIDTH));

    adder_debug <= x"A000000F";  -- Double checking sanity
   
   process (ACLK) is
   begin 
    if rising_edge(ACLK) then  -- Rising Edge

      -- Reset all the pipeline registers
      if ARESETN = '0' then  -- Reset
        state       <= WAIT_FOR_VALUES;
        s_input     <= (others => '0');
        s_result    <= (others => '0');

      else
        case state is  -- State
            -- Wait here until we receive values
            when WAIT_FOR_VALUES =>
                M_AXIS_TLAST <= '0';
                M_AXIS_TVALID <= '0';
                s_id_reg <= S_AXIS_TID;

                if (S_AXIS_TVALID = '1') then
                    s_input <= S_AXIS_TDATA;
                    state <= ADD;
                end if;
             when ADD =>
                s_add_out <= ('0' & s_a) + ('0' & s_b);
                M_AXIS_TLAST <= '1';
                M_AXIS_TVALID <= '1';
                M_AXIS_TID <= s_id_reg;
                
                if (M_AXIS_TREADY = '1') then
                    state <= WAIT_FOR_VALUES;
                end if;
             when others =>
                state <= WAIT_FOR_VALUES;
                -- Not really important, this case should never happen              
        end case;  -- State
      end if;  -- Reset

    end if;  -- Rising Edge
   end process;
end architecture behavioral;
