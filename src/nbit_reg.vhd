library ieee;
use ieee.std_logic_1164.all;

entity nbit_reg is
    generic(    N       :   integer);
    port(       clk     :   in std_logic,
                rst     :   in std_logic,
                wr      :   in std_logic,
                din     :   in std_logic_vector((N - 1) downto 0),
                dout    :   out std_logic_vector((N - 1) downto 0));
end entity

architecture rtl of nbit_reg is
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            dout <= (others => '0');
        elsif(rising_edge(clk)) then
            if (wr = '1') then
                dout <= din;
            else
                null;
            end if;
        end if;
    end process;
end architecture;
