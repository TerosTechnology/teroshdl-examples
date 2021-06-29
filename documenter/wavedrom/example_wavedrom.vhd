-- This file is public domain, it can be freely copied without restrictions.
-- SPDX-License-Identifier: CC0-1.0
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

--! This is a **Wavedrom** example:
--! { signal: [
--!   { name: "pclk", wave: 'p.......' },
--!   { name: "Pclk", wave: 'P.......' },
--!   { name: "nclk", wave: 'n.......' },
--!   { name: "Nclk", wave: 'N.......' },
--!   {},
--!   { name: 'clk0', wave: 'phnlPHNL' },
--!   { name: 'clk1', wave: 'xhlhLHl.' },
--!   { name: 'clk2', wave: 'hpHplnLn' },
--!   { name: 'clk3', wave: 'nhNhplPl' },
--!   { name: 'clk4', wave: 'xlh.L.Hx' },
--! ]}

entity example_wavedrom is
  generic (

    DATA_WID : positive := 4);
  port (
    A : in  unsigned(DATA_WID-1 downto 0); --! A input
    B : in  unsigned(DATA_WID-1 downto 0); --! B input
    X : out unsigned(DATA_WID downto 0) --! Output adder
  );  
end entity example_wavedrom;

architecture rtl of example_wavedrom is
begin

end architecture rtl;