library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_signExtend is
	generic(	n		:	integer);
	port(		din		:	in std_logic_vector((n - 1) downto 0);
				dout	:	out std_logic_vector(((2 * n) - 1) downto 0));
end entity nbit_signExtend;

architecture rtl of nbit_signExtend is
begin

	lower:
		for i in 0 to (n - 1) generate
			dout(i) <= din(i);
		end generate;

	upper:
		for i in n to ((2 * n) - 1) generate
			dout(i) <= din(n - 1);
		end generate;

end architecture;
