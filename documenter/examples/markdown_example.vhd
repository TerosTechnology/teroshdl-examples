-- This file is public domain, it can be freely copied without restrictions.
-- SPDX-License-Identifier: CC0-1.0
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

--! This example uses as symbol to extract the comment "!". It
--! can be configured in TerosHDL.
--! You can use Markdown github flavour tags. A table example:
--!
--! | t0 | table | example |
--! |----|-------|---------|
--! | 1  | 10    | 9       |
--! | 2  | 4     | 5       |
--! | 33 | 12    | 22      |
--!
--! Other table:
--!
--! | t0 | fix | example |
--! |----|-----|---------|
--! | 1  | 10  | 9       |
--! | 2  | 4   | 5       |
--! | 33 | 12  | 22      |

entity adder is
  generic (

    DATA_WID : positive := 4);
  port (
    A : in    unsigned(DATA_WID-1 downto 0); --! A input
    B : in    unsigned(DATA_WID-1 downto 0); --! B input
    X : out   unsigned(DATA_WID downto 0) --! Output adder
  );  
end entity adder;

architecture rtl of adder is
  constant cnt_SAMPLE_0 : integer := 0;

  --! Example **bold description in** constant
  constant cnt_SAMPLE_1 : integer := 0;
  
  signal signal_example : std_logic;
begin
  signal_example <= '0';

  --! Description in process
  add_proc : process (A, B) is
  begin
    X <= resize(A, X'length) + B;
  end process add_proc;

  --! Instantiation description example
  --! with **markdown bold**
  MUX_1 : mux
    generic map (n => 2)
    port map (
      sel => '1',
      din => '1',
      q => '0'
    );


end architecture rtl;