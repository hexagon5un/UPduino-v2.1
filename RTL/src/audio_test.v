`include "dac.v"

module top (
	output gpio_25,       
	output gpio_26      
);

// "BTL" Speaker Driver
wire out;
assign gpio_25 = out;
assign gpio_26 = ~out;

// Start up high-speed clock module
wire clk;
SB_HFOSC u_SB_HFOSC(.CLKHFPU(1), .CLKHFEN(1), .CLKHF(clk));

reg [31:0] counter = 0;
always @(posedge clk) begin
	counter <= counter + 1;
end

wire   sample_clock;
// sample-rate clock: 48 MHz / 1024 = 46.875 kHz
assign sample_clock = counter[9];
// sample-rate clock: 48 MHz / 2048 = 23.4375 kHz
/* assign sample_clock = counter[10]; */

// Use for incrementing base frequency
wire slowcount;
assign slowcount = counter[18];

reg [9:0] increment = 0;
always @(posedge slowcount) begin
	increment <= increment + 10'd 1;
end

// 14-bit DAC
// 13'h1FFF : 50% duty cycle
// Sawtooth wave, changing frequency offset every slowcount
reg [13:0] audio = 0;
always @(posedge sample_clock) begin
	audio <= audio + increment;
end

/* assign out = sample_clock; */
dac mydac (
	.clk (clk),
	.pcm (audio), // input to DAC
	.out (out) // connect to PWM pin
);

endmodule
