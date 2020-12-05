library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

----------------------------------------------------

entity adder_subtractor is

port(	
        A, B: in std_logic_vector (7 downto 0); -- A is from Accumulator and B is from B reigister
        Su, Eu: in std_logic;
        Result: out std_logic_vector (7 downto 0); -- Result is To bus
        Cout: out std_logic
);
end adder_subtractor;

----------------------------------------------------

architecture behv of adder_subtractor is
signal C: std_logic_vector ( 8 downto 0);
signal CinxB: std_logic_vector (7 downto 0);
signal S: std_logic_vector (7 downto 0);

begin
CinxB(0) <= B(0) xor Su;
CinxB(1) <= B(1) xor Su;
CinxB(2) <= B(2) xor Su;
CinxB(3) <= B(3) xor Su;
CinxB(4) <= B(4) xor Su;
CinxB(5) <= B(5) xor Su;
CinxB(6) <= B(6) xor Su;
CinxB(7) <= B(7) xor Su;

C(0) <= Su;

S(0) <= (A(0) xor CinxB(0)) xor C(0);
C(1) <= (A(0) and CinxB(0)) or (C(0) and (A(0) xor CinxB(0)));

S(1) <= (A(1) xor CinxB(1)) xor C(1);
C(2) <= (A(1) and CinxB(1)) or (C(1) and (A(1) xor CinxB(1)));

S(2) <= (A(2) xor CinxB(2)) xor C(2);
C(3) <= (A(2) and CinxB(2)) or (C(2) and (A(2) xor CinxB(2)));

S(3) <= (A(3) xor CinxB(3)) xor C(3);
C(4) <= (A(3) and CinxB(3)) or (C(3) and (A(3) xor CinxB(3)));

S(4) <= (A(4) xor CinxB(4)) xor C(4);
C(5) <= (A(4) and CinxB(4)) or (C(4) and (A(4) xor CinxB(4)));

S(5) <= (A(5) xor CinxB(5)) xor C(5);
C(6) <= (A(5) and CinxB(5)) or (C(5) and (A(5) xor CinxB(5)));

S(6) <= (A(6) xor CinxB(6)) xor C(6);
C(7) <= (A(6) and CinxB(6)) or (C(6) and (A(6) xor CinxB(6)));

S(7) <= (A(7) xor CinxB(7)) xor C(7);
C(8) <= (A(7) and CinxB(7)) or (C(7) and (A(7) xor CinxB(7)));

Cout <= C(8);

process(Eu)
    begin
        if Eu = '1' then
        Result <= S;
        elsif Eu = '0' then
        Result <= "ZZZZZZZZ";
        end if;

end process;

end behv;

------------------------------------
