library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

entity imem is
    port(
        a  : in  std_logic_vector(31 downto 0);
        rd : out std_logic_vector(31 downto 0)
    );
end entity imem;

architecture RTL of imem is

    type memoryArray is array (127 downto 0) of std_logic_vector(31 downto 0);

    impure function init_rom return memoryArray is
        file inputText     : text;
        variable inputLine : line;
        variable temporal  : std_logic_vector(31 downto 0);
        variable rom       : memoryArray := (others => (others => 'X'));
    begin
        file_open(inputText, "instr_memfile.dat", read_mode);
        for index in 0 to 127 loop
            if (endfile(inputText)) then
                exit;
            else
                readline(inputText, inputLine);
                hread(inputLine, temporal);
                rom(index) := temporal;
            end if;
        end loop;
        file_close(inputText);
        return rom;
    end init_rom;

    signal rom : memoryArray := init_rom;
	 attribute keep : boolean;
	 attribute keep of rd : signal is true;
	 
begin
    rd <= rom(to_integer(unsigned(a(8 downto 2)))) after 50 ns;
end architecture RTL;
