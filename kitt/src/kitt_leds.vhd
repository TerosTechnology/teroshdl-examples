--! Kitt ligths

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity kitt_leds is
  generic (
    g_leds : integer := 8
  );
  port (
    clk_in : in std_logic;
    reset_in : in std_logic;
    leds_out : out std_logic_vector(g_leds - 1 downto 0)
  );
end entity;

architecture rtl of kitt_leds is

  constant zero_reg : std_logic_vector(g_leds - 1 downto 0) := (others => '0');
  type fsm is (start, left, right);

  signal leds_reg : std_logic_vector(g_leds - 1 downto 0) := (others => '0');
  signal leds_state : fsm := start;

begin

  leds_out <= leds_reg;

  process (clk_in)
  begin
    if (rising_edge(clk_in)) then
      if reset_in = '1' then
        leds_state <= start;
      else
        case leds_state is
          when start =>
            leds_reg <= std_logic_vector(to_unsigned(1, g_leds));
            leds_state <= left;
          when left =>
            leds_reg <= std_logic_vector(shift_left(unsigned(leds_reg), 1));
            if leds_reg(g_leds - 2) = '1' then
              leds_state <= right;
            end if;
          when right =>
            leds_reg <= std_logic_vector(shift_right(unsigned(leds_reg), 1));
            if leds_reg(1) = '1' then
              leds_state <= left;
            end if;
          when others =>
            leds_state <= start;
        end case;
      end if;
    end if;
  end process;
end architecture;