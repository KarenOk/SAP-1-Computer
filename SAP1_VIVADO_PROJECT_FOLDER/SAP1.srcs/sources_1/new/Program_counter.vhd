library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

----------------------------------------------------

entity Program_counter is
port(	clock:	in std_logic; -- ~CLK
    Ep:	in std_logic;
	clear:	in std_logic; -- CLR
	count:	in std_logic; --Cp
	Q:	out std_logic_vector(3 downto 0) -- Output to bus
);
end Program_counter;

----------------------------------------------------

architecture behv of Program_counter is		 	  
	
    signal Pre_Q: std_logic_vector(3 downto 0);-- := "0000";
    signal Q_bin: std_logic_vector(3 downto 0);

begin
   process(clock, count, clear, Ep)
    begin
    if  clear = '1' then -- change clear to zero
            Pre_Q <= "0000";
            Q_bin <= "0000";
    else
        if (clock='0' and clock'event) then
                if count = '1' then
                    Pre_Q <= Pre_Q + "1";
                end if;
            end if;
            Q_bin <= Pre_Q;
     end if;
    end process;	
    -- concurrent assignment statement
    --Q <= Pre_Q;

process(Ep)
begin
if Ep = '1' then
Q <= Q_bin;
else
Q <= "ZZZZ";
end if;
end process;

end behv;

------------------------------------

------------------------------------
