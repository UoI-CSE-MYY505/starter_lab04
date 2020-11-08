library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2_26 is
	port(
		a : in  std_logic_vector(25 downto 0);
		y : out std_logic_vector(27 downto 0)
	);
end entity sl2_26;

architecture RTL of sl2_26 is
	constant empty : std_logic_vector(1 downto 0) := (others => '0');
begin
	y <= a & empty; -- Shift left by 2.
end architecture RTL;
