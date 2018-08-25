library ieee;
use ieee.std_logic_1164.all;

entity nbit_add_tb is
end entity;

architecture tb of nbit_add_tb is
    component nbit_add is
        generic(    N       :   integer);
        port(       a       :   in std_logic_vector((N - 1) downto 0);
                    b       :   in std_logic_vector((N - 1) downto 0);
                    c_in    :   in std_logic;
                    s       :   out std_logic_vector((N - 1) downto 0);
                    c_out   :   out std_logic);
    end component;

    signal tb_clk   :   std_logic   := '0';
    signal tb_a     :   std_logic_vector(7 downto 0);
    signal tb_b     :   std_logic_vector(7 downto 0);
    signal tb_c_in  :   std_logic;
    signal tb_s     :   std_logic_vector(7 downto 0);
    signal tb_c_out :   std_logic;

begin

    tb_clk  <= not tb_clk after 10 ns;

    add0: nbit_add  generic map(    N       => 8)
                    port map(       a       => tb_a,
                                    b       => tb_b,
                                    c_in    => tb_c_in,
                                    s       => tb_s,
                                    c_out   => tb_c_out);

    process
        type pattern_type is record
            --inputs:
            a       :   std_logic_vector(7 downto 0);
            b       :   std_logic_vector(7 downto 0);
            c_in    :   std_logic;
            --outputs:
            s       :   std_logic_vector(7 downto 0);
            c_out   :   std_logic;
        end record;
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns   :   pattern_array   :=
            (   (x"11", x"11", '0', x"22", '0'),
                (x"22", x"22", '0', x"44", '0'),
                (x"44", x"44", '1', x"89", '0'),
                (x"80", x"80", '0', x"00", '1'));
    begin
        assert false report "Start of test." severity note;
        for i in patterns'range loop
            wait until rising_edge(tb_clk);
            tb_a    <=  patterns(i).a;
            tb_b    <=  patterns(i).b;
            tb_c_in <=  patterns(i).c_in;
            wait for 1 ns;
            assert tb_s = patterns(i).s
                report "Bad sum value." severity error;
            assert tb_c_out = patterns(i).c_out
                report "Bad c_out value." severity error; 
        end loop;
        assert false report "End of test." severity note;
        wait;
    end process;

end architecture;
