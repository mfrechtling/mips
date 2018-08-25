library ieee;
use ieee.std_logic_1164.all;

entity nbit_mux2_tb is
end entity;

architecture tb of nbit_mux2_tb is
    component nbit_mux2 is
        generic(    N   :   integer);
        port(       s   :   in std_logic;
                    a   :   in std_logic_vector((N - 1) downto 0);
                    b   :   in std_logic_vector((N - 1) downto 0);
                    r   :   out std_logic_vector((N - 1) downto 0));
    end component;

    signal tb_clk   :   std_logic   :=  '0';
    signal tb_s     :   std_logic;
    signal tb_a     :   std_logic_vector(31 downto 0);
    signal tb_b     :   std_logic_vector(31 downto 0);
    signal tb_r     :   std_logic_vector(31 downto 0);
begin
    tb_clk  <= not tb_clk after 10 ns;

    nbit_mux20: nbit_mux2   generic map(    N   =>  32)
                            port map(       s   =>  tb_s,
                                            a   =>  tb_a,
                                            b   =>  tb_b,
                                            r   =>  tb_r);
    
    process
        type pattern_type is record
            --inputs:
            s   :   std_logic;
            a   :   std_logic_vector(31 downto 0);
            b   :   std_logic_vector(31 downto 0);
            --outputs:
            r   :   std_logic_vector(31 downto 0);
        end record;
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns   :   pattern_array   :=
            (   ('0', x"aaaaaaaa", x"bbbbbbbb", x"aaaaaaaa"),
                ('0', x"12345678", x"bbbbbbbb", x"12345678"),
                ('0', x"12345678", x"cccccccc", x"12345678"),
                ('1', x"89abcdef", x"cccccccc", x"cccccccc"),
                ('1', x"89abcdef", x"deadbeef", x"deadbeef"));
    begin
        assert false report "Start of test." severity note;
        for i in patterns'range loop
            wait until rising_edge(tb_clk);
            tb_s    <=  patterns(i).s;
            tb_a    <=  patterns(i).a;
            tb_b    <=  patterns(i).b;
            wait for 1 ns;
            assert tb_r = patterns(i).r report "Bad data out vaule." severity error;
        end loop;
        assert false report "End of test." severity note;
        wait;
    end process;

end architecture;
    


