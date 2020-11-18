----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: RAM.vhd

-- Description: All inputs were not required in the top level, so I brought
--  the ram into its own module with reduced ports and hardwired the unneeded ports
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port ( ADDR : in STD_LOGIC_VECTOR (6 downto 0);
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end RAM;

architecture READ of RAM is

component blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

begin
BRAM : blk_mem_gen_0
  port map (clka => CLK, wea => "0", addra => ADDR , dina => "00000000", douta => DOUT);

end READ;
