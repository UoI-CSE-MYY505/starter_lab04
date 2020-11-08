library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

entity dmem is
    port(
        clk : in  std_logic;
    	we  : in  std_logic;
    	a   : in  std_logic_vector(31 downto 0);
    	wd  : in  std_logic_vector(31 downto 0);
    	rd  : out std_logic_vector(31 downto 0)
    );
end entity dmem;

architecture RTL of dmem is
    type memoryArray is array (127 downto 0) of std_logic_vector(31 downto 0);
    impure function init_ram return memoryArray is
        file inputText     : text;
        variable inputLine : line;
        variable temporal  : std_logic_vector(31 downto 0);
        variable ram       : memoryArray := (others => (others => 'X'));
    begin
        file_open(inputText, "data_memfile.dat", read_mode);
        for index in 0 to 127 loop
            if (endfile(inputText)) then
                exit;
            else
                readline(inputText, inputLine);
    	    	hread(inputLine, temporal);
    	        ram(index) := temporal;
    	    end if;
        end loop;
        file_close(inputText);
    	return ram;
    end init_ram;

    signal ram : memoryArray := init_ram;
begin
    proc : process(clk)
    begin
    	if (rising_edge(clk)) then
    	    if (we = '1') then
    	        ram(to_integer(unsigned(a(7 downto 2)))) <= wd;
    	    end if;
        end if;
    end process proc;
    rd <= ram(to_integer(unsigned(a(7 downto 2)))) after 50 ns;
end architecture RTL;
