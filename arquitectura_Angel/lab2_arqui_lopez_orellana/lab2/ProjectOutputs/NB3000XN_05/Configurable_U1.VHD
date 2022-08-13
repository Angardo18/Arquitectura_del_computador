library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.std_logic_unsigned.all;

--------------------------------------------------------------------------------
package Configurable_U1TAP_UTILS is
    constant IR_LEN      : integer :=  4; -- Instruction register len (must be at least 2 bit long)
    constant IR_DEF_LEN  : integer :=  4;
    constant ID_CODE_LEN : integer := 32;

    ---------------------------------------------------------------------
    -- Manufacturer's ID code
    ---------------------------------------------------------------------
    constant ID_CODE_ALTIUM : STD_LOGIC_VECTOR (10 downto 0) := "01000111001";
    ---------------------------------------------------------------------
    -- Instruments
    ---------------------------------------------------------------------                  VERSION & PART ID           & ALTIUM ID      & 1
    constant ID_CODE_DIGITAL_IO             : STD_LOGIC_VECTOR (ID_CODE_LEN-1 downto 0)  := "0001" & "0000000001101010" & ID_CODE_ALTIUM & "1";
    constant JTAG_ID_DIGITAL_IO             : INTEGER := CONV_INTEGER(X"1006A473");
    constant ID_CODE_CUSTOM_INSTRUMENT      : STD_LOGIC_VECTOR (ID_CODE_LEN-1 downto 0)  := "0001" & "0000000001101101" & ID_CODE_ALTIUM & "1";
    constant JTAG_ID_CUSTOM_INSTRUMENT      : INTEGER := CONV_INTEGER(X"1006D473");
    constant ID_CODE_DIGITAL_IO_APPLICATION : STD_LOGIC_VECTOR (ID_CODE_LEN-1 downto 0)  := "0001" & "0000000001101110" & ID_CODE_ALTIUM & "1";
    constant JTAG_ID_DIGITAL_IO_APPLICATION : INTEGER := CONV_INTEGER(X"1006E473");
    ---------------------------------------------------------------------
    -- TAP Type
    ---------------------------------------------------------------------
    subtype TAP_INS_TYPE is STD_LOGIC_VECTOR (IR_DEF_LEN - 1 downto 0);

    ---------------------------------------------------------------------
    -- TAP IR Instruction codes
    ---------------------------------------------------------------------
    constant BYPAS_IR        : TAP_INS_TYPE := "1111"; -- Bypas register // bypas required by 1149.1
    -- Reg (option if absent - thenbypas)
    constant BSP_IR          : TAP_INS_TYPE := "0000"; -- BSP // scan required by 1149.1
    constant IDREG_IR        : TAP_INS_TYPE := "0001"; -- Identification // id required by 1149.1
    constant RESET_IR        : TAP_INS_TYPE := "0010"; -- Nexus Reset
    constant CONTROL_IR      : TAP_INS_TYPE := "1011"; -- Nexus Enable
    constant DATA_IR         : TAP_INS_TYPE := "1010"; -- Memory Acces Register Enable

    ---------------------------------------------------------------------
    -- TAP state codes
    -- The following definitions should not be changed
    -- codes for TAP FSM are chosen according IEEE1149.1 std
    -- appendix. on implemantation. Some signals are decoded based
    -- on such state codes !
    ---------------------------------------------------------------------
    subtype TAP_STATE_TYPE is STD_LOGIC_VECTOR (3 downto 0);
    ---------------------------------------------------------------------
    -- Test Access Port states
    ---------------------------------------------------------------------
    constant TLR_STATE        : TAP_STATE_TYPE := "1111"; -- Test Logic Reset F
    constant RUN_TEST_STATE   : TAP_STATE_TYPE := "1100"; -- Run Test/ Idle   C
    constant SELECT_DR_STATE  : TAP_STATE_TYPE := "0111"; -- Select DR        7
    constant SELECT_IR_STATE  : TAP_STATE_TYPE := "0100"; -- Select IR        4
    constant CAPTURE_IR_STATE : TAP_STATE_TYPE := "1110"; -- Capture IR       E
    constant CAPTURE_DR_STATE : TAP_STATE_TYPE := "0110"; -- Capture DR       6
    constant SHIFT_IR_STATE   : TAP_STATE_TYPE := "1010"; -- Shift IR         A
    constant SHIFT_DR_STATE   : TAP_STATE_TYPE := "0010"; -- Shift DR         2
    constant EXIT1_IR_STATE   : TAP_STATE_TYPE := "1001"; -- Exit1 IR         9
    constant EXIT1_DR_STATE   : TAP_STATE_TYPE := "0001"; -- Exit1 DR         1
    constant PAUSE_IR_STATE   : TAP_STATE_TYPE := "1011"; -- Pause IR         B
    constant PAUSE_DR_STATE   : TAP_STATE_TYPE := "0011"; -- Pause DR         3
    constant EXIT2_IR_STATE   : TAP_STATE_TYPE := "1000"; -- Exit2 IR         8
    constant EXIT2_DR_STATE   : TAP_STATE_TYPE := "0000"; -- Exit2 DR         0
    constant UPDATE_IR_STATE  : TAP_STATE_TYPE := "1101"; -- Update IR        D
    constant UPDATE_DR_STATE  : TAP_STATE_TYPE := "0101"; -- Update DR        5
