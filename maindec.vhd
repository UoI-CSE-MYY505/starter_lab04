library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maindec is
	port(
		op       : in  std_logic_vector(5 downto 0); -- Op Code Field of Instruction.
		funct    : in  std_logic_vector(5 downto 0); -- Funct Field of R-type Instructions.
		regwrite : out std_logic;
		regdst   : out std_logic_vector(1 downto 0);
		alusrc   : out std_logic_vector(1 downto 0);
		aluop    : out std_logic_vector(1 downto 0);
		branch   : out std_logic;
		bne      : out std_logic;
		jump     : out std_logic;
		jr       : out std_logic;
		memwrite : out std_logic;
		memtoreg : out std_logic_vector(1 downto 0)

	);
end entity maindec;

architecture RTL of maindec is
	-- Implemented Instructions:
	-- lw, sw,
	-- beq, j
	-- addi, addiu (same as addi, ignores overflows),
	-- ori,
        -- lui,
	-- add, sub, and, or, slt.
begin
	proc : process(op, funct)
	begin
		-- Default Values for Signals.
		regwrite <= '0'; -- Don't write result to the Register File.
		regdst   <= "00"; -- Destination Register, unimportant, but set to 0 for simplicity.
		alusrc   <= "XX"; -- Second ALU source, unimportant.
		aluop    <= "XX"; -- ALU operation, unimportant.
		branch   <= '0';
		bne      <= '0';
		jump     <= '0';
		jr       <= '0';
		memwrite <= '0'; -- Don't write to the Data Memory.
		memtoreg <= "XX"; -- Result Mux, unimportant.
		case op is
			when "000000" =>            -- RTYPE --
				regwrite <= '0';
				jump     <= '0';
				jr       <= '0';
				regdst   <= "01"; -- Rd is the Destination Register.
				alusrc   <= "00"; -- Second ALU source is the register value.
				aluop    <= "10"; -- Second ALU source is the register value.
				memtoreg <= "00"; -- AluOut to be stored to the Register File.
			when "100011" =>            --  LW   --
				regwrite <= '1';  -- Write Result to Register File.
				alusrc   <= "01"; -- Second ALU source is Immediate.
				aluop    <= "00"; -- ALU is doing addition
				memtoreg <= "01"; -- Signal Result is Mem Output.
			when "101011" =>            --  SW   --
				alusrc   <= "01"; -- Second ALU  source is Immediate.
				aluop    <= "00"; -- ALU is doing addition.
				memwrite <= '1';  -- Write to Data Memory.
			when "000100" =>            --  BEQ  --
				alusrc   <= "00"; -- Second ALU source is the register value.
				aluop    <= "01"; -- Subtract
				branch  <= '1';
			when "001000" | "001001" => -- ADDI, ADDIU --
				regwrite <= '1';  -- Write Result to Register File.
				regdst   <= "00"; -- Rt is the Destination Register.
				alusrc   <= "01"; -- Second ALU source is Immediate.
				aluop    <= "00";
				memtoreg <= "00"; -- Signal Result is ALU Output.
			when "000010" =>            --   J   --
				jump     <= '1';
			when "001111" =>            --  LUI  --
				regwrite <= '1';  -- Write Result to Register File.
				regdst   <= "00"; -- Rt is the Destination Register.
				alusrc   <= "10"; -- Second ALU Source is lui Immediate.
				aluop    <= "11"; -- OR
				memtoreg <= "00"; -- Signal Result is ALU Output.
			when "001101" =>            --  ORI  --
				regwrite <= '1';  -- Write Result to Register File.
				regdst   <= "00"; -- Rt is the Destination Register.
				alusrc   <= "01"; -- Second ALU Source is Immediate.
				aluop    <= "11"; -- OR
				memtoreg <= "00"; -- Signal Result is ALU Output.
			when others =>            -- Unknown --
		end case;
	end process proc;
end architecture RTL;
