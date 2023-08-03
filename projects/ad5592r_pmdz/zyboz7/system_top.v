`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout   [ 3:0]  btn,
  inout   [ 3:0]  led,

// 4. Add SPI ports for both ADC PMOD connector and sniffing PMOD connector 

  // SPI ports for the ADC PMOD connector
  output adc_spi_clk,
  output adc_spi_cs,
  input adc_spi_miso,
  output adc_spi_mosi,

  // SPI ports for the sniffing PMOD connector
  output sniff_spi_clk,
  output sniff_spi_cs,
  output sniff_spi_miso,
  output sniff_spi_mosi
  

  //aici pune miso,mosi,cs,...
  //important de tinut cont de directie
);

  // internal signals

  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;
 
// 3. Declare the PWM wires that controls the LED's

  /*here*/
  /*here*/
  /*here*/
  /*here*/ 
  //declaram pwm_led0... ca wires cu latime de 1 bit
  wire          pwm_led_0; 
  wire          pwm_led_1;
  wire          pwm_led_2; 
  wire          pwm_led_3; 


 ad_iobuf #(
    .DATA_WIDTH (4)
  ) i_iobuf_buttons (
    .dio_t (gpio_t[3:0]),
    .dio_i (gpio_o[3:0]),
    .dio_o (gpio_i[3:0]),
    .dio_p (btn));

  ad_iobuf #(
    .DATA_WIDTH (4)
  ) i_iobuf_leds (
    .dio_t (4'h0),
// 2. Connect the PWM wires to the input port of the ad_iobuf
    //dio_i controleaza ledurile care sunt deja legate
    //.dio_i ({/*here*/, /*here*/, /*here*/, /*here*/}),
    .dio_i ({pwm_led_3, pwm_led_2, pwm_led_1, pwm_led_0}),
    .dio_o (gpio_i[7:4]),
    .dio_p (led));

  assign gpio_i[63:32] = gpio_o[63:32];
  assign gpio_i[31:8] = gpio_o[31:8];

// 6. Clone the ADC SPI port to the sniffing ports 

  /*here*/
  /*here*/
  /*here*/
  /*here*/
  assign sniff_spi_clk = adc_spi_clk;  /*here*/
  assign sniff_spi_miso = adc_spi_miso;/*here*/
  assign sniff_spi_mosi = adc_spi_mosi;/*here*/
  assign sniff_spi_cs = adc_spi_cs;    /*here*/



  system_wrapper i_system_wrapper (
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .spi0_clk_i (),
    .spi0_clk_o (adc_spi_clk),   // 5. Connect here the SPI CLK
    .spi0_csn_0_o (adc_spi_cs), // 5. Connect here the SPI CS
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (adc_spi_miso),   // 5. Connect here the SPI MISO
    .spi0_sdo_i (),
    .spi0_sdo_o (adc_spi_mosi),   // 5. Connect here the SPI MOSI
    .spi1_clk_i (1'b0),
    .spi1_clk_o (),
    .spi1_csn_0_o (),
    .spi1_csn_1_o (),
    .spi1_csn_2_o (),
    .spi1_csn_i (1'b1),
    .spi1_sdi_i (1'b0),
    .spi1_sdo_i (1'b0),
    .spi1_sdo_o (),
// 1. Declare the block design ports and connect them to the PWM wires 
    /*here*/
    /*here*/
    /*here*/
    /*here*/
    //.pwm_led0...
    .pwm_led_0 (pwm_led_0),
    .pwm_led_1 (pwm_led_1),
    .pwm_led_2 (pwm_led_2),
    .pwm_led_3 (pwm_led_3));

endmodule
