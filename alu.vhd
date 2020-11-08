library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        a       : in  std_logic_vector(31 downto 0);
        b       : in  std_logic_vector(31 downto 0);
        alucont : in  std_logic_vector(2 downto 0);
        zero    : out std_logic;
        result  : out std_logic_vector(31 downto 0)
    );
end entity alu;

architecture RTL of alu is
    signal b2  : std_logic_vector(31 downto 0);
    signal sum : std_logic_vector(31 downto 0);
    signal slt : std_logic_vector(31 downto 0);
    signal res : std_logic_vector(31 downto 0);
    constant empty   : std_logic_vector(30 downto 0) := (others => '0');
    constant empty32 : std_logic_vector(31 downto 0) := (others => '0');
begin
    b2     <= not b when (alucont(2) = '1') else b;
    sum    <= std_logic_vector(unsigned(a) + unsigned(b2) + unsigned(alucont(2 downto 2)));
    slt    <= empty & sum(31);
    with alucont(1 downto 0) select res <= -- Has to become "res". Cannot "read" an output in VHDL!
        a and b after 50 ns when "00",
        a or b  after 50 ns when "01",
        sum     after 50 ns when "10",
        slt     after 50 ns when "11",
        (others => 'X')     when others;
    zero   <= '1' when (res = empty32) else '0';
    result <= res;
end architecture RTL;
