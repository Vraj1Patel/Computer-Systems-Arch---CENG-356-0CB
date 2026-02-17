library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity ALU is
  generic (n : integer);
  port (
    A    : in  std_logic_vector((n-1) downto 0);
    B    : in  std_logic_vector((n-1) downto 0);
    S    : in  std_logic_vector(2 downto 0);

    RSLT : out std_logic_vector((n-1) downto 0);
    OVF  : out std_logic;
    CF   : out std_logic;
    NF   : out std_logic;
    ZF   : out std_logic
  );
end ALU;

architecture RTL of ALU is

  component CLA
    generic (n : integer);
    port (
      A    : in  std_logic_vector((n-1) downto 0);
      B    : in  std_logic_vector((n-1) downto 0);
      CIN  : in  std_logic;
      COUT : out std_logic;
      SUM  : out std_logic_vector((n-1) downto 0)
    );
  end component;

  component Mux
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
  end component;

  signal C_l   : std_logic;
  signal Sub   : std_logic;
  signal B_l   : std_logic_vector((n-1) downto 0);
  signal Sum   : std_logic_vector((n-1) downto 0);

  signal R_And : std_logic_vector((n-1) downto 0);
  signal R_Or  : std_logic_vector((n-1) downto 0);
  signal R_Xor : std_logic_vector((n-1) downto 0);
  signal NotA  : std_logic_vector((n-1) downto 0);
  signal R_Shl : std_logic_vector((n-1) downto 0);
  signal R_Shr : std_logic_vector((n-1) downto 0);

  signal Zero  : std_logic_vector((n-1) downto 0);

  -- ? internal result (so we can READ it for flags)
  signal R_int : std_logic_vector((n-1) downto 0);

begin

  Zero <= (others => '0');

  -- Logic operations
  R_And <= A and B;
  R_Or  <= A or  B;
  R_Xor <= A xor B;
  NotA  <= not A;

  -- Shift operations
  R_Shr <= '0' & A((n-1) downto 1);
  R_Shl <= A((n-2) downto 0) & '0';

  -- Add/Sub using CLA
  Sub <= '1' when S = "001" else '0';
  B_l <= (not B) when Sub = '1' else B;

  AddSub : CLA
    generic map (n => n)
    port map (
      A    => A,
      B    => B_l,
      CIN  => Sub,
      COUT => C_l,
      SUM  => Sum
    );

  -- Select final ALU output
  DataSelect : Mux
    generic map (n => n)
    port map (
      D0  => Sum,    -- 000: A + B
      D1  => Sum,    -- 001: A - B
      D2  => R_And,  -- 010: AND
      D3  => R_Or,   -- 011: OR
      D4  => R_Xor,  -- 100: XOR
      D5  => NotA,   -- 101: NOT A
      D6  => R_Shr,  -- 110: Shift Right A
      D7  => R_Shl,  -- 111: Shift Left A
      SEL => S,
      Y   => R_int
    );

  -- ? drive output port from internal signal
  RSLT <= R_int;

  -- Flags
  CF <= C_l;
  NF <= R_int(n-1);
  ZF <= '1' when R_int = Zero else '0';

  -- Overflow (meaningful for add/sub)
  OVF <= (not Sub and (A(n-1) xnor B(n-1)) and (Sum(n-1) xor A(n-1))) or
       (Sub     and (A(n-1) xor  B(n-1))  and (Sum(n-1) xor A(n-1)));

end RTL;
