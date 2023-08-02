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

  reg    [11:0]  pulse_period_cnt = 12'b0;;
  reg    [11:0]  current_data_ch_0;
  reg    [11:0]  current_data_ch_1;
  reg    [11:0]  current_data_ch_2;
  reg    [11:0]  current_data_ch_3;
  reg            pwm_led_0_value = 1'b0;
  reg            pwm_led_1_value = 1'b0;
  reg            pwm_led_2_value = 1'b0;
  reg            pwm_led_3_value = 1'b0;

  // internal wires

  wire            end_of_period; 

// generate a signal named end_of_period witch has '1' logic value at the end of the signal period

  assign end_of_period = (pulse_period_cnt == PULSE_PERIOD) ? 1'b1 : 1'b0;

  assign pwm_led_0 = pwm_led_0_value;
  assign pwm_led_1 = pwm_led_1_value;
  assign pwm_led_2 = pwm_led_2_value;
  assign pwm_led_3 = pwm_led_3_value;

// Create a counter from 0 to PULSE_PERIOD

  always @(posedge pwm_clk) begin
    if(end_of_period || !rstn) begin
      pulse_period_cnt <= 12'b0;
    end else begin
      pulse_period_cnt <= pulse_period_cnt + 1'b1;
    end
  end

// control the pwm signal value based on the input signal and counter value


  //assign pwm_led_0 = (pulse_period_cnt <= current_data_ch_0) ? 1'b1 : 1'b0;
  //assign pwm_led_1 = (pulse_period_cnt <= current_data_ch_1) ? 1'b1 : 1'b0;
  //assign pwm_led_2 = (pulse_period_cnt <= current_data_ch_2) ? 1'b1 : 1'b0;
  //assign pwm_led_3 = (pulse_period_cnt <= current_data_ch_3) ? 1'b1 : 1'b0;

 always @(posedge pwm_clk) begin
    if (pulse_period_cnt <= current_data_ch_0) begin
      pwm_led_0_value <= 1'b1;
    end else begin
      pwm_led_0_value <= 1'b0;
    end

    if (pulse_period_cnt <= current_data_ch_1) begin
      pwm_led_1_value <= 1'b1;
    end else begin
      pwm_led_1_value <= 1'b0;
    end

    if (pulse_period_cnt <= current_data_ch_2) begin
      pwm_led_2_value <= 1'b1;
    end else begin
      pwm_led_2_value <= 1'b0;
    end

    if (pulse_period_cnt <= current_data_ch_3) begin
      pwm_led_3_value <= 1'b1;
    end else begin
      pwm_led_3_value <= 1'b0;
    end
  end

// make sure that the new data is processed only after the END_OF_PERIOD

  always @(posedge pwm_clk) begin
  
    if (end_of_period) begin
      current_data_ch_0 <= data_channel_0;
      current_data_ch_1 <= data_channel_1;
      current_data_ch_2 <= data_channel_2;
      current_data_ch_3 <= data_channel_3;
    end else begin
      current_data_ch_0 <= current_data_ch_0;
      current_data_ch_1 <= current_data_ch_1;
      current_data_ch_2 <= current_data_ch_2;
      current_data_ch_3 <= current_data_ch_3;
    end 
  end

endmodule
