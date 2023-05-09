library ieee;
use ieee.std_logic_1164.all;

--! This is a **multiline**
--! entity description using **MarkDown**
entity documenter_basic_example is
  generic
  (
    --! over port description
    --! **multiline**
    generic_0 : integer := 0;
    generic_1 : integer := 1; --! inline description
    --! this is `a cool description`
    generic_2 : std_logic := '1'
  );

  port
  (
    --! over port description
    --! **multiline**
    input_0 : in std_logic;
    input_1 : in std_logic; --! inline description
    --! this is `a cool description`
    output_0 : out std_logic_version(10 downto 0)
  );
end documenter_basic_example;

architecture behv1 of documenter_basic_example is

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
begin

  --! This is a **multiline**
  --! process description
  my_proc : process (input_0)
  begin
    if rising_edge(input_0) then

    end if;
  end process;

  --! Sample instance
  --! documentation
  sample_dpe_inst : entity work.sample_dpe
  port map (
    input_0 => input_0,
    input_1 => input_1,
    output_0 => output_0
  );


end behv1;