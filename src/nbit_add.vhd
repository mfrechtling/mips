library ieee;
use ieee.std_logic_1164.all;

entity nbit_add is
    generic(    N       :   integer);
    port(       a       :   in std_logic_vector((N - 1) downto 0);
                b       :   in std_logic_vector((N - 1) downto 0);
                c_in    :   in std_logic;
                s       :   out std_logic_vector((N - 1) downto 0);
                c_out   :   out std_logic);
end entity;

architecture rtl of nbit_add is
    signal c   :   std_logic_vector(N downto 0);
begin

    add:    for i in (N - 1) downto 0 generate
                s(i)        <= (a(i) xor b(i)) xor c(i);
                c(i + 1)    <= (a(i) and b(i)) or ((a(i) xor b(i)) and c(i));
            end generate;

            c(0)    <=  c_in;
            c_out   <=  c(N);

end architecture;
