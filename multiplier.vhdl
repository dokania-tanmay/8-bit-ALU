library ieee;
use ieee.std_logic_1164.all;



entity multiplier is
port (A1, B1: in std_logic_vector(7 downto 0); op: out std_logic_vector(15 downto 0));
end entity multiplier;



architecture struct of multiplier is
type arr is array (7 downto 0) of std_logic_vector(7 downto 0);
type arr1 is array (6 downto 0) of std_logic_vector(8 downto 0);
signal s1: arr;
signal s2: arr1;
signal carr:std_logic_vector(6 downto 0);



function add(A: in std_logic_vector(7 downto 0);
B: in std_logic_vector(7 downto 0))
return std_logic_vector is
variable sum : std_logic_vector(7 downto 0);
variable carry: std_logic;
variable i : integer;

begin
carry:= '0';
add: for i in 0 to 7 loop
sum(i):= (A(i) xor B(i)) xor carry;
carry:= (A(i) and B(i)) or (A(i) and carry) or (B(i) and carry);
end loop;

return (carry&sum);
end add;
begin


sig_aass: for j in 0 to 7 generate
sig_assign: for i in 0 to 7 generate
s1(j)(i) <= A1(i) and B1(j);
end generate sig_assign;
end generate;


op(0) <= s1(0)(0);
s2(0) <= add("0"&s1(0)(7 downto 1), s1(1));

op(1) <= s2(0)(0);
s2(1) <= add(s2(0)(8 downto 1), s1(2));

op(2) <= s2(1)(0);
s2(2) <= add(s2(1)(8 downto 1), s1(3));

op(3) <= s2(2)(0);
s2(3) <= add(s2(2)(8 downto 1), s1(4));

op(4) <= s2(3)(0);
s2(4) <= add(s2(3)(8 downto 1), s1(5));

op(5) <= s2(4)(0);
s2(5) <= add(s2(4)(8 downto 1), s1(6));

op(6) <= s2(5)(0);
s2(6) <= add(s2(5)(8 downto 1), s1(7));

op(7) <= s2(6)(0);
op(15 downto 8) <= s2(6)(8 downto 1);



end struct;