end Configurable_U1TAP_UTILS;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
package body Configurable_U1TAP_UTILS is
end Configurable_U1TAP_UTILS;
--------------------------------------------------------------------------------

library IEEE;
    use IEEE.STD_LOGIC_1164.all;

-- Data register without outputs
-- for reading data only, eg. ID reg , reading ACC, ...

--------------------------------------------------------------------------------
entity Configurable_U1UNIVERSAL_DIGITAL_IO_DRNOOUT is
    generic (
        REG_LEN : integer := 32
    );
    port (
        clk      : in  STD_LOGIC;      -- clock
        si       : in  STD_LOGIC;      -- serial data input
        inpvalue : in  STD_LOGIC_VECTOR (REG_LEN - 1 downto 0);  -- paralel inputs for capture data
        shiftdr  : in  STD_LOGIC;      -- shift / capture signal
        enable   : in  STD_LOGIC;      -- enable
        so       : out STD_LOGIC       -- serial data output
    );
end Configurable_U1UNIVERSAL_DIGITAL_IO_DRNOOUT;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
architecture RTL of Configurable_U1UNIVERSAL_DIGITAL_IO_DRNOOUT is

    subtype reg_type is STD_LOGIC_VECTOR (REG_LEN - 1 downto 0);
    signal sh_reg: reg_type;

