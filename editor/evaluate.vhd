library ieee;
use ieee.std_logic_1164.all;

entity evaluate_example is

    -- Unsigned binary: 3
    constant e_binary_unsigned : std_logic_vector := "011";
    -- Signed binary: 7 (unsigned), -1 (signed)
    constant e_binary_signed : std_logic_vector := "111";
    -- Unsigned octal: 19
    constant e_oct : std_logic_vector := O"23";
    -- Unsigned hexadecimal: 35
    constant e_hex : std_logic_vector := X"23";

end evaluate_example;  

architecture behv1 of evaluate_example is
begin

end behv1;