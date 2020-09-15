library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_regFile is
    generic(n           :   integer);
    port(   clk         :   in std_logic;
            rst         :   in std_logic;
            wr          :   in std_logic;
            rd_data1	:   out std_logic_vector((n - 1) downto 0);
			rd_data2	:   out std_logic_vector((n - 1) downto 0);
			wr_data		:	in std_logic_vector((n - 1) downto 0);
            rd_addr1    :   in std_logic_vector(4 downto 0);
            rd_addr2    :   in std_logic_vector(4 downto 0);
            wr_addr     :   in std_logic_vector(4 downto 0));
end entity nbit_regFile;

architecture rtl of nbit_regFile is
	component nbit_reg is
		generic(    n       :   integer);
		port(       clk     :   in std_logic;
					rst     :   in std_logic;
					wr      :   in std_logic;
					din     :   in std_logic_vector((n - 1) downto 0);
					dout    :   out std_logic_vector((n - 1) downto 0));
	end component;
	
	signal wr_decode	:	std_logic_vector(31 downto 0);
	type data_array is array(31 downto 0) of std_logic_vector((n - 1) downto 0);
	signal data_out		:	data_array;

begin
		wr_decode(0)	<= wr when wr_addr = "00000" else '0';
		wr_decode(1)	<= wr when wr_addr = "00001" else '0';
		wr_decode(2)	<= wr when wr_addr = "00010" else '0';
		wr_decode(3)	<= wr when wr_addr = "00011" else '0';
		wr_decode(4)	<= wr when wr_addr = "00100" else '0';
		wr_decode(5)	<= wr when wr_addr = "00101" else '0';
		wr_decode(6)	<= wr when wr_addr = "00110" else '0';
		wr_decode(7)	<= wr when wr_addr = "00111" else '0';
		wr_decode(8)	<= wr when wr_addr = "01000" else '0';
		wr_decode(9)	<= wr when wr_addr = "01001" else '0';
		wr_decode(10)	<= wr when wr_addr = "01010" else '0';
		wr_decode(11)	<= wr when wr_addr = "01011" else '0';
		wr_decode(12)	<= wr when wr_addr = "01100" else '0';
		wr_decode(13)	<= wr when wr_addr = "01101" else '0';
		wr_decode(14)	<= wr when wr_addr = "01110" else '0';
		wr_decode(15)	<= wr when wr_addr = "01111" else '0';
		wr_decode(16)	<= wr when wr_addr = "10000" else '0';
		wr_decode(17)	<= wr when wr_addr = "10001" else '0';
		wr_decode(18)	<= wr when wr_addr = "10010" else '0';
		wr_decode(19)	<= wr when wr_addr = "10011" else '0';
		wr_decode(20)	<= wr when wr_addr = "10100" else '0';
		wr_decode(21)	<= wr when wr_addr = "10101" else '0';
		wr_decode(22)	<= wr when wr_addr = "10110" else '0';
		wr_decode(23)	<= wr when wr_addr = "10111" else '0';
		wr_decode(24)	<= wr when wr_addr = "11000" else '0';
		wr_decode(25)	<= wr when wr_addr = "11001" else '0';
		wr_decode(26)	<= wr when wr_addr = "11010" else '0';
		wr_decode(27)	<= wr when wr_addr = "11011" else '0';
		wr_decode(28)	<= wr when wr_addr = "11100" else '0';
		wr_decode(29)	<= wr when wr_addr = "11101" else '0';
		wr_decode(30)	<= wr when wr_addr = "11110" else '0';
		wr_decode(31)	<= wr when wr_addr = "11111" else '0';

		reg_file:
			for i in 0 to 31 generate
				regx: nbit_reg 	generic map(n		=>	n)
								port map(	clk 	=> clk,
											rst		=> rst,
											wr		=> wr_decode(i),
											din		=> wr_data,
											dout	=> data_out(i));
			end generate;

		rd_data1 <= data_out(to_integer(unsigned(rd_addr1)));
		rd_data2 <= data_out(to_integer(unsigned(rd_addr2)));

end architecture rtl;
