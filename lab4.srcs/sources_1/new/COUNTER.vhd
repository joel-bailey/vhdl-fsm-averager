----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: COUNTER.vhd

-- Description: Counts 0 -> 35 before controller resets counter
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity COUNTER is
    port ( CLK : in STD_LOGIC;
           I_CLR : in STD_LOGIC;
           I_LD : in STD_LOGIC;
           CTRL : out STD_LOGIC_VECTOR (5 downto 0);
           ADDR : out STD_LOGIC_VECTOR (6 downto 0));
end COUNTER;

architecture COUNT of COUNTER is

signal TCOUNT : STD_LOGIC_VECTOR( 5 downto 0 );
signal TADDR : STD_LOGIC_VECTOR( 6 downto 0 );

begin
process(CLK) begin
    if rising_edge(CLK) then
        if I_CLR = '1' then
            TCOUNT <= (others=>'0');
            TADDR <= "0011000";
        elsif I_LD = '1' then
            TCOUNT <= std_logic_vector(unsigned(TCOUNT) + 1);
            TADDR <= std_logic_vector(unsigned(TADDR) + 1);
        else
            TCOUNT <= TCOUNT;
            TADDR <= TADDR;
        end if;
    end if;
end process;

CTRL <= TCOUNT;
ADDR <= TADDR;

end COUNT;
