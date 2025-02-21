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

module verilog_task_testbench (
  input            ref_clk,
  input            rstn,
  output   [11:0]  triangle_wave
);
  
reg [11:0] triangle_wave_reg;
integer decrement = 0;

initial begin
  triangle_wave_reg = 0;
end

always @(posedge ref_clk) begin
  if (rstn == 1'b0) begin
    triangle_wave_reg <= 0;
  end else begin
    // if decrement = 1, then decrement the triangle wave until it reaches 0
    if (decrement == 1) begin
      if (triangle_wave_reg == 0) begin
        decrement = 0;
      end else begin
        triangle_wave_reg <= triangle_wave_reg - 1;
      end
    end else begin
      // if decrement = 0, then increment the triangle wave until it reaches 4095
      if (triangle_wave_reg == 4095) begin
        decrement = 1;
      end else begin
        triangle_wave_reg <= triangle_wave_reg + 1;
      end
    end
  end
end

assign triangle_wave = triangle_wave_reg;

endmodule
