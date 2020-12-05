library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity output_register is

port(	I:	in std_logic_vector(7 downto 0);
	clock:	in std_logic;   -- CLK
    Lo: 	in std_logic;    --  ~Lo
	clear:	in std_logic;   -- CLR
	Q:	out std_logic_vector(7 downto 0)  -- To Binary Display
);
end output_register;

----------------------------------------------------

architecture behv of output_register is

signal I_bo: std_logic_vector (7 downto 0); -- I buffer output
signal Q_tmp: std_logic_vector (7 downto 0);
signal Q_dup: std_logic_vector (7 downto 0);

begin

process(clear, clock)
    begin
    if clear = '1' then
        Q_tmp <= (Q_tmp'range => '0');
    elsif (clock='1' and clock'event) then
        Q_tmp <= I_bo;
    end if;
end process;

Q <= Q_tmp;
Q_dup <= Q_tmp;

process(Lo)
    begin 
    if Lo = '0' then
        I_bo <= I;
    else
        I_bo <= Q_dup;
    end if;
end process;

end behv;

---------------------------------------------------
