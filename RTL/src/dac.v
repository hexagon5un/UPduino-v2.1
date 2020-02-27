/* Quick and dirty sigma-delta converter */
`timescale 1ns/1ns

module dac (
	input clk,
	input [13:0] pcm,
	output out
);

// buffer when comes in
reg [13:0] sample;
always @(pcm) begin
	sample = pcm;
end

reg [14:0] accumulator;
always @(posedge clk) begin
	accumulator <= accumulator[13:0] + sample;
end

assign out = accumulator[14];

endmodule

