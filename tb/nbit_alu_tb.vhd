library ieee;
use ieee.std_logic_1164.all;

entity nbit_alu_tb is
end entity;

architecture tb of nbit_alu_tb is
    component nbit_alu is
        generic(    N   :   integer);
        port(       a   :   in std_logic_vector((N - 1) downto 0);
                    b   :   in std_logic_vector((N - 1) downto 0);
                    s   :   in std_logic_vector(3 downto 0);
                    r   :   out std_logic_vector((N - 1) downto 0));
    end component;

    signal tb_clk   :   std_logic   :=  '0';
    signal tb_a     :   std_logic_vector(7 downto 0);
    signal tb_b     :   std_logic_vector(7 downto 0);
    signal tb_s     :   std_logic_vector(3 downto 0);
    signal tb_r     :   std_logic_vector(7 downto 0);
begin

    tb_clk  <=  not tb_clk after 10 ns;

    alu0: nbit_alu  generic map(    N   => 8)
                    port map(       a   => tb_a,
                                    b   => tb_b,
                                    s   => tb_s,
                                    r   => tb_r);
    
    process
        type pattern_type is record
            --inputs:
            a   :   std_logic_vector(7 downto 0);
            b   :   std_logic_vector(7 downto 0);
            s   :   std_logic_vector(3 downto 0);
            --outputs:
            r   :   std_logic_vector(7 downto 0);
        end record;
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns   :   pattern_array   :=
            ((x"77", x"55", "0000", x"55"),
            (x"77", x"55", "0001", x"77"),
            (x"77", x"55", "0010", x"cc"),
            (x"77", x"55", "0110", x"22"),
            (x"55", x"77", "0111", x"01"),
            (x"77", x"55", "1100", x"88"));
    begin
        assert false report "Start of test." severity note;
        for i in patterns'range loop
            wait until rising_edge(tb_clk);
            tb_a    <=  patterns(i).a;
            tb_b    <=  patterns(i).b;
            tb_s    <=  patterns(i).s;
            wait for 1 ns;
            assert tb_r = patterns(i).r
                report "Bad r value." severity error;
        end loop;
        assert false report "End of test." severity note;
        wait;
    end process;

end architecture;
