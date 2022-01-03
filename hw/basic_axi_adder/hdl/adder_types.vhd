-------------------------------------------------------------------------
-- Matthew Dwyer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_types.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains some enumerated data and
-- type declarations for the basic adder. 
--
-- NOTES:
-- 09/03/21 by MPD::Design created.
-------------------------------------------------------------------------

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package adder_types is
    generic(
        -- Basic data attribute structures
        C_DATA_WIDTH     : natural
    );

    subtype value_t is signed(C_DATA_WIDTH-1 downto 0);
    subtype carry_t is std_logic;

    constant value_t_zero : value_t := (others => '0');      
    constant carry_t_zero : carry_t := '0';      


    type data_in_t is record
        a : value_t;
        b : value_t;
    end record;
    constant data_in_t_zero : data_in_t := (a => value_t_zero, b => value_t_zero);
    constant data_in_t_size : natural := C_DATA_WIDTH * 2;


    type data_out_t is record
        result : value_t;
        c : carry_t;
    end record;
    constant data_out_t_zero : data_out_t := (result => value_t_zero, c => carry_t_zero);
    constant data_out_t_size : natural := C_DATA_WIDTH + 1;


    -- #function get_input_a (i_data_in : in data_in_t) return value_t;
    -- function get_input_b (i_data_in : in data_in_t) return value_t;
    function build_data_out_t (i_value : in value_t; i_carry : in carry_t) return data_out_t;
	function data_out_to_stdlv (i_data_out : in data_out_t) return std_logic_vector;
	function data_in_to_stdlv (i_data_in : in data_in_t) return std_logic_vector;
	function stdlv_to_data_in (i_slv : in std_logic_vector(data_in_t_size-1 downto 0)) return data_in_t;

end package adder_types;

package body adder_types is

    -- Helper function: build data out packet for axi-stream interface
    function build_data_out_t (i_value : in value_t; i_carry : in carry_t) return data_out_t is
    variable tmpOutData : data_out_t;
    begin
        tmpOutData.result := i_value;
        tmpOutData.c      := i_carry;
        return tmpOutData;
    end;

    function data_out_to_stdlv (i_data_out : in data_out_t) return std_logic_vector is
    variable tmpSTDLV : std_logic_vector(data_out_t_size-1 downto 0);
    begin
        tmpSTDLV(data_out_t_size-1 downto 1) := std_logic_vector(i_data_out.result);
        tmpSTDLV(0) := i_data_out.c;
        return tmpSTDLV;
    end;


	function data_in_to_stdlv (i_data_in : in data_in_t) return std_logic_vector is
    variable tmpSTDLV : std_logic_vector(data_in_t_size-1 downto 0);
    begin
        tmpSTDLV(data_in_t_size-1 downto data_in_t_size-C_DATA_WIDTH) := std_logic_vector(i_data_in.a);
        tmpSTDLV(data_in_t_size-C_DATA_WIDTH-1 downto 0) := std_logic_vector(i_data_in.b);
        return tmpSTDLV;
    end;

    function stdlv_to_data_in (i_slv : in std_logic_vector(data_in_t_size-1 downto 0)) return data_in_t is
    variable tmpDataIn : data_in_t;
    begin
        tmpDataIn.a := signed(i_slv(data_in_t_size-1 downto data_in_t_size-C_DATA_WIDTH));
        tmpDataIn.b := signed(i_slv(data_in_t_size-C_DATA_WIDTH-1 downto 0));
        return tmpDataIn;
    end;
 
end package body adder_types;