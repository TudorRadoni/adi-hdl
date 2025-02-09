// ***************************************************************************
// ***************************************************************************
// Copyright 2022 - 2023(c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL(Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository(LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository(LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_pwm_custom_if_tb;
  parameter VCD_FILE = "axi_pwm_custom_if_tb.vcd";

  `define TIMEOUT 35000
  `include "../common/tb/tb_base.v"

  reg           resetn_in        = 1'b0;
  reg           pwm_clk          = 1'b0;
  reg   [11:0]  data_channel_0   = 12'd1024;
  reg   [11:0]  data_channel_1   = 12'd2048;
  reg   [11:0]  data_channel_2   = 12'd4095;
  reg   [11:0]  data_channel_3   = 12'd500;
  reg   [11:0]  pulse_period_cnt = 12'h0;
  reg   [11:0]  pulse_period_d   = 12'd4095;

  reg           inc_rate         = 1'b1; // 0 = full period, 1 = half period

  wire          end_of_period;
  wire          inc_signal;
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
    end else if(inc_signal == 1'b1) begin 
      data_channel_0 <= data_channel_0 + 12'd500;
      data_channel_1 <= data_channel_1 + 12'd200;
      data_channel_2 <= data_channel_2 + 12'd200;
      data_channel_3 <= data_channel_3 + 12'd200;  
    end else begin
      data_channel_0 <= data_channel_0;
      data_channel_1 <= data_channel_1;
      data_channel_2 <= data_channel_2;
      data_channel_3 <= data_channel_3;
    end
  end

  assign end_of_period = (pulse_period_cnt == pulse_period_d);
  assign inc_signal = (pulse_period_cnt == (pulse_period_d >> inc_rate));

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
    .pwm_led_3(pwm_led_3));

endmodule
