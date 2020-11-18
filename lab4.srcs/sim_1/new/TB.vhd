----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: TB.vhd

-- Description: Test bench for averager. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB is
--  Port ( );
end TB;

architecture Behavioral of TB is

signal CLK, RST: STD_LOGIC := '0';
signal AVG : STD_LOGIC_VECTOR( 13 downto 0 );
signal CP: TIME := 20ns;

begin
dut: entity work.TOP(Behavioral)
    port map(CLK=>CLK, RST=>RST, AVG=>AVG);
    
clock: process begin
    CLK <= '0';
    wait for CP/2;
    CLK <= '1';
    wait for CP/2;
end process;    

reset: process begin
    RST <= '0';
    wait for CP/2;
    RST <= '1';
    wait for CP/2;
    RST <= '0';
    wait;
end process;  

end Behavioral;
