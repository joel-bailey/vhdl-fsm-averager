----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: SUM.vhd

-- Description: Computes the sum of itself and incoming data
-- NOTE: WITH OVERFLOW DETECTION (bit width reduced to show working detection)
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SUM is
    Port ( CLK : in STD_LOGIC;
           SUM_LD : in STD_LOGIC;
           SUM_CLR : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SUM : out STD_LOGIC_VECTOR (13 downto 0);
           OVERFLOW: out STD_LOGIC);
end SUM;

architecture SUM of SUM is

signal TSUM : STD_LOGIC_VECTOR( 13 downto 0 );

begin
process(CLK)
    variable EXSUM : STD_LOGIC_VECTOR( 14 downto 0 );
    variable EXTOTAL : STD_LOGIC_VECTOR( 14 downto 0 );
begin
    if rising_edge(CLK) then
        if SUM_CLR = '1' then
            TSUM <= (others=>'0');
        elsif SUM_LD = '1' then
            TSUM <= std_logic_vector(signed(DATA) + signed(TSUM));
        else
            TSUM <= TSUM;
        end if;
        
        EXSUM := TSUM(13) & TSUM;
        EXTOTAL := std_logic_vector(signed(EXSUM) + signed(DATA));
        
        if EXTOTAL(14) /= EXTOTAL(13) then
            OVERFLOW <= '1';
        else
            OVERFLOW <= '0';
        end if;
    end if;
end process;

SUM <= TSUM;

end SUM;
