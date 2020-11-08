library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is
    port(
        clk    : in  std_logic;
        reset  : in  std_logic;
        d      : in  std_logic_vector(31 downto 0);
        q      : out std_logic_vector(31 downto 0)
    );
end entity flopr;

architecture RTL of flopr is
    attribute noprune : boolean;
	 attribute noprune of q : signal is true;
begin
    proc : process(clk, reset)
    begin
        if (reset = '1') then
                q <= (others => '0') after 10 ns;
        else
            if (rising_edge(clk)) then
                q <= d after 10 ns;
            end if;
        end if;
    end process proc;
end architecture RTL;
