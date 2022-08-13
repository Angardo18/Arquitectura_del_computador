------------------------------------------------------------
-- VHDL Sheet2
-- 2022 8 9 21 28 45
-- Created By "Altium Designer VHDL Generator"
-- "Copyright (c) 2002-2014 Altium Limited"
-- Product Version: 14.3.13.34012
------------------------------------------------------------

------------------------------------------------------------
-- VHDL Sheet2
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

Entity restador_V1 Is
  port
  (
    JTAG_NEXUS_TCK : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TCK
    JTAG_NEXUS_TDI : In    STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDI
    JTAG_NEXUS_TDO : Out   STD_LOGIC;                        -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TDO
    JTAG_NEXUS_TMS : In    STD_LOGIC                         -- ObjectKind=Port|PrimaryId=JTAG_NEXUS_TMS
  );
  attribute MacroCell : boolean;

End restador_V1;
------------------------------------------------------------

------------------------------------------------------------
Architecture Structure Of restador_V1 Is
   Component Configurable_U1                                 -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      port
      (
        AIN  : in  STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT : out STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-AOUT[31..0]
        BOUT : out STD_LOGIC_VECTOR(31 downto 0);            -- ObjectKind=Pin|PrimaryId=U1-BOUT[31..0]
        COUT : out STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-COUT
        TCK  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TCK
        TDI  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDI
        TDO  : out STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TDO
        TMS  : in  STD_LOGIC;                                -- ObjectKind=Pin|PrimaryId=U1-TMS
        TRST : in  STD_LOGIC                                 -- ObjectKind=Pin|PrimaryId=U1-TRST
      );
   End Component;

   Component sumador_resta                                   -- ObjectKind=Sheet Symbol|PrimaryId=U_sumador_resta
      port
      (
        a      : in  STD_LOGIC_VECTOR(31 downto 0);          -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-a[31..0]
        b      : in  STD_LOGIC_VECTOR(31 downto 0);          -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-b[31..0]
        op     : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-op
        salida : out STD_LOGIC_VECTOR(31 downto 0)           -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-salida[31..0]
      );
   End Component;


    Signal NamedSignal_JTAG_NEXUS_TRST      : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST
    Signal PinSignal_U_sumador_resta_salida : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AIN[31..0]
    Signal PinSignal_U1_AOUT                : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_AOUT[31..0]
    Signal PinSignal_U1_BOUT                : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU1_BOUT[31..0]
    Signal PinSignal_U1_COUT                : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU1_COUT
    Signal PinSignal_U1_TDO                 : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TDO
    Signal PowerSignal_VCC                  : STD_LOGIC; -- ObjectKind=Net|PrimaryId=JTAG_NEXUS_TRST

   attribute VERILOGMODULE : string;
   attribute VERILOGMODULE of U_sumador_resta : Label is "sumador_resta";


Begin
    U_sumador_resta : sumador_resta                          -- ObjectKind=Sheet Symbol|PrimaryId=U_sumador_resta
      Port Map
      (
        a      => PinSignal_U1_AOUT,                         -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-a[31..0]
        b      => PinSignal_U1_BOUT,                         -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-b[31..0]
        op     => PinSignal_U1_COUT,                         -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-op
        salida => PinSignal_U_sumador_resta_salida           -- ObjectKind=Sheet Entry|PrimaryId=sumador_restador.v-salida[31..0]
      );

    U1 : Configurable_U1                                     -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      Port Map
      (
        AIN  => PinSignal_U_sumador_resta_salida,            -- ObjectKind=Pin|PrimaryId=U1-AIN[31..0]
        AOUT => PinSignal_U1_AOUT,                           -- ObjectKind=Pin|PrimaryId=U1-AOUT[31..0]
        BOUT => PinSignal_U1_BOUT,                           -- ObjectKind=Pin|PrimaryId=U1-BOUT[31..0]
        COUT => PinSignal_U1_COUT,                           -- ObjectKind=Pin|PrimaryId=U1-COUT
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

