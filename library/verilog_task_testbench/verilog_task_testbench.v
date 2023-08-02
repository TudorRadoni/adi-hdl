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
reg [11:0] counter = 0;
parameter val_max = 4095;
   reg updown = 1'b1; // 1 = going up, 0 = going down
	
	//create a triangle wave centered at zero that has a period of ~5 seconds (assuming a 100MHz input clock)
   always @(posedge(ref_clk)) begin
      if (!rstn) 
      begin
         counter <= 0;
         end
      else  if (updown == 1)
         begin
                  if (counter == val_max) 
               begin
                  updown <= 0;
                end 
                else
                  begin
                  counter <= counter + 1;
                  end
                end
            else 
              begin
               if (counter == 0) begin
                  updown <= 1;
                 end
                 else
                   begin
                  counter <= counter - 1;
               
               end
            end
            
         end
   assign triangle_wave = counter;
endmodule
