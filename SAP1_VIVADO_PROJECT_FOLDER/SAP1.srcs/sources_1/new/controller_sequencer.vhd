library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity controller_sequencer is
port (  CLK: in std_logic;
        I: in std_logic_vector (7 downto 4);
        Cp,Ep,Lm,CE, Li, Ei,La,Ea,Su,Eu,Lb,Lo, HALT: out std_logic );
end controller_sequencer;

architecture Behavioral of controller_sequencer is

signal T: std_logic_vector(6 downto 1);
signal LDA, ADD, SUB, OUTPUT, HLT: std_logic;

    component instruction_decoder
    port (  I7, I6, I5, I4: in std_logic;
            LDA, ADD, SUB, OUTPUT, HLT: out std_logic
     );
    end component;
    
    component ring_counter
    port (  CLK: in std_logic;
        T: inout std_logic_vector (6 downto 1) );
    end component;
    
begin

RC: ring_counter 
    port map (CLK, T);

ID: instruction_decoder
    port map (I(7), I(6), I(5), I(4), LDA, ADD, SUB, OUTPUT, HLT);
    
Cp <= T(2);
Ep <= T(1);
Lm <= not ((T(4) and LDA) or (T(4) and ADD) or (T(4) and SUB) or T(1));
CE <= not ((T(5) and LDA) or (T(5) and ADD) or (T(5) and SUB) or T(3));
Li <= not T(3);
Ei <= not ((T(4) and LDA) or (T(4) and ADD) or (T(4) and SUB));
La <= not ((T(5) and LDA) or (T(6) and ADD) or (T(6) and SUB));
Ea <= T(4) and OUTPUT;
Su <= T(6) and SUB;
Eu <= (T(6) and ADD) or (T(6) and SUB);
Lb <= not ((T(5) and ADD) or (T(5) and SUB));
Lo <= T(4) nand OUTPUT;
HALT <= HLT;


end Behavioral;
