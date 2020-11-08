library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lpm_constant4 is
	port(
		result : out std_logic_vector(31 downto 0)
	);
end entity lpm_constant4;

architecture RTL of lpm_constant4 is
	constant empty : std_logic_vector(28 downto 0) := (others => '0');
begin
	result <= empty & "100";
end architecture RTL;
