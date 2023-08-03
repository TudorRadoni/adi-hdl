`timescale 1ns/100ps

module axi_pwm_custom_if_tb;
  parameter VCD_FILE = "axi_pwm_custom_if_tb.vcd";

  `define TIMEOUT 50000
  `include "../common/tb/tb_base.v"

  reg           resetn_in        = 1'b0;
  reg           pwm_clk          = 1'b0;
  reg   [11:0]  data_channel_0   = 12'b0;
  reg   [11:0]  data_channel_1   = 12'b0;
  reg   [11:0]  data_channel_2   = 12'b0;
  reg   [11:0]  data_channel_3   = 12'b0;
  reg   [11:0]  pulse_period_cnt = 12'h0;
  reg   [11:0]  pulse_period_d   = 12'd4095;

  wire          end_of_period;  
  wire          pwm_led_0; 
  wire          pwm_led_1;
  wire          pwm_led_2; 
  wire          pwm_led_3; 

  // generates the reference clock signal 

  always #1 pwm_clk <= ~pwm_clk;

  // test the reset functionality

  initial begin
    #50 resetn_in = 1'b1;
  end

  // generates a sawtooth signal which increments once at 4096 clock periods to test the functionality 

  always @(posedge pwm_clk) begin 
    if(data_channel_1 == 12'hFFF) begin 
      data_channel_0 <= 12'b0;
      data_channel_1 <= 12'b0;
      data_channel_2 <= 12'b0;
      data_channel_3 <= 12'b0;
    end else if(end_of_period == 1'b1) begin 
      data_channel_0 <= data_channel_0 + 12'h10;
      data_channel_1 <= data_channel_1 + 12'h10;
      data_channel_2 <= data_channel_2 + 12'h10;
      data_channel_3 <= data_channel_3 + 12'h10;  
    end else begin
      data_channel_0 <= data_channel_0;
      data_channel_1 <= data_channel_1;
      data_channel_2 <= data_channel_2;
      data_channel_3 <= data_channel_3;
    end
  end

  assign end_of_period =(pulse_period_cnt == pulse_period_d) ? 1'b1 : 1'b0;

  always @(posedge pwm_clk) begin
    if(end_of_period == 1'b1) begin
      pulse_period_cnt <= 12'd1;
    end else begin
      pulse_period_cnt <= pulse_period_cnt + 1'b1;
    end
  end
  
 // interface module that needs to be tested 

  axi_pwm_custom_if axi_pwm_custom_if_dut(
    .pwm_clk(pwm_clk),
    .rstn(resetn_in),
    .data_channel_0(data_channel_0),
    .data_channel_1(data_channel_1),
    .data_channel_2(data_channel_2),
    .data_channel_3(data_channel_3),
    .pwm_led_0(pwm_led_0),
    .pwm_led_1(pwm_led_1),
    .pwm_led_2(pwm_led_2),
    .pwm_led_3 (pwm_led_3));

endmodule
