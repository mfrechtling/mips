library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_memory is
	generic(	n		:	integer,
				size	:	integer,
				w		:	integer);
	port(		clk		:	in std_logic,
				rst		:	in std_logic,
				rd		:	in std_logic,
				wr		:	in std_logic,
				addr	:	in std_logic_vector((w - 1) downto 0),
				din		:	in std_logic_vector((n - 1) downto 0),
				dout	:	out std_logic_vector((n - 1) downto 0));
end entity;

architecture rtl of nbit_memory is
	type mem_array is array(0 to (size - 1)) of std_logic_vector((n - 1) downto 0);
	signal mem	:	mem_array := (others => (others => '0'));
begin

	dout <= mem(to_integer(unsigned(addr))) when rd = '1' else (others => '0');

	process(clk, rst)
	begin
		if (rst = '1') then
			mem <= (others => (others => '0'));
		elsif (rising_edge(clk)) then
			if (wr = '1') then
				mem(to_integer(unsigned(addr))) <= din;
			else
				null;
			end if;
		end if
	end process;

end architecture;
