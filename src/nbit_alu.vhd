library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_alu is
    generic(    N   :   integer);
    port(       a   :   in std_logic_vector((N - 1) downto 0);
                b   :   in std_logic_vector((N - 1) downto 0);
                s   :   in std_logic_vector(3 downto 0);
                r   :   out std_logic_vector((N - 1) downto 0));
end entity;

architecture rtl of nbit_alu is
    signal r_and    :   std_logic_vector((N - 1) downto 0);
    signal r_or     :   std_logic_vector((N - 1) downto 0);
    signal r_add    :   std_logic_vector((N - 1) downto 0);
    signal r_sub    :   std_logic_vector((N - 1) downto 0);
    signal r_slt    :   std_logic_vector((N - 1) downto 0);
    signal r_nor    :   std_logic_vector((N - 1) downto 0);
begin

    with s select r <=  
        r_and           when "0000",
        r_or            when "0001",
        r_add           when "0010",
        r_sub           when "0110",
        r_slt           when "0111",
        r_nor           when "1100",
        (others => '0') when others;

    r_and                   <=  a and b;
    r_or                    <=  a or b;
    r_add                   <=  std_logic_vector(unsigned(a) + unsigned(b));
    r_sub                   <=  std_logic_vector(unsigned(a) - unsigned(b));
    r_slt(0)                <=  '1' when unsigned(a) < unsigned(b) else '0';
    r_slt((N - 1) downto 1) <=  (others => '0');
    r_nor                   <=  a nor b;

end architecture;
