library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
    port(
        clk : in  std_logic;
        we3 : in  std_logic;
        ra1 : in  std_logic_vector(4 downto 0);
        ra2 : in  std_logic_vector(4 downto 0);
        wa3 : in  std_logic_vector(4 downto 0);
        wd3 : in  std_logic_vector(31 downto 0);
        rd1 : out std_logic_vector(31 downto 0);
        rd2 : out std_logic_vector(31 downto 0)
    );
end entity regfile;

architecture RTL of regfile is
	 attribute keep : boolean;
	 attribute keep of rd1 : signal is true;
	 attribute keep of rd2 : signal is true;
	 
    type rfArray is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal rf      : rfArray := (others => (others => '0'));
    constant empty : std_logic_vector(4 downto 0) := (others => '0');
begin
    -- Three Ported Register File.
    -- Read Ports ra1 and ra2 Combinationally.
    -- Write Port wa3 on rising edge of the clock.
    -- Register zero hardwired to $zero.
    -- IMPORTANT: Bypasses stored value if Write Enabled, and (wa3 = ra1) or (wa3 = r2).
    proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (we3 = '1') then
                rf(to_integer(unsigned(wa3))) <= wd3;
            end if;
        end if;
    end process proc;

    rd1 <= (others => '0') after 50 ns when (ra1 = empty)
        else rf(to_integer(unsigned(ra1))) after 50 ns;
    rd2 <= (others => '0') after 50 ns when (ra2 = empty)
        else rf(to_integer(unsigned(ra2))) after 50 ns;
end architecture RTL;
