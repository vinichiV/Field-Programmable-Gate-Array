module Timer(input CLOCK_50, input [1:0] KEY, output [0:6] HEX0, 
	output [0:6] HEX1, output [0:6] HEX2, output [0:6] HEX3);
	
	reg [25:0] counter, led_time;
	reg [3:0] giay_donvi, giay_chuc, phut_donvi, phut_chuc;
	reg flag, KEY0, KEY1;
	initial led_time = 26'd50000000;
	
	always @(posedge CLOCK_50)
		begin
			KEY0 <= KEY[0];
			KEY1 <= KEY[1];
			if (KEY0 && ~KEY[0])
				begin
					giay_donvi <= 4'b0;
					giay_chuc <= 4'b0;
					phut_donvi <= 4'b0;
					phut_chuc <= 4'b0;
				end
		
			if (KEY1 && ~KEY[1])
				begin
					if (flag)	flag <= 1'b0;
					else	flag <= 1'b1;
				end
		
			if (counter >= led_time)
			begin
				counter <= 26'b0;
				if (flag)
				begin
					if (giay_donvi == 4'b1001)
					begin
						if (giay_chuc == 4'b0101)
						begin
							if (phut_donvi == 4'b1001)
							begin
								if (phut_chuc == 4'b0101)
									phut_chuc <= 4'b0;
									
					            else
						            phut_chuc <= phut_chuc + 1'b1;
						            phut_donvi <= 4'b0;
					        end
							
					        else
						        phut_donvi <= phut_donvi + 1'b1;
					           giay_chuc <= 4'b0;	
				        end
							
				        else
					        giay_chuc <= giay_chuc + 1'b1;
				           giay_donvi <= 4'b0;
			        end
					
			        else
				        giay_donvi <= giay_donvi + 1'b1;
		        end
	        end
		    
            else
	            counter <= counter + 1'b1;
        end	
	HEX_display a0(.a(giay_donvi), .b(HEX0));
	HEX_display a1(.a(giay_chuc), .b(HEX1));
	HEX_display a2(.a(phut_donvi), .b(HEX2));
	HEX_display a3(.a(phut_chuc), .b(HEX3));
endmodule 

module HEX_display(input [3:0] a, output reg [0:6] b);
	always @(*)
	begin
		b = (a == 4'b0000) ? 7'b0000001 : // 0
				(a == 4'b0001) ? 7'b1001111 : // 1
				(a == 4'b0010) ? 7'b0010010 : // 2
				(a == 4'b0011) ? 7'b0000110 : // 3
				(a == 4'b0100) ? 7'b1001100 : // 4
				(a == 4'b0101) ? 7'b0100100 : // 5
				(a == 4'b0110) ? 7'b0100000 : // 6
				(a == 4'b0111) ? 7'b0001111 : // 7
				(a == 4'b1000) ? 7'b0000000 : // 8
				(a == 4'b1001) ? 7'b0000100 : // 9
				(a == 4'b1010) ? 7'b0001000 : // A
				(a == 4'b1011) ? 7'b1100000 : // B
				(a == 4'b1100) ? 7'b0110001 : // C
				(a == 4'b1101) ? 7'b1000010 : // D
				(a == 4'b1110) ? 7'b0110000 : // E
				7'b0111000;  // F
	end
endmodule
