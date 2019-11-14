library ieee;
use ieee.std_logic_1164.all;

entity nbit_regFile is
    generic(N           :   integer);
    port(   clk         :   in std_logic;
            rst         :   in std_logic;
            wr          :   in std_logic;
            din         :   in std_logic_vector((N - 1) downto 0);
            dout        :   out std_logic_vector((N - 1) downto 0);
            rd_addr1    :   in std_logic_vector(4 downto 0);
            rd_addr2    :   in std_logic_vector(4 downto 0);
            wr_addr     :   in std_logic_vector(4 downto 0));
end entity nbit_regFile;

architecture rtl of nbit_regFile is

begin


end architecture rtl;
