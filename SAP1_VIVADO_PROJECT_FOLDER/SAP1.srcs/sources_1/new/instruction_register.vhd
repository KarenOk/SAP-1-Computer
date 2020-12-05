library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

---------------------------------------------------

entity instruction_register is

port(	I:	in std_logic_vector(7 downto 0); --From bus
	clock:	in std_logic;   --CLK
	Li, Ei:	in std_logic; -- ~Li ~Ei
	clear:	in std_logic;   --CLR
	Qc:	out std_logic_vector(3 downto 0); -- To controller
	Qb:	out std_logic_vector(3 downto 0) --To bus
);
end instruction_register;

----------------------------------------------------

architecture behv of instruction_register is

    signal Qc_tmp, Qb_tmp: std_logic_vector(3 downto 0);

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

process(Li)
    begin 
    if Li = '0' then
        I_bo <= I;
    else
        I_bo <= Q_dup;
    end if;
end process;

process
    begin
    if Ei = '0' then
        Qb <= Q_bi(3 downto 0);
    else
        Qb <= "ZZZZ";
    end if;
end process;

Qc <= Q_bi(7 downto 4);

end behv;

---------------------------------------------------
