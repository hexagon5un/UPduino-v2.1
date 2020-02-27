//----------------------------------------------------------------------------
//                                                                          --
//                         Module Declaration                               --
//                                                                          --
//----------------------------------------------------------------------------
module rgb_blink
(
    // outputs
    output  wire        gpio_25,       
    output  wire        gpio_26,      
);
    SB_HFOSC  u_SB_HFOSC(.CLKHFPU(1), .CLKHFEN(1), .CLKHF(clk));

    reg [27:0]  counter;

    always @(posedge clk) begin
	    counter <= counter + 1;
    end

    // always on is irritating
    wire pulse;
    assign pulse = counter[22] & counter[24];
   
    // Speaker Driver
    wire out;
    assign gpio_25 = out;
    assign gpio_26 = ~out;
    
    // gate the output 
    assign out = pulse & (counter[26] ? counter[17] : counter[16]);



endmodule
