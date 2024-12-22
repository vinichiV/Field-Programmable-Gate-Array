module ShiftLed(CLOCK_50, LEDR, SW, KEY);
    input CLOCK_50; input SW, KEY;
    output reg [9:0] LEDR;
    reg [24:0] counter;
    reg tmp;
	
    always @(posedge CLOCK_50)
        counter <= counter + 1'b1;
	
    always @(posedge KEY)
        tmp = ~tmp;

    always @(posedge counter [22])
        if (LEDR == 10'b0) LEDR = 10'b1;
        else if (SW && tmp==0) LEDR = {LEDR[8:0], LEDR[9]};
        else if (SW == 0 && tmp==0) LEDR = {LEDR[0], LEDR[9:1]};

endmodule
