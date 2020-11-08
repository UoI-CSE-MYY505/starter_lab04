library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port(
		a : in  std_logic_vector(31 downto 0);
		b : in  std_logic_vector(31 downto 0);
		y : out std_logic_vector(31 downto 0)
	);
end entity adder;

architecture RTL of adder is
begin
	y <= std_logic_vector(unsigned(a) + unsigned(b)) after 30 ns;
end architecture RTL;
