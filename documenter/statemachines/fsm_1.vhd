ENTITY state_machine IS
   PORT(
      clk      : IN   STD_LOGIC;
      input    : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC;
      output   : OUT  STD_LOGIC_VECTOR(1 downto 0));
END state_machine;
ARCHITECTURE a OF state_machine IS
   TYPE STATE_TYPE IS (s0, s1, s2);
   SIGNAL state   : STATE_TYPE;
BEGIN
   PROCESS (clk, reset)
   BEGIN
      IF reset = '1' THEN
         state <= s0;
      ELSIF (clk'EVENT AND clk = '1') THEN
         CASE state IS
            WHEN s0=>
               IF input = '1' THEN
                  state <= s1;
               ELSE
                  state <= s0;
               END IF;
            WHEN s1=>
               IF input = '1' THEN
                  state <= s2;
               ELSE
                  state <= s1;
               END IF;
            WHEN s2=>
               IF input = '1' THEN
                  state <= s0;
               ELSE
                  state <= s2;
               END IF;
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (state)
   BEGIN
      CASE state IS
         WHEN s0 =>
            output <= "00";
         WHEN s1 =>
            output <= "01";
         WHEN s2 =>
            output <= "10";
      END CASE;
   END PROCESS;
   
END a;