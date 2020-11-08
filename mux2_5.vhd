library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_5 is
	port(
		d0 : in  std_logic_vector(4 downto 0);
		d1 : in  std_logic_vector(4 downto 0);
		s  : in  std_logic;
		y  : out std_logic_vector(4 downto 0)
	);
end entity mux2_5;

architecture RTL of mux2_5 is
begin
	y <= d1 when (s = '1') else d0 after 10 ns;
end architecture RTL;
