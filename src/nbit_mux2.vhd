library ieee;
use ieee.std_logic_1164.all;

entity nbit_mux2 is
    generic(    N   :   integer);
    port(       s   :   in std_logic;
                a   :   in std_logic_vector((N - 1) downto 0);
                b   :   in std_logic_vector((N - 1) downto 0);
                r   :   out std_logic_vector((N - 1) downto 0));
end entity;

architecture rtl of nbit_mux2 is
begin
    mux:    for i in (N - 1) downto 0 generate
                r(i)    <= (a(i) and (not s)) or (b(i) and s);
            end generate;
end architecture;
