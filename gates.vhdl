library IEEE;
use IEEE.std_logic_1164.all;

entity andgate is
    port (A, B: in std_ulogic;
    O: out std_ulogic);
end entity andgate;

architecture trivial of andgate is
    begin
    O <= A AND B AFTER 387 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity xorgate is
    port (A, B: in std_ulogic;
    O: out std_ulogic);
end entity xorgate;

architecture trivial of xorgate is
    begin
    O <= A XOR B AFTER 774 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity abcgate is
    port (A, B, C: in std_ulogic;
    O: out std_ulogic);
end entity abcgate;

architecture trivial of abcgate is
    begin
    O <= A OR (B AND C) AFTER 487 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity Cin_map_G is
    port(A, B, Cin: in std_ulogic;
    O: out std_ulogic);
end entity Cin_map_G;

architecture trivial of Cin_map_G is
    begin
    O <= (A AND B) OR (Cin AND (A OR B)) AFTER 774 ps;
end architecture trivial;
