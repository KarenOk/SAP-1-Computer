library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity accumulator is

port(	I:	in std_logic_vector(7 downto 0);
	clock:	in std_logic;
	La, Ea:	in std_logic; -- ~La  Ea
	clear:	in std_logic;
	Qas:	out std_logic_vector(7 downto 0);  -- To addersubtractor
	Qb:	out std_logic_vector(7 downto 0)       -- TO bus
);
end accumulator;

----------------------------------------------------

architecture behv of accumulator is

signal I_bo: std_logic_vector (7 downto 0); -- I buffer output
signal Q_bi: std_logic_vector (7 downto 0); -- Q buffer input
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

Q_bi <= Q_tmp;
Q_dup <= Q_tmp;

process(La)
    begin 
    if La = '0' then
        I_bo <= I;
    else
        I_bo <= Q_dup;
    end if;
end process;

process(Ea)
    begin
    if Ea = '1' then
        Qb <= Q_bi;
    else
        Qb <= "ZZZZZZZZ";
    end if;
end process;

Qas <= Q_bi;
end behv;

---------------------------------------------------
