----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/04/27 02:07:08
-- Design Name: 
-- Module Name: top_module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_module is
    port (
        DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
        DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
        DDR_cas_n : inout STD_LOGIC;
        DDR_ck_n : inout STD_LOGIC;
        DDR_ck_p : inout STD_LOGIC;
        DDR_cke : inout STD_LOGIC;
        DDR_cs_n : inout STD_LOGIC;
        DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
        DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_odt : inout STD_LOGIC;
        DDR_ras_n : inout STD_LOGIC;
        DDR_reset_n : inout STD_LOGIC;
        DDR_we_n : inout STD_LOGIC;
        ENET0_GMII_RX_CLK_0 : in STD_LOGIC;
        ENET0_GMII_RX_DV_0 : in STD_LOGIC;
        ENET0_GMII_TX_CLK_0 : in STD_LOGIC;
        ENET0_GMII_TX_EN_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
        FIXED_IO_ddr_vrn : inout STD_LOGIC;
        FIXED_IO_ddr_vrp : inout STD_LOGIC;
        FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
        FIXED_IO_ps_clk : inout STD_LOGIC;
        FIXED_IO_ps_porb : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC;
        MDIO_ETHERNET_0_0_mdc : out STD_LOGIC;
        MDIO_ETHERNET_0_0_mdio_io : inout STD_LOGIC;
        enet_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
        enet_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );

        -- GPIO --
        led_o       : out std_ulogic_vector(1 downto 0); -- parallel output
        -- UART0 --
        uart0_txd_o : out std_ulogic; -- UART0 send data
        uart0_rxd_i : in  std_ulogic := '0' -- UART0 receive data       
      );
end top_module;

architecture Behavioral of top_module is
    component zynq_ps7_core_wrapper is
        port (
            DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
            DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
            DDR_cas_n : inout STD_LOGIC;
            DDR_ck_n : inout STD_LOGIC;
            DDR_ck_p : inout STD_LOGIC;
            DDR_cke : inout STD_LOGIC;
            DDR_cs_n : inout STD_LOGIC;
            DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
            DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
            DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
            DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
            DDR_odt : inout STD_LOGIC;
            DDR_ras_n : inout STD_LOGIC;
            DDR_reset_n : inout STD_LOGIC;
            DDR_we_n : inout STD_LOGIC;
            ENET0_GMII_RX_CLK_0 : in STD_LOGIC;
            ENET0_GMII_RX_DV_0 : in STD_LOGIC;
            ENET0_GMII_TX_CLK_0 : in STD_LOGIC;
            ENET0_GMII_TX_EN_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
            FIXED_IO_ddr_vrn : inout STD_LOGIC;
            FIXED_IO_ddr_vrp : inout STD_LOGIC;
            FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
            FIXED_IO_ps_clk : inout STD_LOGIC;
            FIXED_IO_ps_porb : inout STD_LOGIC;
            FIXED_IO_ps_srstb : inout STD_LOGIC;
            MDIO_ETHERNET_0_0_mdc : out STD_LOGIC;
            MDIO_ETHERNET_0_0_mdio_io : inout STD_LOGIC;
            enet_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
            enet_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
            fclk : out STD_LOGIC;
            fclk_resetn : out STD_LOGIC
        );
    end component;

    component neorv32_test_setup  is
        port (
            -- Global control --
            clk_i       : in  std_ulogic := '0'; -- global clock, rising edge
            rstn_i      : in  std_ulogic := '0'; -- global reset, low-active, async
            -- GPIO --
            gpio_o      : out std_ulogic_vector(7 downto 0); -- parallel output
            -- UART0 --
            uart0_txd_o : out std_ulogic; -- UART0 send data
            uart0_rxd_i : in  std_ulogic := '0' -- UART0 receive data
        );
    end component;

    signal neorv32_clk    : std_logic  := '0';
    signal neorv32_resetn : std_logic  := '0';
    signal neorv32_gpio   : std_ulogic_vector(7 downto 0);
begin

    neorv32_test_setup_inst : neorv32_test_setup
    port map (
        clk_i       => neorv32_clk,
        rstn_i      => neorv32_resetn,        

        gpio_o      => neorv32_gpio,

        uart0_txd_o => uart0_txd_o,
        uart0_rxd_i => uart0_rxd_i
    );

    zynq_ps7_core_wrapper_inst : zynq_ps7_core_wrapper
    port map (
        DDR_addr => DDR_addr,
        DDR_ba => DDR_ba,
        DDR_cas_n => DDR_cas_n,
        DDR_ck_n => DDR_ck_n,
        DDR_ck_p => DDR_ck_p,
        DDR_cke => DDR_cke,
        DDR_cs_n => DDR_cs_n,
        DDR_dm => DDR_dm,
        DDR_dq => DDR_dq,
        DDR_dqs_n => DDR_dqs_n,
        DDR_dqs_p => DDR_dqs_p,
        DDR_odt => DDR_odt,
        DDR_ras_n => DDR_ras_n,
        DDR_reset_n => DDR_reset_n,
        DDR_we_n => DDR_we_n,
        ENET0_GMII_RX_CLK_0 => ENET0_GMII_RX_CLK_0,
        ENET0_GMII_RX_DV_0 => ENET0_GMII_RX_DV_0,
        ENET0_GMII_TX_CLK_0 => ENET0_GMII_TX_CLK_0,
        ENET0_GMII_TX_EN_0 => ENET0_GMII_TX_EN_0,
        FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
        FIXED_IO_mio => FIXED_IO_mio,
        FIXED_IO_ps_clk => FIXED_IO_ps_clk,
        FIXED_IO_ps_porb => FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
        MDIO_ETHERNET_0_0_mdc => MDIO_ETHERNET_0_0_mdc,
        MDIO_ETHERNET_0_0_mdio_io => MDIO_ETHERNET_0_0_mdio_io,
        enet_rxd => enet_rxd,
        enet_txd => enet_txd,
        fclk => neorv32_clk,
        fclk_resetn => neorv32_resetn 
    );

    led_o <= neorv32_gpio(1 downto 0);
end Behavioral;
