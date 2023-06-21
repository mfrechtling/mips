library ieee;
use ieee.std_logic_1164.all;

entity nbit_memory_tb is
end entity;

architecture tb of nbit_memory_tb is
	component nbit_memory is
		generic(	n		:	integer;
					size	:	integer;
					w		:	integer);
		port(		clk		:	in std_logic;
					rst		:	in std_logic;
					rd		:	in std_logic;
					wr		:	in std_logic;
					addr	:	in std_logic_vector((w - 1) downto 0);
					din		:	in std_logic_vector((n - 1) downto 0);
					dout	:	out std_logic_vector((n - 1) downto 0));
	end component;

	signal tb_clk	:	std_logic	:= '0';
	signal tb_rst	:	std_logic	:= '0';
	signal tb_rd	:	std_logic	:= '0';
	signal tb_wr	:	std_logic	:= '0';
	signal tb_addr	:	std_logic_vector(7 downto 0) 	:= (others => '0');
	signal tb_din	:	std_logic_vector(31 downto 0)	:= (others => '0');
	signal tb_dout 	:	std_logic_vector(31 downto 0)	:= (others => '0');

begin
	
	tb_clk <= not tb_clk after 10 ns;

	nbit_mem0: nbit_memory	generic map(	n 		=> 32,
											size	=> 256,
											w		=> 8)
							port map(		clk		=> tb_clk,
											rst		=> tb_rst,
											rd		=> tb_rd,
											wr		=> tb_wr,
											addr	=> tb_addr,
											din		=> tb_din,
											dout	=> tb_dout);

	process
		type pattern_type is record
			--inputs
			rst		:	std_logic;
			rd		:	std_logic;
			wr		:	std_logic;
			addr	:	std_logic_vector(7 downto 0);
			din		:	std_logic_vector(31 downto 0);
			--outputs
			dout	:	std_logic_vector(31 downto 0);
		end record;
		type pattern_array is array(natural range <>) of pattern_type;
		constant patterns	:	pattern_array	:=
			(	('1', '0', '0', x"00", x"00000000", x"00000000"),
				('1', '0', '0', x"00", x"00000000", x"00000000"),
				('0', '0', '1', x"01", x"12345678", x"00000000"),
				('0', '0', '1', x"02", x"87654321", x"00000000"),
				('0', '0', '1', x"04", x"deadbeef", x"00000000"),
				('0', '0', '1', x"08", x"abbaabba", x"00000000"),
				('0', '0', '1', x"10", x"beeffeed", x"00000000"),
				('0', '1', '0', x"01", x"00000000", x"12345678"),
				('0', '1', '0', x"02", x"00000000", x"87654321"),
				('0', '1', '0', x"04", x"00000000", x"deadbeef"),
				('0', '1', '0', x"08", x"00000000", x"abbaabba"),
				('0', '1', '0', x"10", x"00000000", x"beeffeed"),
				('1', '0', '0', x"00", x"00000000", x"00000000"),
				('0', '1', '0', x"01", x"00000000", x"00000000"),
				('0', '1', '0', x"02", x"00000000", x"00000000"),
				('0', '1', '0', x"04", x"00000000", x"00000000"),
				('0', '1', '0', x"08", x"00000000", x"00000000"),
				('0', '1', '0', x"10", x"00000000", x"00000000"));
	begin
		assert false report "Start of test." severity note;
		for i in patterns'range loop
			wait until rising_edge(tb_clk);
			tb_rst 	<= patterns(i).rst;
			tb_rd	<= patterns(i).rd;
			tb_wr	<= patterns(i).wr;
			tb_addr	<= patterns(i).addr;
			tb_din	<= patterns(i).din;
			wait for 1 ns;
			assert tb_dout = patterns(i).dout report "Bad dout value." severity error;
		end loop;
		assert false report "End of test." severity note;
		wait;
	end process;	

end architecture;
