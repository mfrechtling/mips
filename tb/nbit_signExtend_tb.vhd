library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_signExtend_tb is
end entity nbit_signExtend_tb;

architecture tb of nbit_signExtend_tb is
	component nbit_signExtend is
		generic(    n   	:   integer);
		port(       din 	:   in std_logic_vector((n - 1) downto 0);
         			dout    :   out std_logic_vector(((2 * n) - 1) downto 0));
	end component nbit_signExtend;
	

	signal tb_clk	:	std_logic	:= '0';
	signal tb_din	:	std_logic_vector(15 downto 0)	:= (others => '0');
	signal tb_dout	:	std_logic_vector(31 downto 0)	:= (others => '0');

begin

	tb_clk	<= not tb_clk after 10 ns;

	nbit_ext0:	nbit_signExtend	generic map(n		=>	16)
								port map(	din		=>	tb_din,
											dout	=>	tb_dout);

	process
		type pattern_type is record
		--inputs
		din		:	std_logic_vector(15 downto 0);
		--outputs
		dout	:	std_logic_vector(31 downto 0);
		end record;
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns	:	pattern_array :=
			(	(x"0000", x"00000000"),
				(x"ffff", x"ffffffff"),
				(x"8abc", x"ffff8abc"),
				(x"dead", x"ffffdead"));
	begin
		assert false report "Start of test." severity note;
		for i in patterns'range loop
			wait until rising_edge(tb_clk);
			tb_din <= patterns(i).din;
			wait for 1 ns;
			assert tb_dout = patterns(i).dout report "Bad dout value." severity error;
		end loop;
		assert false report "End of test." severity note;
		wait;
	end process;	

end architecture;
