------------------------------------------------------------
-- VHDL Sheet1
-- 2022 9 2 18 58 27
-- Created By "Altium Designer VHDL Generator"
-- "Copyright (c) 2002-2014 Altium Limited"
-- Product Version: 14.3.13.34012
------------------------------------------------------------

------------------------------------------------------------
-- VHDL Sheet1
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

Entity FPGA_Project Is
  port
  (
    CLK_BRD        : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=CLK_BRD
    JTAG_NEXUS_TCK : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TCK
    JTAG_NEXUS_TDI : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDI
    JTAG_NEXUS_TDO : Out   STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDO
    JTAG_NEXUS_TMS : In    STD_LOGIC                         -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TMS
  );
  attribute MacroCell : boolean;

End FPGA_Project;
------------------------------------------------------------

------------------------------------------------------------
Architecture Structure Of FPGA_Project Is
   Component CLKGEN                                          -- ObjectKind=Part|PrimaryId=U2|SecondaryId=1
      port
      (
        FREQ     : out STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-FREQ
        TCK      : in  STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-TCK
        TDI      : in  STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-TDI
        TDO      : out STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-TDO
        TIMEBASE : in  STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-TIMEBASE
        TMS      : in  STD_LOGIC;                            -- ObjectKind=Pin|PrimaryId=U2-TMS
        TRST     : in  STD_LOGIC                             -- ObjectKind=Pin|PrimaryId=U2-TRST
      );
   End Component;

   Component Configurable_U1                                 -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      port
      (
        AIN  : in  STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT : out STD_LOGIC_VECTOR(15 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AOUT[15..0]
        BIN  : in  STD_LOGIC_VECTOR(4 downto 0);             -- ObjectKind=Pin|PrimaryId=U1-BIN[4..0]
        BOUT : out STD_LOGIC_VECTOR(15 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-BOUT[15..0]
        COUT : out STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-COUT
        TCK  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TCK
        TDI  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDI
        TDO  : out STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDO
        TMS  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TMS
        TRST : in  STD_LOGIC                                 -- ObjectKind=Pin|PrimaryId=U1-TRST
      );
   End Component;

   Component multiplier                                      -- ObjectKind=Sheet Symbol|PrimaryId=U_multiplier
      port
      (
        a      : in  STD_LOGIC_VECTOR(15 downto 0);          -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-a[15..0]
        b      : in  STD_LOGIC_VECTOR(15 downto 0);          -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-b[15..0]
        clk    : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-clk
        count  : out STD_LOGIC_VECTOR(4 downto 0);           -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-count[4..0]
        r      : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-r
        result : out STD_LOGIC_VECTOR(31 downto 0)           -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-result[31..0]
      );
   End Component;


    Signal NamedSignal_JTAG_NEXUS_TRST   : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST
    Signal PinSignal_U_multiplier_count  : STD_LOGIC_VECTOR(4 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_BIN[4..0]
    Signal PinSignal_U_multiplier_result : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AIN[31..0]
    Signal PinSignal_U1_AOUT             : STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AOUT[15..0]
    Signal PinSignal_U1_BOUT             : STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_BOUT[15..0]
    Signal PinSignal_U1_COUT             : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU1_COUT
    Signal PinSignal_U1_TDO              : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_LINK0
    Signal PinSignal_U2_FREQ             : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU2_FREQ
    Signal PinSignal_U2_TDO              : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TDO
    Signal PowerSignal_VCC               : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST

   attribute VERILOGMODULE : string;
   attribute VERILOGMODULE of U_multiplier : Label is "multiplier";


Begin
    U_multiplier : multiplier                                -- ObjectKind=Sheet Symbol|PrimaryId=U_multiplier
      Port Map
      (
        a      => PinSignal_U1_AOUT,                         -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-a[15..0]
        b      => PinSignal_U1_BOUT,                         -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-b[15..0]
        clk    => PinSignal_U2_FREQ,                         -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-clk
        count  => PinSignal_U_multiplier_count,              -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-count[4..0]
        r      => PinSignal_U1_COUT,                         -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-r
        result => PinSignal_U_multiplier_result              -- ObjectKind=Sheet Entry|PrimaryId=multiplicador.v-result[31..0]
      );

    U2 : CLKGEN                                              -- ObjectKind=Part|PrimaryId=U2|SecondaryId=1
      Port Map
      (
        FREQ     => PinSignal_U2_FREQ,                       -- ObjectKind=Pin|PrimaryId=U2-FREQ
        TCK      => JTAG_NEXUS_TCK,                          -- ObjectKind=Pin|PrimaryId=U2-TCK
        TDI      => PinSignal_U1_TDO,                        -- ObjectKind=Pin|PrimaryId=U2-TDI
        TDO      => PinSignal_U2_TDO,                        -- ObjectKind=Pin|PrimaryId=U2-TDO
        TIMEBASE => CLK_BRD,                                 -- ObjectKind=Pin|PrimaryId=U2-TIMEBASE
        TMS      => JTAG_NEXUS_TMS,                          -- ObjectKind=Pin|PrimaryId=U2-TMS
        TRST     => NamedSignal_JTAG_NEXUS_TRST              -- ObjectKind=Pin|PrimaryId=U2-TRST
      );

    U1 : Configurable_U1                                     -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      Port Map
      (
        AIN  => PinSignal_U_multiplier_result,               -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT => PinSignal_U1_AOUT,                           -- ObjectKind=Pin|PrimaryId=U1-AOUT[15..0]
        BIN  => PinSignal_U_multiplier_count,                -- ObjectKind=Pin|PrimaryId=U1-BIN[4..0]
        BOUT => PinSignal_U1_BOUT,                           -- ObjectKind=Pin|PrimaryId=U1-BOUT[15..0]
        COUT => PinSignal_U1_COUT,                           -- ObjectKind=Pin|PrimaryId=U1-COUT
        TCK  => JTAG_NEXUS_TCK,                              -- ObjectKind=Pin|PrimaryId=U1-TCK
        TDI  => JTAG_NEXUS_TDI,                              -- ObjectKind=Pin|PrimaryId=U1-TDI
        TDO  => PinSignal_U1_TDO,                            -- ObjectKind=Pin|PrimaryId=U1-TDO
        TMS  => JTAG_NEXUS_TMS,                              -- ObjectKind=Pin|PrimaryId=U1-TMS
        TRST => NamedSignal_JTAG_NEXUS_TRST                  -- ObjectKind=Pin|PrimaryId=U1-TRST
      );

    -- Signal Assignments
    ---------------------
    JTAG_NEXUS_TDO              <= PinSignal_U2_TDO; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TDO
    NamedSignal_JTAG_NEXUS_TRST <= PowerSignal_VCC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST
    PowerSignal_VCC             <= '1'; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST

End Structure;
------------------------------------------------------------

