-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(18 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
	component alu_beh is
    generic(
        operand_width : integer:=8;
        sel_line : integer:=3
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector((operand_width*2)-1 downto 0)
    ) ;
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: alu_beh
			generic map (
				 operand_width => 8,
				 sel_line => 3
			
			)
			port map (
					
					sel => input_vector(18 downto 16),
					A => input_vector(15 downto 8),
					B => input_vector(7 downto 0),
               
					op => output_vector);

end DutWrap;