begin

    --------------------------------------------------------------------
    --------------------------------------------------------------------
    sh_reg_proc:
    --------------------------------------------------------------------
    process (clk)
    begin
        if (clk'event) and (clk = '1') then
            if (enable = '1') then  -- clk enable
                if (shiftdr = '0') then
                    sh_reg <= si & sh_reg(REG_LEN - 1 downto 1);
                else
                    sh_reg <= inpvalue;  -- capture inpvalue
                end if;
            end if;                      -- clkenable
        end if;                          -- clk'event
    end process;

    --------------------------------------------------------------------
    --------------------------------------------------------------------
    so_drv: so <= sh_reg(0);

end RTL;
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use work.Configurable_U1TAP_UTILS.all;

--------------------------------------------------------------------------------
entity Configurable_U1UNIVERSAL_DIGITAL_IO_TAPCONTROLLER is
    port
    (
        tck            : in std_logic;
        tms            : in std_logic;
        tdi            : in std_logic;
        drsin          : in std_logic;   -- input from other (external for tap) data reg. e.g. nxreg, bsp ...
        trst           : in std_logic;

        tdo            : out std_logic;  -- test data output (no tri state)

        reset          : out std_logic;  -- internal asynch. reset
        State_TLR      : Out Std_Logic;  -- We are in TestLogicReset state (AD forced us here as it wants to scan chain)
        controlen      : out std_logic;  -- nexus enable (decoded instruction in ir)

        updateir       : out std_logic;  -- update ir required for nexus fsm synch
        dataen         : out std_logic;  -- memory access (up/down load) register - enable signal
                                         -- (provided base on contents of ir)


        shiftdr        : out std_logic;  -- shift dr
        clockdr        : out std_logic;  -- clock dr
        updatedr       : out std_logic;  -- update dr
        exit1dr        : out std_logic;  -- exit1 dr

        irout          : out std_logic_vector(3 downto 0); -- for debugging only tap instr reg state
        tapstate       : out std_logic_vector(3 downto 0); -- for debugging only tap fsm state

        id_code_signal : in  std_logic_vector(31 downto 0)
    );
end Configurable_U1UNIVERSAL_DIGITAL_IO_TAPCONTROLLER;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
architecture rtl of Configurable_U1UNIVERSAL_DIGITAL_IO_TAPCONTROLLER is

    Component Configurable_U1UNIVERSAL_DIGITAL_IO_DRNOOUT is
        generic (
            REG_LEN : integer := 32
        );
        port (
            clk      : in  STD_LOGIC;      -- clock
            si       : in  STD_LOGIC;      -- serial data input
            inpvalue : in  STD_LOGIC_VECTOR (REG_LEN - 1 downto 0);  -- paralel inputs for capture data
            shiftdr  : in  STD_LOGIC;      -- shift / capture signal
            enable   : in  STD_LOGIC;      -- enable
            so       : out STD_LOGIC       -- serial data output
        );
    End Component;

    -- internal signals

    signal selectdi1    : std_logic; -- select
    signal shiftir1     : std_logic; -- shift ir
    signal clockir      : std_logic; -- clock ir
    signal updateir1    : std_logic; -- update ir

    signal clockdr1     : std_logic; -- clock ir
    signal updatedr1    : std_logic; -- update ir
    signal exit1dr1     : std_logic;

    signal bypasenable  : std_logic;
    signal idenable     : std_logic;
    signal bspenable    : std_logic;

    signal irso         : std_logic; -- ir serial output
    signal drso         : std_logic; -- dr (all) serial output (mux 1 out)
    signal ins          : std_logic_vector (ir_len - 1 downto 0); -- ir serial output

    signal idout        :  std_logic;
    signal byp_reg      :  std_logic; -- bypas register (only single ff)

    subtype ir_type is std_logic_vector (ir_len - 1 downto 0);  -- instruction register ir

    signal sh_ireg      : ir_type;  -- shift register
    signal up_ireg      : ir_type;  -- update register

    -- tap fsm signals

    signal tapstate_nxt : tap_state_type;   -- combinational tap state
    signal tapstate_r   : tap_state_type;   -- tap state register
    signal shiftir_c    : std_logic;    -- combinational signals ...
    signal shiftdr_c    : std_logic;    --  ... decoding tap states
    signal reset_c      : std_logic;
    signal enable_c     : std_logic;
    signal shiftir_r    : std_logic;    -- registred signals ...
    signal shiftdr_r    : std_logic;    --  ... decoding tap states
    signal reset_r      : std_logic;
    signal enable_r     : std_logic;

begin
    --------------------------------------------------------------------
    -- mapping
    --------------------------------------------------------------------
    clockdr_drv:  clockdr  <= clockdr1;
    updatedr_drv: updatedr <= updatedr1;
    updateir_drv: updateir <= updateir1;
    TLR_Reset_drv: State_TLR <= reset_c;
    exit1dr_drv:   exit1dr   <= exit1dr1;
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    id_reg_unit : Configurable_U1UNIVERSAL_DIGITAL_IO_DRNOOUT
        generic map (
            REG_LEN => ID_CODE_LEN
        )
        port map
        (
            clk      => tck,
            si       => tdi,
            inpvalue => id_code_signal,
            shiftdr  => shiftdr_r,
            enable   => idenable,
            so       => idout
        );

    --------------------------------------------------------------------
    -- tap fsm (16 stages fsm tck - clock ; tms input
    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- combinational part ( tapstate_nxt function)
    --------------------------------------------------------------------
    tap_state_comb_proc:
    --------------------------------------------------------------------
    process (tapstate_r, tms)
    begin
        if (tms= '1') then
            case tapstate_r is
                when tlr_state        => tapstate_nxt <= tlr_state;
                when run_test_state   => tapstate_nxt <= select_dr_state;
                when select_dr_state  => tapstate_nxt <= select_ir_state;
                when capture_dr_state => tapstate_nxt <= exit1_dr_state;
                when shift_dr_state   => tapstate_nxt <= exit1_dr_state;
                when exit1_dr_state   => tapstate_nxt <= update_dr_state;
                when pause_dr_state   => tapstate_nxt <= exit2_dr_state;
                when exit2_dr_state   => tapstate_nxt <= update_dr_state;
                when update_dr_state  => tapstate_nxt <= select_dr_state;
                when select_ir_state  => tapstate_nxt <= tlr_state;
                when capture_ir_state => tapstate_nxt <= exit1_ir_state;
                when shift_ir_state   => tapstate_nxt <= exit1_ir_state;
                when exit1_ir_state   => tapstate_nxt <= update_ir_state;
                when pause_ir_state   => tapstate_nxt <= exit2_ir_state;
                when exit2_ir_state   => tapstate_nxt <= update_ir_state;
                when update_ir_state  => tapstate_nxt <= select_dr_state;
                when others           => tapstate_nxt <= exit2_dr_state;
            end case;
        else
            case tapstate_r is
                when tlr_state        => tapstate_nxt <= run_test_state;
                when run_test_state   => tapstate_nxt <= run_test_state;
                when select_dr_state  => tapstate_nxt <= capture_dr_state;
                when capture_dr_state => tapstate_nxt <= shift_dr_state;
                when shift_dr_state   => tapstate_nxt <= shift_dr_state;
                when exit1_dr_state   => tapstate_nxt <= pause_dr_state;
                when pause_dr_state   => tapstate_nxt <= pause_dr_state;
                when exit2_dr_state   => tapstate_nxt <= shift_dr_state;
                when update_dr_state  => tapstate_nxt <= run_test_state;
                when select_ir_state  => tapstate_nxt <= capture_ir_state;
                when capture_ir_state => tapstate_nxt <= shift_ir_state;
                when shift_ir_state   => tapstate_nxt <= shift_ir_state;
                when exit1_ir_state   => tapstate_nxt <= pause_ir_state;
                when pause_ir_state   => tapstate_nxt <= pause_ir_state;
                when exit2_ir_state   => tapstate_nxt <= shift_ir_state;
                when update_ir_state  => tapstate_nxt <= run_test_state;
                when others           => tapstate_nxt <= exit2_dr_state;
            end case;
        end if;
    end process;

    --------------------------------------------------------------------
    -- synchronous part of tap fsm (on rising edge of tck)
    --------------------------------------------------------------------
    tap_state_sync_proc:
    --------------------------------------------------------------------
    process (tck, trst)
    begin
        if (trst = '0') then
            tapstate_r <= tlr_state;
        else
            if (tck'event) and (tck = '1') then
                tapstate_r <= tapstate_nxt;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- combinational part ( tap outputs )
    --------------------------------------------------------------------
    tap_out_comb_proc:
    --------------------------------------------------------------------
    process (tapstate_r) -- tck
    begin
        updatedr1 <='0';
        if (tapstate_r = update_dr_state) then
            updatedr1 <= '1';
        end if;

        updateir1 <='0';
        if (tapstate_r = update_ir_state) then
            updateir1 <= '1';
        end if;

        clockdr1 <= '0';
        if ( tapstate_r(3) = '0') and
           ( tapstate_r(1) = '1') and
           ( tapstate_r(0) = '0') -- and
        --    ( tck = '0')
        then
            clockdr1 <= '1';
        end if;

        clockir <= '0';
        if ( tapstate_r(3) = '1') and
           ( tapstate_r(1) = '1') and
           ( tapstate_r(0) = '0') -- and
        --    ( tck = '0')
        then
            clockir <= '1';
        end if;

        exit1dr1 <= '0';
        if (tapstate_r = exit1_dr_state) then
            exit1dr1 <= '1';
        end if;
    end process;

    --------------------------------------------------------------------
    -- combinational part for reset, enable, shift ir, shift dr, & select(c)
    --------------------------------------------------------------------
    tap_out_reg_comb_proc:
    --------------------------------------------------------------------
    process (tapstate_r)
    begin
        reset_c <= '1';
        if (tapstate_r = tlr_state) then
            reset_c <= '0';
        end if;
        shiftir_c <= '1';
        if (tapstate_r = shift_ir_state) then
            shiftir_c <= '0';
        end if;
        shiftdr_c <= '1';
        if (tapstate_r = shift_dr_state) then
            shiftdr_c <= '0';
        end if;
    end process;

    --------------------------------------------------------------------
    enable_drv: enable_c <= not (shiftir_c and shiftdr_c);

    --------------------------------------------------------------------
    selectdi1_drv: selectdi1 <= tapstate_r(3);

    --------------------------------------------------------------------
    -- synchronous part (on falling edge of tck) - tap outputs
    --------------------------------------------------------------------
    tap_outputs_sync_proc:
    --------------------------------------------------------------------
    process (tck, trst)
    begin
        if (trst = '0') then
            reset_r   <= '0';
            shiftir_r <= '0';
            shiftdr_r <= '0';
            enable_r  <= '0';
        else
            if (tck'event) and (tck = '0') then
                reset_r   <= reset_c;
                shiftir_r <= shiftir_c;
                shiftdr_r <= shiftdr_c;
                enable_r  <= enable_c;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    shiftdr_drv: shiftdr  <= shiftdr_r;

    --------------------------------------------------------------------
    -- combinational part instruction decoder
    --------------------------------------------------------------------
    ins_out_comb_proc:
    --------------------------------------------------------------------
    process (ins) -- tck
    begin
        controlen <='0';
        if (ins = control_ir) then
            controlen <= '1';
        end if;

        reset <= '1';
        if (ins = reset_ir) then
            reset <= '0';
        end if;

        idenable <='0';
        if (ins = idreg_ir) then
            idenable <= '1';
        end if;

        bypasenable <='0';
        if (ins = bypas_ir) then
            bypasenable <= '1';
        end if;

        bspenable <='0';
        if (ins = bsp_ir) then
            bspenable <= '1';
        end if;

        dataen <='0';
        if (ins = data_ir) then
            dataen   <= '1';
        end if;
    end process;

    ---------------------------------------------------------------
    -- tap instruction register
    -- generic ir_len defines the lenth of the register
    ---------------------------------------------------------------

    ---------------------------------------------------------------
    ir_shift_process:  -- shifting process (rising edge, clken = 1)
    ---------------------------------------------------------------
    process (tck)
    begin
        if (tck'event) and (tck = '1') then
            if (clockir = '1') then  -- clk enable
                if (shiftir_r = '0') then       -- shift
                    sh_ireg <= tdi & sh_ireg(ir_len - 1 downto 1);
                else                                       -- capture
                    sh_ireg <= ir_type'(others => '0');    -- capture xx..xx01
                    sh_ireg(0) <= '1';                     -- the only way fpga exp accepts
                end if;
            end if; -- clkenable
        end if;     -- clk'event
    end process;

    ---------------------------------------------------------------
    ir_update_process:  -- update process (latch on rising tck if update enabled.
                        --  asynch. reset);
    ---------------------------------------------------------------
    process (tck, reset_r )
    begin
        if (reset_r = '0') then
            up_ireg <= ir_type'( others => '0');
            up_ireg(0) <= '1';
        else
            if (tck'event) and (tck = '1')then
                if (updateir1 = '1') then  -- update enable signal
                    up_ireg <= sh_ireg;
                end if;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    ins_drv: ins <= up_ireg;

    --------------------------------------------------------------------
    irso_drv: irso  <= sh_ireg(0);

    --------------------------------------------------------------------
    -- last mux (drso, irso)
    --------------------------------------------------------------------
    tdo_comb_process:
    --------------------------------------------------------------------
    process (drso, irso, selectdi1)
    begin
        if (selectdi1 = '1') then
            tdo <= irso;
        else
            tdo <= drso;
        end if;
    end process;

    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- previous mux
    --------------------------------------------------------------------
    tdo_comb1_process:
    --------------------------------------------------------------------
    process (bypasenable, idenable, drsin, byp_reg, idout)
    begin
        if (bypasenable = '1') then
            drso <= byp_reg;
        else
            if (idenable = '1') then
                drso <= idout;
            else
                drso <= drsin;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- bypas register only one ff (signal byp_reg)
    --------------------------------------------------------------------
    bypas_sync_proc:
    --------------------------------------------------------------------
    process (tck)
    begin
        if (tck'event) and (tck = '1') then
            if (clockdr1 = '1') then  -- clk enable
                if (shiftdr_r = '0') then
                    byp_reg <= tdi;
                else
                    byp_reg <= '0';   -- capture '0'
                end if;
            end if;                   -- clkenable
        end if;                       -- clk'event
    end process;

    tapstate_drv : tapstate <= tapstate_r;
    irout_drv    : irout    <= ins;

end rtl;
--------------------------------------------------------------------------------

library IEEE;
    use IEEE.STD_LOGIC_1164.all;

--------------------------------------------------------------------------------
entity Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR is
    generic (
        REG_LEN : integer := 4
    );
    port (
        Rst:          in  STD_LOGIC;
        ResetValue:   in  STD_LOGIC_VECTOR(REG_LEN-1 Downto 0);
        clk:          in  STD_LOGIC;  -- clock connected to TCK
        clken:        in  STD_LOGIC;  -- shift clock enable (shift DR from TAP)
        enable:       in  STD_LOGIC;  -- enable (if 0 then value in NRR remains unchanged)
        enable_write: in  STD_LOGIC;  -- enable write
        si:           in  STD_LOGIC;  -- serial input (connected to TDI)
        shift:        in  STD_LOGIC;  -- shift DR
        update:       in  STD_LOGIC;  -- update DR
        regin:        in  STD_LOGIC_VECTOR (REG_LEN - 1 downto 0); -- (NRR data in)
        regout:       out STD_LOGIC_VECTOR (REG_LEN - 1 downto 0); -- (NRR data out)
        so:           out STD_LOGIC  -- serial output  (connectet to TDO mux)
    );
end Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
architecture RTL of Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR is

    subtype nrr_type is STD_LOGIC_VECTOR (REG_LEN - 1 downto 0);
    signal sh_reg: nrr_type;
    signal up_reg: nrr_type;

begin

    --------------------------------------------------------------------
    -- shifting process (rising edge)
    --------------------------------------------------------------------
    shift_proc:
    --------------------------------------------------------------------
    process (clk)
    begin
        if (clk'event) and (clk = '1') then
            if (enable = '1')and (clken = '1') then  -- only if enable and clken
                if (shift = '0') then  -- shift
                    sh_reg <= si & sh_reg(REG_LEN - 1 downto 1);
                else
                    sh_reg <= regin; -- capture regin
                end if;              -- shift / capture
            end if;                  -- enable
        end if;                      -- clk'event
    end process;

    --------------------------------------------------------------------
    -- update process (latch on update and asynch. reset);
    --------------------------------------------------------------------
    update_proc:
    --------------------------------------------------------------------
    process ( clk, Rst, ResetValue )
    begin
        If Rst='1' Then
            Up_Reg <= ResetValue;
        Else
            If Rising_Edge(clk) then     -- clk
                if (update = '1') and (enable = '1') and (enable_write = '1') then
                    up_reg <= sh_reg;
                end if;
            end if;
        End If;
    end process;

    --------------------------------------------------------------------
    regout_drv: regout <= up_reg;

    --------------------------------------------------------------------
    so_drv: so  <= sh_reg(0);

end RTL;
--------------------------------------------------------------------------------

library IEEE;
    use IEEE.STD_LOGIC_1164.All;
    use IEEE.STD_LOGIC_ARITH.all;
    Use IEEE.Std_Logic_Unsigned.all;
    use work.Configurable_U1TAP_UTILS.All;

--------------------------------------------------------------------------------
entity Configurable_U1 is
    Port (
        -- As Seen On Schematic                                                           -- ExcludeIf_NanoBoardInterface
        AIN : IN STD_LOGIC_VECTOR(31 DownTo 0);
        BIN : IN STD_LOGIC;

        AOUT : OUT STD_LOGIC_VECTOR(31 DownTo 0);
        BOUT : OUT STD_LOGIC_VECTOR(31 DownTo 0);

        -- JTAG
        TCK       : In  STD_LOGIC; -- Test Clock       JTAG 1149.1
        TMS       : In  STD_LOGIC; -- Test Mode Select JTAG 1149.1
        TDI       : In  STD_LOGIC; -- Test Data Input  JTAG 1149.1
        TRST      : In  STD_LOGIC; -- Test Reset  (optional)  JTAG 1149.1
        TDO       : Out STD_LOGIC -- Test Data Output JTAG 1149.1
    );
end Configurable_U1;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
Architecture RTL of Configurable_U1 is

    component Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR is
        generic (
            REG_LEN : integer := 4
        );
        port (
            Rst:          in  STD_LOGIC;
            ResetValue:   in  STD_LOGIC_VECTOR(REG_LEN - 1 Downto 0);
            clk:          in  STD_LOGIC;  -- clock connected to TCK
            clken:        in  STD_LOGIC;  -- shift clock enable (shift DR from TAP)
            enable:       in  STD_LOGIC;  -- enable (if 0 then value in NRR remains unchanged)
            enable_write: in  STD_LOGIC;  -- enable write
            si:           in  STD_LOGIC;  -- serial input (connected to TDI)
            shift:        in  STD_LOGIC;  -- shift DR
            update:       in  STD_LOGIC;  -- update DR
            regin:        in  STD_LOGIC_VECTOR (REG_LEN - 1 downto 0); -- (NRR data in)
            regout:       out STD_LOGIC_VECTOR (REG_LEN - 1 downto 0); -- (NRR data out)
            so:           out STD_LOGIC  -- serial output  (connectet to TDO mux)
        );
    end component;

    component Configurable_U1UNIVERSAL_DIGITAL_IO_TAPCONTROLLER is
        port
        (
            tck            : in std_logic;
            tms            : in std_logic;
            tdi            : in std_logic;
            drsin          : in std_logic;   -- intut from other (external for tap) data reg. e.g. nxreg, bsp ...
            trst           : in std_logic;

            tdo            : out std_logic;  -- test data output (no tri state)

            reset          : out std_logic;  -- internal asynch. reset
            State_TLR      : Out Std_Logic;
            controlen      : out std_logic;  -- nexus enable (decoded instruction in ir)

            updateir       : out std_logic;  -- update ir required for nexus fsm synch
            dataen         : out std_logic;  -- memory access (up/down load) register - enable signal
                                             -- (provided base on contents of ir)

            shiftdr        : out std_logic;  -- shift dr
            clockdr        : out std_logic;  -- clock dr
            updatedr       : out std_logic;  -- update dr
            exit1dr        : out std_logic;  -- exit1 dr

            irout          : out std_logic_vector(3 downto 0); -- for debugging only tap instr reg state
            tapstate       : out std_logic_vector(3 downto 0); -- for debugging only tap fsm state

            id_code_signal : in  std_logic_vector(31 downto 0)
        );
    end component;


    Constant cDefaultValue : Std_Logic_Vector(64 - 1 Downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";      -- ExcludeIf_NanoBoardInterface
    Signal   DefaultValue  : Std_Logic_Vector(64 - 1 Downto 0);                                    -- ExcludeIf_NanoBoardInterface

    Signal Main_SerialOut    : STD_LOGIC; -- data reg serial
    Signal Reset             : STD_LOGIC;
    Signal IR_Update         : STD_LOGIC;
    Signal Shift_Capture     : STD_LOGIC;
    Signal DR_Clock          : STD_LOGIC;
    Signal DR_Update         : STD_LOGIC;
    Signal DR_Exit1          : STD_LOGIC;

    Signal User_Enable       : STD_LOGIC_VECTOR(6 downto 0);
    Signal User_SerialOut    : STD_LOGIC_VECTOR(6 downto 0);
    Signal Enable_Array      : STD_LOGIC_VECTOR(6 downto 0);

    Signal Enable_Write      : STD_LOGIC;
    Signal Enable_Control    : STD_LOGIC;
    Signal Enable_Data       : STD_LOGIC;
--  Signal Control_In        : STD_LOGIC_VECTOR (7 DownTo 0);
    Signal Control_Out       : STD_LOGIC_VECTOR (7 DownTo 0);
    Signal Control_SerialOut : STD_LOGIC;
    Signal id_code_signal    : std_logic_vector(31 downto 0);

    Signal SignalVCC         : Std_Logic;
    Signal SignalGround      : Std_Logic;
    Signal SignalGround4     : Std_Logic_Vector(3 Downto 0);
    Signal SignalGround8     : Std_Logic_Vector(7 Downto 0);
    Signal SignalGround16    : Std_Logic_Vector(15 Downto 0);
    Signal SignalGround32    : Std_Logic_Vector(31 Downto 0);
    Signal SignalGroundInput : Std_Logic_Vector(33 - 1 Downto 0);     -- ExcludeIf_NanoBoardInterface
    Signal Default0          : Std_Logic;
    Signal Default1          : Std_Logic;
    Signal DefaultEnable     : Std_Logic;
    Signal DefaultNot        : Std_Logic;

    Signal StartUpCounter                  : Std_Logic_Vector(3 Downto 0);
    Signal RegisterInput_Value_Signal      : Std_Logic_Vector(33  - 1 downto 0);                    -- ExcludeIf_NanoBoardInterface
    Signal RegisterOutput_Value_Signal     : Std_Logic_Vector(64 - 1 downto 0);                    -- ExcludeIf_NanoBoardInterface
    Signal RegisterConfiguration_Signal    : Std_Logic_Vector(31 downto 0);


    Signal Reset_TLR         : Std_Logic;

Begin
    DefaultValue <= cDefaultValue;                                                        -- ExcludeIf_NanoBoardInterface

    RegisterInput_Value_Signal <= BIN & AIN;

    AOUT <= RegisterOutput_Value_Signal(31 downto 0);
    BOUT <= RegisterOutput_Value_Signal(63 downto 32);

    id_code_signal <= ID_CODE_DIGITAL_IO;                                                 -- ExcludeIf_CustomInstrument                      ExcludeIf_NanoBoardInterface

    TAP1 : Configurable_U1UNIVERSAL_DIGITAL_IO_TAPCONTROLLER
        port map (
            TCK            => TCK,
            TRST           => TRST,
            TMS            => TMS,
            TDI            => TDI,
            DRSIN          => Main_SerialOut,
            TDO            => TDO,
            RESET          => Reset,
            State_TLR      => Reset_TLR,

            CONTROLEN      => Enable_Control,
            DATAEN         => Enable_Data,
            SHIFTDR        => Shift_Capture,
            CLOCKDR        => DR_Clock,
            UPDATEDR       => DR_Update,
            UPDATEIR       => IR_Update,
            EXIT1DR        => DR_Exit1,

            ID_CODE_SIGNAL => id_code_signal
        );

    control_register : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR
        generic map
        (
            REG_LEN => 8
        )
        port map (
            Rst          => SignalGround,
            ResetValue   => SignalGround8,
            clk          => TCK,
            clken        => DR_Clock,
            enable_write => Enable_Control,
            enable       => Enable_Control,
            si           => TDI,
            shift        => Shift_Capture,
            update       => DR_Update,
            regin        => Control_Out,
            regout       => Control_Out,
            so           => Control_SerialOut
        );

    RegisterInput_Length : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR    -- ExcludeIf_NanoBoardInterface
        generic map                                                                       -- ExcludeIf_NanoBoardInterface
        (                                                                                 -- ExcludeIf_NanoBoardInterface
            REG_LEN => 16                                                                 -- ExcludeIf_NanoBoardInterface
        )                                                                                 -- ExcludeIf_NanoBoardInterface
        port map (                                                                        -- ExcludeIf_NanoBoardInterface
            Rst          => SignalGround,                                                 -- ExcludeIf_NanoBoardInterface
            ResetValue   => SignalGround16,                                               -- ExcludeIf_NanoBoardInterface
            clk          => TCK,                                                          -- ExcludeIf_NanoBoardInterface
            clken        => DR_Clock,                                                     -- ExcludeIf_NanoBoardInterface
            enable_write => Enable_Write,                                                 -- ExcludeIf_NanoBoardInterface
            enable       => User_Enable(0),                                               -- ExcludeIf_NanoBoardInterface
            si           => TDI,                                                          -- ExcludeIf_NanoBoardInterface
            shift        => Shift_Capture,                                                -- ExcludeIf_NanoBoardInterface
            update       => DR_Update,                                                    -- ExcludeIf_NanoBoardInterface
            regin        => Conv_std_logic_Vector(33, 16),            -- ExcludeIf_NanoBoardInterface
            regout       => Open,                                                         -- ExcludeIf_NanoBoardInterface
            so           => User_SerialOut(0)                                             -- ExcludeIf_NanoBoardInterface
        );                                                                                -- ExcludeIf_NanoBoardInterface
                                                                                          -- ExcludeIf_NanoBoardInterface
    RegisterInput_Value : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR     -- ExcludeIf_NanoBoardInterface
        generic map                                                                       -- ExcludeIf_NanoBoardInterface
        (                                                                                 -- ExcludeIf_NanoBoardInterface
            REG_LEN => 33                                             -- ExcludeIf_NanoBoardInterface
        )                                                                                 -- ExcludeIf_NanoBoardInterface
        port map (                                                                        -- ExcludeIf_NanoBoardInterface
            Rst          => SignalGround,                                                 -- ExcludeIf_NanoBoardInterface
            ResetValue   => SignalGroundInput,                                            -- ExcludeIf_NanoBoardInterface
            clk          => TCK,                                                          -- ExcludeIf_NanoBoardInterface
            clken        => DR_Clock,                                                     -- ExcludeIf_NanoBoardInterface
            enable_write => Enable_Write,                                                 -- ExcludeIf_NanoBoardInterface
            enable       => User_Enable(1),                                               -- ExcludeIf_NanoBoardInterface
            si           => TDI,                                                          -- ExcludeIf_NanoBoardInterface
            shift        => Shift_Capture,                                                -- ExcludeIf_NanoBoardInterface
            update       => DR_Update,                                                    -- ExcludeIf_NanoBoardInterface
            regin        => RegisterInput_Value_Signal,                                   -- ExcludeIf_NanoBoardInterface
            regout       => Open,                                                         -- ExcludeIf_NanoBoardInterface
            so           => User_SerialOut(1)                                             -- ExcludeIf_NanoBoardInterface
        );                                                                                -- ExcludeIf_NanoBoardInterface
                                                                                          -- ExcludeIf_NanoBoardInterface
    RegisterOutput_Length : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR   -- ExcludeIf_NanoBoardInterface
        generic map                                                                       -- ExcludeIf_NanoBoardInterface
        (                                                                                 -- ExcludeIf_NanoBoardInterface
            REG_LEN => 16                                                                 -- ExcludeIf_NanoBoardInterface
        )                                                                                 -- ExcludeIf_NanoBoardInterface
        port map (                                                                        -- ExcludeIf_NanoBoardInterface
            Rst          => SignalGround,                                                 -- ExcludeIf_NanoBoardInterface
            ResetValue   => SignalGround16,                                               -- ExcludeIf_NanoBoardInterface
            clk          => TCK,                                                          -- ExcludeIf_NanoBoardInterface
            clken        => DR_Clock,                                                     -- ExcludeIf_NanoBoardInterface
            enable_write => Enable_Write,                                                 -- ExcludeIf_NanoBoardInterface
            enable       => USer_Enable(2),                                               -- ExcludeIf_NanoBoardInterface
            si           => TDI,                                                          -- ExcludeIf_NanoBoardInterface
            shift        => Shift_Capture,                                                -- ExcludeIf_NanoBoardInterface
            update       => DR_Update,                                                    -- ExcludeIf_NanoBoardInterface
            regin        => Conv_std_logic_Vector(64, 16),           -- ExcludeIf_NanoBoardInterface
            regout       => Open,                                                         -- ExcludeIf_NanoBoardInterface
            so           => User_SerialOut(2)                                             -- ExcludeIf_NanoBoardInterface
        );                                                                                -- ExcludeIf_NanoBoardInterface
                                                                                          -- ExcludeIf_NanoBoardInterface
    RegisterOutput_Value : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR    -- ExcludeIf_NanoBoardInterface
        generic map                                                                       -- ExcludeIf_NanoBoardInterface
        (                                                                                 -- ExcludeIf_NanoBoardInterface
            REG_LEN => 64                                            -- ExcludeIf_NanoBoardInterface
        )                                                                                 -- ExcludeIf_NanoBoardInterface
        port map (                                                                        -- ExcludeIf_NanoBoardInterface
            Rst          => DefaultEnable,                                                -- ExcludeIf_NanoBoardInterface
            ResetValue   => DefaultValue,                                                 -- ExcludeIf_NanoBoardInterface
            clk          => TCK,                                                          -- ExcludeIf_NanoBoardInterface
            clken        => DR_Clock,                                                     -- ExcludeIf_NanoBoardInterface
            enable_write => Enable_Write,                                                 -- ExcludeIf_NanoBoardInterface
            enable       => User_Enable(3),                                               -- ExcludeIf_NanoBoardInterface
            si           => TDI,                                                          -- ExcludeIf_NanoBoardInterface
            shift        => Shift_Capture,                                                -- ExcludeIf_NanoBoardInterface
            update       => DR_Update,                                                    -- ExcludeIf_NanoBoardInterface
            regin        => RegisterOutput_Value_Signal,                                  -- ExcludeIf_NanoBoardInterface
            regout       => RegisterOutput_Value_Signal,                                  -- ExcludeIf_NanoBoardInterface
            so           => User_SerialOut(3)                                             -- ExcludeIf_NanoBoardInterface
        );                                                                                -- ExcludeIf_NanoBoardInterface

    RegisterConfiguration : Configurable_U1UNIVERSAL_DIGITAL_IO_DATAREG_INOUT_WR
    -- bits 31..24 - read-only  - not used                                                -- ExcludeIf_CustomInstrument                      ExcludeIf_NanoBoardInterface
    -- bits 23..16 - read-only  - version
    -- bits 15..8  - read-only  - not used                                                -- ExcludeIf_CustomInstrument                      ExcludeIf_NanoBoardInterface
    -- bits  7..0  - read-only  - internal ID                                             -- ExcludeIf_CustomInstrument                      ExcludeIf_NanoBoardInterface
        generic map
        (
            REG_LEN => 32
        )
        port map (
            Rst          => SignalGround,
            ResetValue   => SignalGround32,
            clk          => TCK,
            clken        => DR_Clock,
            enable_write => Enable_Write,
            enable       => User_Enable(4),
            si           => TDI,
            shift        => Shift_Capture,
            update       => DR_Update,
            regin        => x"000A0000",
            regout       => RegisterConfiguration_Signal,
            so           => User_SerialOut(4)
        );



    SignalGroundInput <= (Others=>'0');                                                   -- ExcludeIf_NanoBoardInterface

    SignalVCC      <= '1';
    SignalGround   <= '0';
    SignalGround4  <= x"0";
    SignalGround8  <= x"00";
    SignalGround16 <= x"0000";
    SignalGround32 <= x"00000000";

    Process(TCK, TRST)
    Begin
        If TRST='0' Then
            StartUpCounter <= (Others=>'0');
            DefaultEnable <= '1';
        Else
            If Rising_Edge(TCK) Then
                If StartUpCounter="1111" Then
                    If User_Enable(3)='1' Then
                        DefaultEnable <= '0';
                    End If;
                Else
                    DefaultEnable <= '1';
                    StartUpCounter <= StartUpCounter + 1;
                End If;
            End If;
        End If;
    End Process;

    -- Sequence Is
    -- 1. Write ControlEnable Instruction to IR - IR Scan Path
    -- 2. Write ControlByte to ControlRegister  - DR Scan Path
    -- 3. Write DataEnable Instruction to IR    - IR Scan Path
    -- 4. Write/Read Data from Data Register    - DR Scan Path

    Enable_Array <= (others => Enable_Data);
    User_Enable  <= Control_Out(6 downto 0) And Enable_Array;
    Enable_Write <= Control_Out(7) And Enable_Data;
    -----------------------------------------------------------

    -----------------------------------------------------------
    SerialOutputMux:
    Process (User_Enable, User_SerialOut, Control_SerialOut)
    Begin
        If    User_Enable(4) = '1' Then Main_SerialOut <= User_SerialOut(4);
        ElsIf User_Enable(0) = '1' Then Main_SerialOut <= User_SerialOut(0);              -- ExcludeIf_NanoBoardInterface
        ElsIf User_Enable(1) = '1' Then Main_SerialOut <= User_SerialOut(1);              -- ExcludeIf_NanoBoardInterface
        ElsIf User_Enable(2) = '1' Then Main_SerialOut <= User_SerialOut(2);              -- ExcludeIf_NanoBoardInterface
        ElsIf User_Enable(3) = '1' Then Main_SerialOut <= User_SerialOut(3);              -- ExcludeIf_NanoBoardInterface
        Else                            Main_SerialOut <= Control_SerialOut;
        End If;
    End process;
    -----------------------------------------------------------


End RTL;
--------------------------------------------------------------------------------
