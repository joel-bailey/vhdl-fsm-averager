----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: TOP.vhd

-- Description: Top level - connections to components only
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           AVG : out STD_LOGIC_VECTOR (13 downto 0));
end TOP;

architecture Behavioral of TOP is

signal CTRL : STD_LOGIC_VECTOR( 5 downto 0 );
signal RAM_DATA, ACC_DATA: STD_LOGIC_VECTOR( 7 downto 0 );
signal SUM_DATA : STD_LOGIC_VECTOR ( 13 downto 0 );
signal ADDR : STD_LOGIC_VECTOR( 6 downto 0);
signal AVG_CLR, AVG_LD : STD_LOGIC;
signal SUM_CLR, SUM_LD : STD_LOGIC;
signal I_CLR, I_LD : STD_LOGIC;
signal ACC_CLR, ACC_LD : STD_LOGIC;
signal OVERFLOW : STD_LOGIC;

begin
controller: entity work.CONTROLLER(CONTROL)
    port map(CLK=>CLK, RST=>RST, CTRL=>CTRL, AVG_CLR=>AVG_CLR, AVG_LD=>AVG_LD, SUM_CLR=>SUM_CLR, 
             SUM_LD=>SUM_LD, I_CLR=>I_CLR, I_LD=>I_LD, ACC_CLR=>ACC_CLR, ACC_LD=>ACC_LD, OVERFLOW=>OVERFLOW);

counter: entity work.COUNTER(COUNT)
    port map(CLK=>CLK, I_CLR=>I_CLR, I_LD=>I_LD, CTRL=>CTRL, ADDR=>ADDR);
    
ram: entity work.RAM(READ)
    port map(CLK=>CLK, ADDR=>ADDR, DOUT=>RAM_DATA);

accumulator: entity work.ACC(HOLD)
    port map(CLK=>CLK, DIN=>RAM_DATA, ACC_CLR=>ACC_CLR, ACC_LD=>ACC_LD, DOUT=>ACC_DATA);

sum: entity work.SUM(SUM)
    port map(CLK=>CLK, SUM_LD=>SUM_LD, SUM_CLR=>SUM_CLR, DATA=>ACC_DATA, SUM=>SUM_DATA, OVERFLOW=>OVERFLOW);

sysout: entity work.AVERAGE(SYSOUT)
    port map(CLK=>CLK, AVG_LD=>AVG_LD, AVG_CLR=>AVG_CLR, DATA=>SUM_DATA, DOUT=>AVG);

end Behavioral;
