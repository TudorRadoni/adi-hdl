`timescale 1ns/100ps

module axi_pwm_custom_if ( 

  input            pwm_clk,
  input            rstn,
  input    [11:0]  data_channel_0,
  input    [11:0]  data_channel_1,
  input    [11:0]  data_channel_2,
  input    [11:0]  data_channel_3,
  output       pwm_led_0,
  output       pwm_led_1,
  output       pwm_led_2,
  output       pwm_led_3
);

  localparam PULSE_PERIOD = 4095;
  reg [11:0] pulse_period_cnt = 0; // declared as register
  reg [11:0] pulse_period_d   = 12'd4095;
  reg [11:0] data_channel_0_latched = 0; // declaration
  reg [11:0] data_channel_1_latched = 0; // declaration
  reg [11:0] data_channel_2_latched = 0; // declaration
  reg [11:0] data_channel_3_latched = 0; // declaration
  // internal registers
  reg             pwm_led_0_s = 1'b0;
  reg             pwm_led_1_s = 1'b0;
  reg             pwm_led_2_s = 1'b0;
  reg             pwm_led_3_s = 1'b0;

  // internal wires

  wire           end_of_period;  

  assign pwm_led_0 = pwm_led_0_s; 
  assign pwm_led_1 = pwm_led_1_s;
  assign pwm_led_2 = pwm_led_2_s;
  assign pwm_led_3 = pwm_led_3_s;

// generate a signal named end_of_period which has '1' logic value at the end of the signal period OK

  assign end_of_period = (pulse_period_cnt == pulse_period_d) ? 1'b1 : 1'b0;

// Create a counter from 0 to PULSE_PERIOD OK

  always @(posedge pwm_clk) begin
    if(end_of_period == 1'b1) begin
      pulse_period_cnt <= 12'd1;
    end else begin
      pulse_period_cnt <= pulse_period_cnt + 1'b1;
    end
  end

// control the pwm signal value based on the input signal and counter value OK

    always @(posedge pwm_clk or negedge rstn) begin
        if (!rstn) begin
            pwm_led_0_s <= 1'b0;
            pwm_led_1_s <= 1'b0;
            pwm_led_2_s <= 1'b0;
            pwm_led_3_s <= 1'b0;
        end else begin
            // Generate PWM output signals using the sawtooth signals
            pwm_led_0_s <= (data_channel_0_latched > pulse_period_cnt);
            pwm_led_1_s <= (data_channel_1_latched > pulse_period_cnt);
            pwm_led_2_s <= (data_channel_2_latched > pulse_period_cnt);
            pwm_led_3_s <= (data_channel_3_latched > pulse_period_cnt);
        end
    end

// make sure that the new data is processed only after the END_OF_PERIOD

  always @(posedge pwm_clk) begin
  
    if (end_of_period) begin
      data_channel_0_latched <= data_channel_0;
      data_channel_1_latched <= data_channel_1;
      data_channel_2_latched <= data_channel_2;
      data_channel_3_latched <= data_channel_3;
    end 
  end

endmodule
