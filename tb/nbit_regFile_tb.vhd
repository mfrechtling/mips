library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_regFile_tb is
end entity;

architecture tb of nbit_regFile_tb is

	component nbit_regFile is 
		generic(n           :   integer); 
		port(	clk         :   in std_logic; 
				rst         :   in std_logic; 
				wr          :   in std_logic;
				rd_data1    :   out std_logic_vector((n - 1) downto 0); 
				rd_data2    :   out std_logic_vector((n - 1) downto 0); 
				wr_data     :   in std_logic_vector((n - 1) downto 0); 
				rd_addr1    :   in std_logic_vector(4 downto 0); 
				rd_addr2    :   in std_logic_vector(4 downto 0); 
				wr_addr     :   in std_logic_vector(4 downto 0)); 
	end component;
	
	signal tb_clk		:	std_logic						:= '0';
	signal tb_rst		:	std_logic						:= '0';
	signal tb_wr		:	std_logic						:= '0';
	signal tb_rd_data1	:	std_logic_vector(31 downto 0)	:=	(others => '0');	
	signal tb_rd_data2	:	std_logic_vector(31 downto 0)	:=	(others => '0');
	signal tb_wr_data	:	std_logic_vector(31 downto 0)	:=	(others => '0');
	signal tb_rd_addr1	:	std_logic_vector(4 downto 0)	:= 	(others => '0');
	signal tb_rd_addr2	:	std_logic_vector(4 downto 0)	:= 	(others => '0');
	signal tb_wr_addr	:	std_logic_vector(4 downto 0)	:= 	(others => '0');

begin

	tb_clk	<= not tb_clk after 10 ns;

	regFile0: nbit_regFile 	generic map(n			=> 32)
							port map(	clk 		=> tb_clk,
										rst 		=> tb_rst,
										wr 			=> tb_wr,
										rd_data1	=> tb_rd_data1,
										rd_data2 	=> tb_rd_data2,
										wr_data 	=> tb_wr_data,
										rd_addr1 	=> tb_rd_addr1,
										rd_addr2 	=> tb_rd_addr2,
										wr_addr 	=> tb_wr_addr);

	process
        type pattern_type is record
            --inputs
            rst     	:   std_logic;
            wr     		:   std_logic;
            wr_data     :   std_logic_vector(31 downto 0);
			wr_addr		:	std_logic_vector(4 downto 0);
			rd_addr1	:	std_logic_vector(4 downto 0);
			rd_addr2	:	std_logic_vector(4 downto 0);
            --outputs
            rd_data1    :   std_logic_vector(31 downto 0);
			rd_data2	:	std_logic_vector(31 downto 0);
        end record;
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns   :   pattern_array   :=
            (   ('1', '0', x"00000000", b"00000", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '1', x"aaaaaaaa", b"00001", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '1', x"bbbbbbbb", b"00010", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '1', x"cccccccc", b"00100", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '1', x"dddddddd", b"01000", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '1', x"deadbeef", b"10000", b"00000", b"00000", x"00000000", x"00000000"),
                ('0', '0', x"dddddddd", b"01000", b"00001", b"00010", x"aaaaaaaa", x"bbbbbbbb"),
                ('0', '0', x"dddddddd", b"01000", b"00010", b"00100", x"bbbbbbbb", x"cccccccc"),
                ('0', '0', x"dddddddd", b"01000", b"00100", b"01000", x"cccccccc", x"dddddddd"),
                ('0', '0', x"dddddddd", b"01000", b"01000", b"10000", x"dddddddd", x"deadbeef"),
                ('1', '0', x"dddddddd", b"01000", b"01000", b"10000", x"00000000", x"00000000"),
                ('1', '0', x"dddddddd", b"01000", b"01000", b"10000", x"00000000", x"00000000"));
    begin
        assert false report "Start of test." severity note;
        for i in patterns'range loop
            wait until rising_edge(tb_clk);
            tb_rst  	<=  patterns(i).rst;
            tb_wr   	<=  patterns(i).wr;
            tb_wr_data	<=  patterns(i).wr_data;
            tb_rd_addr1	<=  patterns(i).rd_addr1;
            tb_rd_addr2	<=  patterns(i).rd_addr2;
            tb_wr_addr	<=  patterns(i).wr_addr;
            wait for 1 ns;
            assert tb_rd_data1 = patterns(i).rd_data1
                report "Bad rd data1 value." severity error;
			assert tb_rd_data2 = patterns(i).rd_data2
				report "Bad rd data2 value." severity error;
        end loop;
        assert false report "End of test." severity note;
        wait;
    end process;				

end architecture tb;
