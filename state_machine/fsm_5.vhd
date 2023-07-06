-- https://surf-vhdl.com/how-to-implement-a-finite-state-machine-in-vhdl/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_5 is
  port
  (
    i_clk            : in std_logic;
    i_rstb           : in std_logic;
    i_refund_request : in std_logic; -- 1 clock pulse
    -- from product selector
    i_product_sel       : in std_logic; -- '0'=> product 1, '1'=> product 2
    i_product_sel_valid : in std_logic; -- 1 clock pulse
    -- from money check
    i_money_value       : in std_logic; -- '0' => 1 dollar; '1' => five dollars
    i_money_value_valid : in std_logic; -- 1 clock pulse
    -- to product delivery
    o_product_delivery_sel     : out std_logic; -- '0'=> product 1, '1'=> product 2
    o_product_delivery_sel_ena : out std_logic; -- 1 clock pulse
    -- to delivery refund
    o_money_refund_value     : out std_logic_vector(3 downto 0); -- refund value, up to 15 dollars = (2^4)-1
    o_money_refund_value_ena : out std_logic); -- 1 clock pulse
    
end fsm_5;

architecture rtl of fsm_5 is

  constant C_PRICE_PRODUCT_1 : integer := 1;
  constant C_PRICE_PRODUCT_2 : integer := 3;
  type t_money_table is array(0 to 1) of integer range 1 to 5;
  constant money_table : t_money_table := (1, 5);
  type t_control_logic_fsm is (
    ST_RESET,
    ST_ST_GET_PROD_REQ,
    ST_CHECK_CREDIT,
    ST_PROVIDE_PRODUCT,
    ST_PROVIDE_TOTAL_REFUND,
    ST_PROVIDE_REFUND);
  signal r_price_product         : integer range 1 to 3;
  signal r_price_product_counter : integer range 0 to 15;
  signal r_refund                : integer range 0 to 15;
  signal w_money_value           : integer range 1 to 15;
  signal r_st_present            : t_control_logic_fsm;
  signal w_st_next               : t_control_logic_fsm;

begin

  w_money_value <= money_table(0) when (i_money_value = '0') else
    money_table(1);

  p_state : process (i_clk, i_rstb)
  begin
    if (i_rstb = '0') then
      r_st_present <= ST_RESET;
    elsif (rising_edge(i_clk)) then
      r_st_present <= w_st_next;
    end if;
  end process p_state;

  p_comb : process (
    r_st_present,
    i_product_sel_valid,
    i_refund_request,
    r_price_product_counter,
    r_price_product
    )
  begin
    case r_st_present is
      when ST_ST_GET_PROD_REQ =>
        w_st_next <= ST_CHECK_CREDIT;

      when ST_CHECK_CREDIT =>
        if (r_price_product_counter >= r_price_product) then
          w_st_next <= ST_PROVIDE_PRODUCT;
        elsif (i_refund_request = '1') then
          w_st_next <= ST_PROVIDE_TOTAL_REFUND;
        else
          w_st_next <= ST_CHECK_CREDIT;
        end if;

      when ST_PROVIDE_PRODUCT =>
        w_st_next <= ST_PROVIDE_REFUND;

      when ST_PROVIDE_REFUND =>
        w_st_next <= ST_RESET;

      when ST_PROVIDE_TOTAL_REFUND =>
        w_st_next <= ST_RESET;

      when others =>
        if (i_product_sel_valid = '1') then
          w_st_next <= ST_ST_GET_PROD_REQ;
        else
          w_st_next <= ST_RESET;
        end if;
    end case;

  end process p_comb;

  p_state_out : process (i_clk, i_rstb)
  begin

    if (i_rstb = '0') then
      r_price_product            <= C_PRICE_PRODUCT_1;
      r_price_product_counter    <= 0;
      r_refund                   <= 0;
      o_money_refund_value_ena   <= '0';
      o_product_delivery_sel     <= '0';
      o_product_delivery_sel_ena <= '0';

    elsif (rising_edge(i_clk)) then
      case r_st_present is
        when ST_ST_GET_PROD_REQ =>
          if (i_product_sel = '0') then
            r_price_product <= C_PRICE_PRODUCT_1;
          else
            r_price_product <= C_PRICE_PRODUCT_2;
          end if;
          o_money_refund_value_ena   <= '0';
          o_product_delivery_sel     <= i_product_sel;
          o_product_delivery_sel_ena <= '0';

        when ST_CHECK_CREDIT =>
          if (i_money_value_valid = '1') then
            r_price_product_counter <= r_price_product_counter + w_money_value;
          end if;

        when ST_PROVIDE_PRODUCT =>
          o_product_delivery_sel_ena <= '1';
          o_money_refund_value_ena   <= '0';

        when ST_PROVIDE_REFUND =>
          r_refund                   <= r_price_product_counter - r_price_product;
          o_product_delivery_sel_ena <= '0';
          o_money_refund_value_ena   <= '1';

        when ST_PROVIDE_TOTAL_REFUND =>
          r_refund                   <= r_price_product_counter;
          o_product_delivery_sel_ena <= '0';
          o_money_refund_value_ena   <= '1';

        when others =>
          r_price_product_counter    <= 0;
          r_refund                   <= 0;
          o_product_delivery_sel_ena <= '0';
          o_money_refund_value_ena   <= '0';
      end case;
    end if;
  end process p_state_out;

  o_money_refund_value <= std_logic_vector(to_unsigned(r_refund, 4));

end rtl;