--! Copyright 2021
--! Ismael Pérez Rojo (ismaelprojo@gmail.com)
--!
--! This file is part of gamma_c.
--!
--! gamma_c is free software: you can redistribute it and/or modify
--! it under the terms of the GNU General Public License as published by
--! the Free Software Foundation, either version 3 of the License, or
--! (at your option) any later version.
--!
--! gamma_c is distributed in the hope that it will be useful,
--! but WITHOUT ANY WARRANTY; without even the implied warranty of
--! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--! GNU General Public License for more details.
--!
--! You should have received a copy of the GNU General Public License
--! along with gamma_c.  If not, see <https://www.gnu.org/licenses/>.

--! Módulo para la codificación de imágenes capturadas con scanner
--! Compresión de datos

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.gamma_tables.all;


--! {"name": "andGate_timed", "test" : "andgate_failing", 
--!   "description": "a full AND-gate test designed to fail", 
--!   "signal": [
--!    ["CLK",
--!     {"name": "CLK", "wave": "p......", "type":"std_logic", "period":"2"}],
--!    ["IN",
--!     {"name": "data_in", "wave": "x.1.x.1.x.....", "type": "std_logic"},
--!     {"name": "gamma_in", "wave": "x.............", "type": "std_logic"},
--!     {"name": "dv_in", "wave": "0.1.0.1.0.....", "type":"std_logic"}],
--!    ["OUT",
--!     {"name": "data_out", "wave": "x..1.x.1.x....", "type": "std_logic",},
--!     {"name": "dv_out", "wave": "0..1.0.1.0....", "type": "std_logic",}]
--! ]}

--! {reg:[
--!     { "name": "gamma_in",   "bits": 16, "attr": "config" },
--!     { "name": "not_used",   "bits": 16, type: 4 }
--! ]}



entity gamma is
generic (
  G_DATA_IN : integer:=12; --! Data bits in
  G_DATA_OUT : integer:=8  --! Data bits out
);
  port (
    clk      : in std_logic; --! Reloj del sistema
    reset    : in std_logic; --! Reset nivel alto
    dv_in    : in std_logic; --! Data valid in
    gamma_in : in std_logic_vector(15 downto 0); --! Configuración gamma. No usado
    data_in  : in std_logic_vector(G_DATA_IN-1 downto 0); --! Dato de entrada del ADC
    dv_out   : out std_logic; --! Data valid de salida
    data_out : out std_logic_vector(G_DATA_OUT-1 downto 0) --! Data out
  );
end entity gamma;

architecture rtl of gamma is

  signal sdata_out : std_logic_vector(G_DATA_OUT-1 downto 0) := (others => '0');
  signal sdv_out   : std_logic                    := '0';
  signal rom       : rom_t :=(gamma_table_025,gamma_table_045,gamma_table_075);

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        sdata_out <= (others => '0');
      else
        if dv_in = '1' then
          sdata_out <= rom(to_integer(unsigned(gamma_in)))(to_integer(unsigned(data_in)));
        else
          sdata_out <= (others => '0');
        end if;
      end if;
    end if;
  end process;

  out_proc : process (clk)
  begin
    if rising_edge(clk) then
      data_out <= sdata_out;
      sdv_out  <= dv_in;
      dv_out   <= sdv_out;
    end if;
  end process;

end architecture rtl;