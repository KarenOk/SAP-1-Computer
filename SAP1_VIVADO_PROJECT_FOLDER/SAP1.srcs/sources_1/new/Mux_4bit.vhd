library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity Mux_4bit is
port (  input_1: in std_logic_vector (3 downto 0);  
        input_2: in std_logic_vector (3 downto 0);
        sel:     in std_logic;
        output:  out std_logic_vector (3 downto 0));
end Mux_4bit;

architecture Behavioral of Mux_4bit is

begin

output(0) <= (input_1(0) and (not sel)) or (input_2(0) and sel);
output(1) <= (input_1(1) and (not sel)) or (input_2(1) and sel);
output(2) <= (input_1(2) and (not sel)) or (input_2(2) and sel);
output(3) <= (input_1(3) and (not sel)) or (input_2(3) and sel);

end Behavioral;
