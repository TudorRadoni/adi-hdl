`timescale 1ns/100ps

module axi_pwm_custom_if ( 

  input            pwm_clk,
  input            rstn,
  input    [11:0]  data_channel_0,
  input    [11:0]  data_channel_1,
  input    [11:0]  data_channel_2,
  input    [11:0]  data_channel_3,
  output     reg      pwm_led_0,
  output     reg      pwm_led_1,
  output      reg     pwm_led_2,
  output      reg     pwm_led_3
);

  localparam PULSE_PERIOD = 4095;
  reg [11:0] pulse_period_cnt = 0;
  reg [11:0] pulse_period_d = 12'd4095;

  // internal wires

  wire           end_of_period;  


// generate a signal named end_of_period witch has '1' logic value at the end of the signal period

  assign end_of_period = (pulse_period_cnt == pulse_period_d) ? 1'b1 : 1'b0;

// Create a counter from 0 to PULSE_PERIOD

  always @(posedge pwm_clk) begin
    if(end_of_period == 1'b1) begin
      pulse_period_cnt <= 12'd1;
    end else begin
      pulse_period_cnt <= pulse_period_cnt + 1'b1;
    end
  end

// control the pwm signal value based on the input signal and counter value

  always @(posedge pwm_clk or negedge rstn) begin
    if(!rstn) begin
      pwm_led_0 <= 1'b0;
      pwm_led_1 <= 1'b0;
      pwm_led_2 <= 1'b0;
      pwm_led_3 <= 1'b0;
    end else begin
    pwm_led_0 <= (data_channel_0 > pulse_period_cnt);
    pwm_led_1 <= (data_channel_1 > pulse_period_cnt);
    pwm_led_2 <= (data_channel_2 > pulse_period_cnt);
    pwm_led_3 <= (data_channel_3 > pulse_period_cnt);
    end
  end  

// make sure that the new data is processed only after the END_OF_PERIOD

  always @(posedge pwm_clk) begin
  
    if (end_of_period) begin
  
    end else begin
  
    end 
  end

endmodule
