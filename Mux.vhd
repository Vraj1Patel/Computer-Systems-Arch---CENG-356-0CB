library ieee;
use ieee.std_logic_1164.all;

entity Mux is
  generic (n : integer);
  port (
    D0  : in  std_logic_vector((n-1) downto 0);
    D1  : in  std_logic_vector((n-1) downto 0);
    D2  : in  std_logic_vector((n-1) downto 0);
    D3  : in  std_logic_vector((n-1) downto 0);
    D4  : in  std_logic_vector((n-1) downto 0);
    D5  : in  std_logic_vector((n-1) downto 0);
    D6  : in  std_logic_vector((n-1) downto 0);
    D7  : in  std_logic_vector((n-1) downto 0);
    SEL : in  std_logic_vector(2 downto 0);
    Y   : out std_logic_vector((n-1) downto 0)
  );
end Mux;

architecture RTL of Mux is
begin
  Y <= D0 when SEL = "000" else
       D1 when SEL = "001" else
       D2 when SEL = "010" else
       D3 when SEL = "011" else
       D4 when SEL = "100" else
       D5 when SEL = "101" else
       D6 when SEL = "110" else
       D7;  -- SEL = "111"
end RTL;
