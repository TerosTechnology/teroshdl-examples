library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity StateMachine is
  port
  (
    clk  : in std_logic;
    Btn0 : in std_logic;
    Btn1 : in std_logic;
    LED1 : out std_logic);
  type fsm_state is (z1, z2, z3, z4, z3_dot, z3_double_dot);
end StateMachine;

architecture Behavioral of StateMachine is
  signal state : fsm_state := z1;
begin
  process (clk)
  begin
    if (clk = '1' and clk'EVENT) then
      if (Btn0 = '1' and Btn1 = '1') then
        --not defined
      else
        case state is
          when z1 =>
            if (Btn0 = '1') then
              state <= z1;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
          when z2 =>
            if (Btn0 = '1') then
              state <= z3;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
          when z3 =>
            if (Btn0 = '1') then
              state <= z3_dot;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
          when z3_dot =>
            if (Btn0 = '0' and Btn1 /= '1') then
              state <= z3_double_dot;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
          when z3_double_dot =>
            if (Btn0 = '1') then
              state <= z4;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
          when z4 =>
            if (Btn0 = '1') then
              state <= z4;
            end if;
            if (Btn1 = '1') then
              state <= z2;
            end if;
        end case;
      end if;
    end if;
  end process;

  process (state)
  begin
    case state is
      when z4 =>
        LED1 <= '1';
      when others =>
        LED1 <= '0';
    end case;
  end process;
end Behavioral;