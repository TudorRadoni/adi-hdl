`timescale 1ns/100ps

module verilog_task_testbench_tb;
  parameter VCD_FILE = "verilog_task_testbench_tb.vcd";

  `define TIMEOUT 900

wire [11:0] triangle_wave;
reg pwm_clk = 1'b0;
reg reset_in = 1'b0;

always #1 pwm_clk <= ~pwm_clk;

initial begin
  #50 reset_in=1'b1;
end


  verilog_task_testbench  verilog_task_testbench_inst (
    .ref_clk(pwm_clk), // Connect to pwm_clk instead of undefined ref_clk
    .rstn(reset_in),   // Connect to reset_in instead of undefined rstn
    .triangle_wave(triangle_wave)
  );
endmodule
