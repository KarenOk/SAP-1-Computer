library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity RAM is
generic(	width:	integer:=8;
		depth:	integer:=16;
		addr:	integer:=4);
port(	Clock:		in std_logic;	
        Clear:      in std_logic;
	Enable:		in std_logic; 
	Read:		in std_logic;
	Write:		in std_logic;
	Read_Addr:	in std_logic_vector(addr-1 downto 0);
	Write_Addr: in std_logic_vector(addr-1 downto 0); 
	Data_in: 	in std_logic_vector(width-1 downto 0);  -- From Switches
	Data_out: 	out std_logic_vector(width-1 downto 0)  -- To W-Bus
	);
end RAM;

--------------------------------------------------------------

architecture behav of RAM is

-- use array to define the bunch of internal temparary signals

type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type;

begin	
			   
    -- Read Functional Section
    process(Clock, Read, Clear)
    begin
            if Enable='1' then
            if Read='1' then
                -- building function conv_integer change the type
                -- from std_logic_vector to integer
                Data_out <= tmp_ram(conv_integer(Read_Addr)); 
            else
                Data_out <= (Data_out'range => 'Z');
            end if;
            end if;

    
    end process;
	
    -- Write Functional Section
    process(Clock, Write,Clear,Enable)
    begin
    if Clear = '1' then
     tmp_ram(0) <= "00000000";
     tmp_ram(1) <= "00000000";
     tmp_ram(2) <= "00000000";
     tmp_ram(3) <= "00000000";
     tmp_ram(4) <= "00000000";
     tmp_ram(5) <= "00000000";
     tmp_ram(6) <= "00000000";
     tmp_ram(7) <= "00000000";
     tmp_ram(8) <= "00000000";
     tmp_ram(9) <= "00000000";
     tmp_ram(10) <= "00000000";
     tmp_ram(11) <= "00000000";
     tmp_ram(12) <= "00000000";
     tmp_ram(13) <= "00000000";
     tmp_ram(14) <= "00000000";
     tmp_ram(15) <= "00000000";
    elsif Clear = '0' then
        if (Clock'event and Clock='1') then
            if Enable='1' then
            if Write='1' then
                tmp_ram(conv_integer(Write_Addr)) <= Data_in;
            end if;
            end if;
        end if;
    
    end if;
    end process;

end behav;
----------------------------------------------------------------
