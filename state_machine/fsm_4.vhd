library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_logic is
 port (
  i_clk       : in  std_logic;
  i_rstb      : in  std_logic;
  -- input
  i_input1    : in  std_logic;
  i_input2    : in  std_logic;
  -- output
  o_output1   : out std_logic;
  o_output2   : out std_logic;
  o_output3   : out std_logic);
end control_logic;

architecture rtl of control_logic is
  type t_control_logic_fsm is (
                            ST_S1      ,
                            ST_S2      ,
                            ST_S3      );
  signal r_st_present    : t_control_logic_fsm;
  signal w_st_next       : t_control_logic_fsm;
begin

  p_state : process(i_clk,i_rstb)
  begin
    if(i_rstb='0') then
      r_st_present            <= ST_S3;
    elsif(rising_edge(i_clk)) then
      r_st_present            <= w_st_next;
    end if;
  end process p_state;

  p_comb : process(r_st_present, i_input1, i_input2)
  begin
    case r_st_present is
      when ST_S1 => 
        if (i_input1='1') then  
          w_st_next  <= ST_S2;
        else                                                         
          w_st_next  <= ST_S1;
        end if;
      when ST_S2 => 
        if (i_input1='0') and (i_input2='1')then  
          w_st_next  <= ST_S3;
        else                                                         
          w_st_next  <= ST_S2;
        end if;
      when others=>
        w_st_next  <= ST_S1;
    end case;
  end process p_comb;

  p_state_out : process(i_clk,i_rstb)
  begin
    if(i_rstb='0') then
      o_output1     <= '0';
      o_output2     <= '0';
      o_output3     <= '0';
    elsif(rising_edge(i_clk)) then
      case r_st_present is
        when ST_S1        =>
          o_output1     <= '1';
          o_output2     <= '0';
          o_output3     <= '0';
        when ST_S2        =>
          o_output1     <= '0';
          o_output2     <= '1';
          o_output3     <= '0';
        when others =>
          o_output1     <= '0';
          o_output2     <= '0';
          o_output3     <= '1';
      end case;
    end if;
  end process p_state_out;
  
end rtl;