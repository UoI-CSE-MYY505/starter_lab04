library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext is
	port(
		a : in  std_logic_vector(15 downto 0);
		y : out std_logic_vector(31 downto 0)
	);
end entity signext;

architecture RTL of signext is
begin
  y(a'range) <= a;
  y(y'left downto 16) <= (y'left downto 16 => a(a'left));
end architecture RTL;
