library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

--! This is a **multiline**
--! package description using **MarkDown**
package documenter_basic_package_example is
 
  --! **over** description 0
  constant C_MY_CONSTANT_0 : integer := 21;

  --! **over** description 1
  constant C_MY_CONSTANT_1 : integer := 22;

  --! **type** description
  type my_small is range -5 to 5;

  --! Calculate the number of clock cycles in minutes/seconds
  function CounterVal(m : integer := 0; s : integer := 0) return integer is 
    variable ts : integer;
  begin
    ts := s + m * 60;
    return ts * 10 - 1;
  end function;

  signal my_signal : std_logic_vector(3 downto 0); --! **inline** description
   
  end package documenter_basic_package_example;