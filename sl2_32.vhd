library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2_32 is
	port(
		a : in  std_logic_vector(31 downto 0);
		y : out std_logic_vector(31 downto 0)
	);
end entity sl2_32;

architecture RTL of sl2_32 is
	constant empty : std_logic_vector(1 downto 0) := (others => '0');
begin
	y <= a(29 downto 0) & empty; -- Shift left by 2.
end architecture RTL;
