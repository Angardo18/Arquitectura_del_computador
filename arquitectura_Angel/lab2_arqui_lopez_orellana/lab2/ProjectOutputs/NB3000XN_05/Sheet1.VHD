------------------------------------------------------------
-- VHDL Sheet1
-- 2022 8 5 18 22 40
-- Created By "Altium Designer VHDL Generator"
-- "Copyright (c) 2002-2014 Altium Limited"
-- Product Version: 14.3.13.34012
------------------------------------------------------------

------------------------------------------------------------
-- VHDL Sheet1
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

Entity lab2 Is
  port
  (
    JTAG_NEXUS_TCK : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TCK
    JTAG_NEXUS_TDI : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDI
    JTAG_NEXUS_TDO : Out   STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDO
    JTAG_NEXUS_TMS : In    STD_LOGIC                         -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TMS
  );
  attribute MacroCell : boolean;

End lab2;
------------------------------------------------------------

------------------------------------------------------------
Architecture Structure Of lab2 Is
   Component Configurable_U1                                 -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      port
      (
        AIN  : in  STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT : out STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AOUT[31..0]
        BIN  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-BIN
        BOUT : out STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-BOUT[31..0]
        TCK  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TCK
        TDI  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDI
        TDO  : out STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDO
        TMS  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TMS
        TRST : in  STD_LOGIC                                 -- ObjectKind=Pin|PrimaryId=U1-TRST
      );
   End Component;

   Component Ripple32bit                                     -- ObjectKind=Sheet Symbol|PrimaryId=U_Ripple32bi
      port
      (
        a : in  STD_LOGIC_VECTOR(31 downto 0);               -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-a[31..0]
        b : in  STD_LOGIC_VECTOR(31 downto 0);               -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-b[31..0]
        c : out STD_LOGIC;                                   -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-c
        s : out STD_LOGIC_VECTOR(31 downto 0)                -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-s[31..0]
      );
   End Component;


    Signal NamedSignal_JTAG_NEXUS_TRST : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST
    Signal PinSignal_U_Ripple32bi_c    : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU1_BIN
    Signal PinSignal_U_Ripple32bi_s    : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AIN[31..0]
    Signal PinSignal_U1_AOUT           : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AOUT[31..0]
    Signal PinSignal_U1_BOUT           : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_BOUT[31..0]
    Signal PinSignal_U1_TDO            : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TDO
    Signal PowerSignal_VCC             : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST

   attribute VERILOGMODULE : string;
   attribute VERILOGMODULE of U_Ripple32bi : Label is "Ripple32bit";


Begin
    U_Ripple32bi : Ripple32bit                               -- ObjectKind=Sheet Symbol|PrimaryId=U_Ripple32bi
      Port Map
      (
        a => PinSignal_U1_AOUT,                              -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-a[31..0]
        b => PinSignal_U1_BOUT,                              -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-b[31..0]
        c => PinSignal_U_Ripple32bi_c,                       -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-c
        s => PinSignal_U_Ripple32bi_s                        -- ObjectKind=Sheet Entry|PrimaryId=sumador32.v-s[31..0]
      );

    U1 : Configurable_U1                                     -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      Port Map
      (
        AIN  => PinSignal_U_Ripple32bi_s,                    -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT => PinSignal_U1_AOUT,                           -- ObjectKind=Pin|PrimaryId=U1-AOUT[31..0]
        BIN  => PinSignal_U_Ripple32bi_c,                    -- ObjectKind=Pin|PrimaryId=U1-BIN
        BOUT => PinSignal_U1_BOUT,                           -- ObjectKind=Pin|PrimaryId=U1-BOUT[31..0]
        TCK  => JTAG_NEXUS_TCK,                              -- ObjectKind=Pin|PrimaryId=U1-TCK
        TDI  => JTAG_NEXUS_TDI,                              -- ObjectKind=Pin|PrimaryId=U1-TDI
        TDO  => PinSignal_U1_TDO,                            -- ObjectKind=Pin|PrimaryId=U1-TDO
        TMS  => JTAG_NEXUS_TMS,                              -- ObjectKind=Pin|PrimaryId=U1-TMS
        TRST => NamedSignal_JTAG_NEXUS_TRST                  -- ObjectKind=Pin|PrimaryId=U1-TRST
      );

    -- Signal Assignments
    ---------------------
    JTAG_NEXUS_TDO              <= PinSignal_U1_TDO; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TDO
    NamedSignal_JTAG_NEXUS_TRST <= PowerSignal_VCC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST
    PowerSignal_VCC             <= '1'; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST

End Structure;
------------------------------------------------------------

