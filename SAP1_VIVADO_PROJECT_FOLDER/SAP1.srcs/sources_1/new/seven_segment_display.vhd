library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity seven_segment_display is
port ( SSEG_CA: out std_logic_vector (6 downto 0);
       SSEG_AN: out std_logic_vector (3 downto 0);
       CLK: in std_logic;
       address: in std_logic_vector(3 downto 0);    --SW(15 dt 12)
       data: in std_logic_vector(7 downto 0);       --SW(7 dt 0)
       write_to_RAM: in std_logic;                  -- BTN(1) -- Write button
       run: in std_logic;                           --SW(11)
       out_reg_output: in std_logic_vector(7 downto 0);
       RAM_output: in std_logic_vector(7 downto 0);
       show_RAM_output: in std_logic);              --SW(10)

end seven_segment_display;

architecture Behavioral of seven_segment_display is
signal count: STD_LOGIC_VECTOR (19 downto 0);
signal selector: std_logic_vector(1 downto 0);
signal seven_seg_in: STD_LOGIC_VECTOR (3 downto 0);


begin

process(CLK)
begin
    if(rising_edge(CLK)) then
        count <= count + "1";
    end if;
end process;

selector <= count(19 downto 18);

process(run, show_RAM_output, write_to_RAM, selector, seven_seg_in)
begin
    
    if run = '0' then
                
        if show_RAM_output = '1' or write_to_RAM = '1' then       
            case seven_seg_in is
                when "0000" => SSEG_CA <= "1000000"; -- "0"     
                when "0001" => SSEG_CA <= "1111001"; -- "1" 
                when "0010" => SSEG_CA <= "0100100"; -- "2" 
                when "0011" => SSEG_CA <= "0110000"; -- "3" 
                when "0100" => SSEG_CA <= "0011001"; -- "4" 
                when "0101" => SSEG_CA <= "0010010"; -- "5" 
                when "0110" => SSEG_CA <= "0000010"; -- "6" 
                when "0111" => SSEG_CA <= "1111000"; -- "7" 
                when "1000" => SSEG_CA <= "0000000"; -- "8"     
                when "1001" => SSEG_CA <= "0010000"; -- "9" 
                when "1010" => SSEG_CA <= "0100000"; -- a
                when "1011" => SSEG_CA <= "0000011"; -- b
                when "1100" => SSEG_CA <= "1000110"; -- C
                when "1101" => SSEG_CA <= "0100001"; -- d
                when "1110" => SSEG_CA <= "0000110"; -- E
                when "1111" => SSEG_CA <= "0001110"; -- F
            end case;
            
            case selector is
                when "00" =>
                    SSEG_AN <= "0111";  
                    seven_seg_in <= address; 
                when "01" =>
                    SSEG_CA <= "1111111"; 
                    SSEG_AN <= "1011"; 
                when "10" =>
                    SSEG_AN <= "1101"; 
                    seven_seg_in <= RAM_output(7 downto 4);
                when "11" =>
                    SSEG_AN <= "1110"; 
                    seven_seg_in <= RAM_output(3 downto 0);
            end case; 
       
       else -- When show_RAM_output = '0' and write_to_RAM = '0'
            case selector is
                when "00" =>
                    SSEG_CA <= "0010010";   -- 'S' 
                    SSEG_AN <= "0111";   
                when "01" =>
                    SSEG_CA <= "0001000";   -- 'A'
                    SSEG_AN <= "1011"; 
                when "10" =>
                    SSEG_CA <= "0001100";   -- 'P'
                    SSEG_AN <= "1101"; 
                when "11" =>
                    SSEG_CA <= "1111001";   -- '1'
                    SSEG_AN <= "1110";  
                end case;
       end if;
       
   else -- When run = '1'
        case seven_seg_in is
                when "0000" => SSEG_CA <= "1000000"; -- "0"     
                when "0001" => SSEG_CA <= "1111001"; -- "1" 
                when "0010" => SSEG_CA <= "0100100"; -- "2" 
                when "0011" => SSEG_CA <= "0110000"; -- "3" 
                when "0100" => SSEG_CA <= "0011001"; -- "4" 
                when "0101" => SSEG_CA <= "0010010"; -- "5" 
                when "0110" => SSEG_CA <= "0000010"; -- "6" 
                when "0111" => SSEG_CA <= "1111000"; -- "7" 
                when "1000" => SSEG_CA <= "0000000"; -- "8"     
                when "1001" => SSEG_CA <= "0010000"; -- "9" 
                when "1010" => SSEG_CA <= "0100000"; -- a
                when "1011" => SSEG_CA <= "0000011"; -- b
                when "1100" => SSEG_CA <= "1000110"; -- C
                when "1101" => SSEG_CA <= "0100001"; -- d
                when "1110" => SSEG_CA <= "0000110"; -- E
                when "1111" => SSEG_CA <= "0001110"; -- F
          end case;
          
          case selector is
                when "00" =>
                    SSEG_AN <= "0111";  
                    SSEG_CA <= "1111111";
                when "01" =>
                    SSEG_CA <= "1111111"; 
                    SSEG_AN <= "1011"; 
                when "10" =>
                    SSEG_AN <= "1101"; 
                    seven_seg_in <= out_reg_output(7 downto 4);
                when "11" =>
                    SSEG_AN <= "1110"; 
                    seven_seg_in <= out_reg_output(3 downto 0);
            end case; 
    end if;
             
       
end process;

end Behavioral;
