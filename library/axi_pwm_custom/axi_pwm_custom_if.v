// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
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
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************
// This is the LVDS/DDR interface

`timescale 1ns/100ps

module axi_pwm_custom_if ( 

  input            pwm_clk,
  input            rstn,
  input    [11:0]  data_channel_0,
  input    [11:0]  data_channel_1,
  input    [11:0]  data_channel_2,
  input    [11:0]  data_channel_3,
  output           pwm_led_0,
  output           pwm_led_1,
  output           pwm_led_2,
  output           pwm_led_3
);

  localparam PULSE_PERIOD = 4095;

  // internal registers

  reg   [11:0]  pulse_period_cnt = 12'h0;
  reg           pwm_led_0_reg    = 1'b0;
  reg           pwm_led_1_reg    = 1'b0;
  reg           pwm_led_2_reg    = 1'b0;
  reg           pwm_led_3_reg    = 1'b0;
  reg   [11:0]  data_channel_0_reg = 12'h000;
  reg   [11:0]  data_channel_1_reg = 12'h000;
  reg   [11:0]  data_channel_2_reg = 12'h000;
  reg   [11:0]  data_channel_3_reg = 12'h000;

  
  // internal wires

  wire          end_of_period;  


// generate a signal named end_of_period witch has '1' logic value at the end of the signal period

  assign end_of_period = (pulse_period_cnt == PULSE_PERIOD) ? 1'b1 : 1'b0;

// Create a counter from 0 to PULSE_PERIOD

  always @(posedge pwm_clk) begin
    if (end_of_period) begin
      pulse_period_cnt <= 12'd1;
    end else begin
      pulse_period_cnt <= pulse_period_cnt + 12'h1;
    end
  end
  
// control the pwm signal value based on the input signal and counter value

  always @(posedge pwm_clk) begin
    pwm_led_0_reg <= (data_channel_0_reg > pulse_period_cnt) ? 1'b1 : 1'b0;
    pwm_led_1_reg <= (data_channel_1_reg > pulse_period_cnt) ? 1'b1 : 1'b0;
    pwm_led_2_reg <= (data_channel_2_reg > pulse_period_cnt) ? 1'b1 : 1'b0;
    pwm_led_3_reg <= (data_channel_3_reg > pulse_period_cnt) ? 1'b1 : 1'b0;
  end
  
// assign the output signal to the internal register

  assign pwm_led_0 = pwm_led_0_reg;
  assign pwm_led_1 = pwm_led_1_reg;
  assign pwm_led_2 = pwm_led_2_reg;
  assign pwm_led_3 = pwm_led_3_reg;

// make sure that the new data is processed only after the END_OF_PERIOD

  always @(posedge pwm_clk) begin
  
    if (end_of_period) begin
      data_channel_0_reg <= data_channel_0;
      data_channel_1_reg <= data_channel_1;
      data_channel_2_reg <= data_channel_2;
      data_channel_3_reg <= data_channel_3;
    end else begin
      data_channel_0_reg <= data_channel_0_reg;
      data_channel_1_reg <= data_channel_1_reg;
      data_channel_2_reg <= data_channel_2_reg;
      data_channel_3_reg <= data_channel_3_reg;
    end 
  end

endmodule
