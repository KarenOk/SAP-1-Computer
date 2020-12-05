library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity b_register is
port(	I:	in std_logic_vector(7 downto 0);
	clock:	in std_logic;   -- CLK
	 Lb:	in std_logic;   -- ~Lb
	clear:	in std_logic;   -- CLR
	Q:	out std_logic_vector(7 downto 0) -- To Add Sb
);
end b_register;

----------------------------------------------------

architecture behv of b_register is

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

process(Lb)
    begin 
    if Lb = '0' then
        I_bo <= I;
    else
        I_bo <= Q_dup;
    end if;
end process;

end behv;

---------------------------------------------------
