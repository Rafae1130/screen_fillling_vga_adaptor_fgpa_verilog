module vga_adaptor(CLOCK_50, SW, KEY,
				VGA_R, VGA_G, VGA_B,
				VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	
	input CLOCK_50;	
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK;
	output VGA_SYNC;
	output VGA_CLK;	
	
	reg [2:0] colour;
	
	reg [7:0] x;
	reg [6:0] y;
	
	
	
	always @(posedge CLOCK_50 , negedge KEY[3] )
	begin
		if(!KEY[3])
		begin
			x<=0;
			y<=0;
			colour=0;
		end
		else if(x==159 && y!=119)
		begin
			x<=0;
			y<=y+1;
			colour=colour+1;
		end
		else 
		begin
			x=x+1;
		end
		
	end


	vga_adapter VGA(
			.resetn(KEY[3]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
			
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "image.colour.mif";
		defparam VGA.USING_DE1 = "TRUE";
		
endmodule