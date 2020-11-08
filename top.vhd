library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
end entity top;

architecture RTL of top is
	component mips
		port(
			clk   : std_logic;
			reset : std_logic
		);
	end component;
	signal clk      : std_logic := '0';
	signal reset    : std_logic := '1';
	signal cycle_counter : integer range 0 to 4095;
begin
	duv : mips
		port map(
			clk => clk,
			reset => reset
		);
	last : process
	begin
		reset <= '0' after 10 ns;
		wait until cycle_counter = 4095;
		assert (cycle_counter /= 4095) report "Probable Infinite Loop" severity failure;
	end process last;
	clk <= not clk after 200 ns;
	count : process(clk)
	begin
		if (rising_edge(clk)) then
			cycle_counter <= cycle_counter + 1;
		end if;
	end process count;
end architecture RTL;
