library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ring_counter is
Port (  CLK: in std_logic;
        T: inout std_logic_vector (6 downto 1):= "100000" );
end ring_counter;

architecture Behavioral of ring_counter is

signal selector: std_logic_vector (2 downto 0);
signal count: std_logic_vector (30 downto 0);

signal T_Temp: std_logic_vector (6 downto 0):= "1000000";
signal T_dup: std_logic_vector (6 downto 0);

begin

    process
        begin
            if (CLK = '1' and CLK'event) then
                if T = "000001" then
                T <= "000010";
                elsif T = "000010" then
                T <= "000100";
                elsif T = "000100" then
                T <= "001000";
                elsif T = "001000" then
                T <= "010000";
                elsif T = "010000" then
                T <= "100000";
                elsif T = "100000" then
                T <= "000001";
                end if;
            end if;
    end process;

end Behavioral;
