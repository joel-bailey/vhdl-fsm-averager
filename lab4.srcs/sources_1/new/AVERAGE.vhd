----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: AVERAGE.vhd

-- Description: Computes the average of 32 numbers when LOAD is high
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AVERAGE is
    Port ( CLK : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (13 downto 0);
           AVG_LD : in STD_LOGIC;
           AVG_CLR : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (13 downto 0));
end AVERAGE;

architecture SYSOUT of AVERAGE is
signal TAVG : STD_LOGIC_VECTOR( 13 downto 0 );

begin

-- process 
process(CLK)
variable HOLD : Integer;
begin
    if rising_edge(CLK) then
        if AVG_CLR = '1' then
            TAVG <= (others=>'0');
        elsif AVG_LD = '1' then
            HOLD := to_integer(signed(DATA)) / 50;
            TAVG <= std_logic_vector(to_signed(HOLD, 14));
            --TAVG <= std_logic_vector(shift_right(signed(DATA), 5));
        else
            TAVG <= TAVG;
        end if;
    end if;
end process;

DOUT <= TAVG;

end SYSOUT;
