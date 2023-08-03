`timescale 1ns/100ps

module verilog_task_testbench ( 

  input            ref_clk,
  input            rstn,
  output [11:0]  triangle_wave
);

  reg [11:0] count;
  reg dir; // direction control bit, 0 for up, 1 for down

  always @(posedge ref_clk or negedge rstn) begin
    if (!rstn) begin
      count <= 12'd0; // reset count to 0
      dir <= 1'b0; // set direction to up
    end else begin
      if (dir == 1'b0) begin
        if (count == 12'd4095) // if count reached max value
          dir <= 1'b1; // change direction to down
        else
          count <= count + 12'd1;
      end else begin
        if (count == 12'd0) // if count reached min value
          dir <= 1'b0; // change direction to up
        else
          count <= count - 12'd1;
      end
    end
  end

  assign triangle_wave = count;

endmodule
