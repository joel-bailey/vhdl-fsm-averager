----------------------------------------------------------------------------------
-- Lab 4 - Data / Control Path
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201008
-- Modified Last: 20201016
-- Module Name: CONTROLLER.vhd

-- Description: Finite state machine controller with 3 states, clear, accumulate,
--  and output. States are controlled by a counter.
-- NOTE: Only component with async reset in design 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTROLLER is
    Port ( CTRL : in STD_LOGIC_VECTOR (5 downto 0);
           CLK, RST, OVERFLOW : in STD_LOGIC;
           AVG_CLR : out STD_LOGIC;
           AVG_LD : out STD_LOGIC;
           I_CLR : out STD_LOGIC;
           I_LD : out STD_LOGIC;
           SUM_CLR : out STD_LOGIC;
           SUM_LD : out STD_LOGIC;
           ACC_CLR : out STD_LOGIC;
           ACC_LD : out STD_LOGIC);
end CONTROLLER;

architecture CONTROL of CONTROLLER is

type StateType is ( ClearState, AccState, OutputState );
signal CurrentState, NextState: StateType;

begin
--Seperated by state logic

--First Process, Next State Logic
NS: process(CLK) begin
    case CurrentState is
        when ClearState =>
            if (CTRL = "000000") then
                NextState <= AccState;
            end if;
        when AccState =>
            if (CTRL = "110110") then
                NextState <= OutputState;
            elsif (OVERFLOW = '1') then
                NextState <= ClearState;
            end if;
        when others =>
            NextState <= ClearState;
    end case;
end process;

--Second Process, Current State Logic
CS: process(CLK, RST)
    begin
    if RST = '1' then
        CurrentState <= ClearState;
    elsif rising_edge(CLK) then
        CurrentState <= NextState;
    else
        CurrentState <= CurrentState;
    end if;
end process;

--Third, Output Logic
O: process(CurrentState) begin
    case CurrentState is
        when ClearState =>
            AVG_CLR <= '1';
            AVG_LD  <= '0';
            I_CLR   <= '1';
            I_LD    <= '0';
            SUM_CLR <= '1';
            SUM_LD  <= '0';
            ACC_CLR <= '1';
            ACC_LD  <= '0';
        when AccState =>
            AVG_CLR <= '0';
            AVG_LD  <= '0';
            I_CLR   <= '0';
            I_LD    <= '1';
            SUM_CLR <= '0';
            SUM_LD  <= '1';
            ACC_CLR <= '0';
            ACC_LD  <= '1';
        when others =>
            AVG_CLR <= '0';
            AVG_LD  <= '1';
            I_CLR   <= '1';
            I_LD    <= '0';
            SUM_CLR <= '0';
            SUM_LD  <= '1';
            ACC_CLR <= '0';
            ACC_LD  <= '1';
    end case;
end process;

end CONTROL;
