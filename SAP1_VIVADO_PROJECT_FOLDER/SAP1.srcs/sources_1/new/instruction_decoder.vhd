library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity instruction_decoder is
port (  I7, I6, I5, I4: in std_logic;
        LDA, ADD, SUB, OUTPUT, HLT: out std_logic
 );
end instruction_decoder;

architecture Behavioral of instruction_decoder is

begin

LDA <= ( I7) and (not I6) and ( I5) and ( I4);              -- 0xB    1011
ADD <= (not I7) and (I6) and (not I5) and (I4);             -- 0x5    0101
SUB <= (not I7) and ( I6) and ( I5) and ( I4);              -- 0x7    0111
OUTPUT <= (not I7) and (not I6) and (not I5) and (not I4);  -- 0x0    0000
HLT <= (not I7) and ( I6) and (not I5) and (not I4);        -- 0x4    0100

end Behavioral;
