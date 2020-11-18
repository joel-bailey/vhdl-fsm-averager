----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: ACC.vhd

-- Description: Holds the next value read from the BRAM
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ACC is
    Port ( ACC_CLR : in STD_LOGIC;
           ACC_LD : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DIN : in STD_LOGIC_VECTOR (7 downto 0);
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end ACC;

architecture HOLD of ACC is

signal TEMP : STD_LOGIC_VECTOR( 7 downto 0 );

begin
process(CLK) begin
    if rising_edge(CLK) then
        if ACC_CLR = '1' then
            TEMP <= (others=>'0');
        elsif ACC_LD = '1' then
            TEMP <= DIN;
        else
            TEMP <= TEMP;
        end if;
    end if;
end process;

DOUT <= TEMP;

end HOLD;
