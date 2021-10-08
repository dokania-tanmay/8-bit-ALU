
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity alu_beh is
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
end alu_beh;

architecture a1 of alu_beh is
    
	 function add(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
            -- Declare "sum" and "carry" variable
				variable sum: std_logic_vector(8 downto 0);
				variable carry: std_logic_vector(7 downto 0);
				variable i : integer;
        begin
            -- write logic for addition
            -- Hint: Use for loop
				sum(0) := A(0) xor B(0);
				carry(0) := A(0) AND B(0);
				summingBitwise: for i in 1 to 7 loop
					sum(i) := ( A(i) xor B(i) ) xor carry(i-1);
					carry(i) := (A(i) and B(i) ) or ( B(i) and carry(i-1) ) or ( A(i) and carry(i-1) );
				end loop;
				sum(8) := carry(7);
            return sum;
    end add;
	 
	 
	 component div is
		generic(
				N : integer:=8; -- operand width
				NN : integer:=16 -- result width
				);
		port (
				Nu: in std_logic_vector(N-1 downto 0);-- Nu (read numerator) is dividend
				D: in std_logic_vector(N-1 downto 0);-- D (read Denominator) is divisor
				RQ: out std_logic_vector(NN-1 downto 0)--upper N bits of RQ will have remainder and lower N bits will have quotient
		) ;
	end component;
	component multiplier is
		port (A1, B1: in std_logic_vector(7 downto 0); op: out std_logic_vector(15 downto 0));
	end component;

	signal quot, mult : std_logic_vector(15 downto 0);
	signal bprime : std_logic_vector(7 downto 0);
	
begin

div_1 : div port map(Nu=>A, D=>bprime, RQ=>quot);
bprime(0) <= '1';
bprime(7 downto 1) <= B(7 downto 1);

mult_1 : multiplier port map(A1 => A, B1 => B, op => mult);

alu : process( A, B, sel )
	variable temp: std_logic_vector(3 downto 0);
	variable i : integer;
begin
   -- complete VHDL code for various outputs of ALU based on select lines
   -- Hint: use if/else statement
	if unsigned(sel)=0  then
		op <= "0000000"&add(A,B);   	-- ADDER
	
	elsif unsigned(sel)=1 then
	   op <= mult;							-- MULTIPLIER
		
	elsif unsigned(sel)=2 then
		op <= quot;							-- DIVISION
	
	elsif unsigned(sel)=3 then
		op <= "00000000" & (A XOR B);	-- XOR
	
	elsif unsigned(sel)=4 then
		op <= "0000000"&A&"0";			-- Left Shift by 1
	
	elsif unsigned(sel)=5 then
		op <= "000000"&A&"00";			-- Left Shift by 2
	
	elsif unsigned(sel)=6 then
		op <= "0000"&A&"0000";			-- Left Shift by 4
	
	elsif unsigned(sel)=7 then
		op <= A&"00000000";				-- Left Shift by 8		
	end if;
	--	op <= "00000000" & (A NAND B);-- NAND
	-- op <= A&B;							-- CONCAT
end process ; -- alu


end a1 ; -- a1
