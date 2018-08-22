library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_reg_tb is
end entity;

architecture tb of nbit_reg_tb is
    component nbit_reg is
        generic(    N       :   integer);
        port(       clk     :   in std_logic;
                    rst     :   in std_logic;
                    wr      :   in std_logic;
                    din     :   in std_logic_vector((N - 1) downto 0);
                    dout    :   out std_logic_vector((N - 1) downto 0));
    end component;
    
    signal tb_clk   :   std_logic   := '0';
    signal tb_rst   :   std_logic   := '0';
    signal tb_wr    :   std_logic   := '0';
    signal tb_din   :   std_logic_vector(31 downto 0)   :=  (others => '0');
    signal tb_dout  :   std_logic_vector(31 downto 0)   :=  (others => '0');
begin

    tb_clk <= not tb_clk after 10 ns;

    nbit_reg0: nbit_reg generic map(    N       => 32)
                        port map(       clk     => tb_clk,
                                        rst     => tb_rst,
                                        wr      => tb_wr,
                                        din     => tb_din,
                                        dout    => tb_dout);

    process
        type pattern_type is record
            --inputs
            rst     :   std_logic;
            wr      :   std_logic;
            din     :   std_logic_vector(31 downto 0);
            --outputs
            dout    :   std_logic_vector(31 downto 0);
        end record;
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns   :   pattern_array   :=
            (   ('1', '0', x"00000000", x"00000000"),
                ('0', '1', x"aaaaaaaa", x"00000000"),
                ('0', '1', x"bbbbbbbb", x"aaaaaaaa"), 
                ('0', '1', x"cccccccc", x"bbbbbbbb"),
                ('0', '0', x"deadbeef", x"cccccccc"),
                ('0', '0', x"00000000", x"cccccccc"),
                ('1', '0', x"bbbbbbbb", x"00000000"),
                ('0', '1', x"deadbeef", x"00000000"),
                ('0', '0', x"bbbbbbbb", x"deadbeef"),
                ('0', '0', x"bbbbbbbb", x"deadbeef"),
                ('1', '0', x"bbbbbbbb", x"00000000"));
    begin
        assert false report "Start of test." severity note;
        for i in patterns'range loop
            wait until rising_edge(tb_clk);
            tb_rst  <=  patterns(i).rst;
            tb_wr   <=  patterns(i).wr;
            tb_din  <=  patterns(i).din;
            wait for 1 ns;
            assert tb_dout = patterns(i).dout
                report "Bad data out value." severity error;
        end loop;
        assert false report "End of test." severity note;
        wait;
    end process;
end architecture tb;

