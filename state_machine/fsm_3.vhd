-- edgeDetector.vhd
-- Moore and Mealy Implementation

library ieee;
use ieee.std_logic_1164.all; 

entity edgeDetector is
port(
    clk, reset : in std_logic;
    level : in std_logic;
    Mealy_tick, Moore_tick: out std_logic 
);
end edgeDetector;

architecture arch of edgeDetector is 
    type stateMealy_type is (zero, one); -- 2 states are required for Mealy
    signal stateMealy_reg, stateMealy_next : stateMealy_type;
    
    type stateMoore_type is (zero, edge, one); -- 3 states are required for Moore
    signal stateMoore_reg, stateMoore_next : stateMoore_type;
    
begin   
    process(clk, reset)
    begin
        if (reset = '1') then -- go to state zero if reset
            stateMoore_reg <= zero;
            stateMealy_reg <= zero;
        elsif (clk'event and clk = '1') then -- otherwise update the states
            stateMoore_reg <= stateMoore_next;
            stateMealy_reg <= stateMealy_next;
        else
            null;
        end if; 
    end process;

    process(stateMealy_reg, level)
    begin 
        -- store current state as next
        stateMealy_next <= stateMealy_reg; --required: when no case statement is satisfied
        
        Mealy_tick <= '0';  -- set tick to zero (so that 'tick = 1' is available for 1 cycle only)
        case stateMealy_reg is 
            when zero =>  -- set 'tick = 1' if state = zero and level = '1'
                if level = '1' then -- if level is 1, then go to state one,
                    stateMealy_next <= one; -- otherwise remain in same state.
                    Mealy_tick <= '1';
                end if; 
            when one =>  
                if level = '0' then  -- if level is 0, then go to zero state,
                    stateMealy_next <= zero; -- otherwise remain in one state.
                end if;
        end case; 
    end process;
    
    process(stateMoore_reg, level)
    begin 
        -- store current state as next
        stateMoore_next <= stateMoore_reg; -- required: when no case statement is satisfied
        
        Moore_tick <= '0'; -- set tick to zero (so that 'tick = 1' is available for 1 cycle only)
        case stateMoore_reg is 
            when zero => -- if state is zero, 
                if level = '1' then  -- and level is 1
                    stateMoore_next <= edge; -- then go to state edge.
                end if; 
            when edge => 
                Moore_tick <= '1'; -- set the tick to 1.
                if level = '1' then -- if level is 1, 
                    stateMoore_next <= one; --go to state one,
                else 
                    stateMoore_next <= zero; -- else go to state zero.
                end if;
            when one =>
                if level = '0' then -- if level is 0, 
                    stateMoore_next <= zero; -- then go to state zero.
                end if;
        end case; 
    end process;  
end arch; 
    
