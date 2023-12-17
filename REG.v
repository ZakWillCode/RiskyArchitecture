module register  
 (  
	input		   		         rst, 
	input 		        	     clk, 
    
	input 		      	[1:0] 	ra,
	input			[1:0]	rb,
	input			[1:0]	wb,
	input 	signed  	[7:0]   data, 
	input 			    	    reg_en,
	input				reg_in_en,
        
	output 	signed 		[7:0]	reg_data1,
	output 	signed		[7:0]	reg_data2 
 );  

	reg	signed  [7:0]	reg_array [0:3];	//setup the registers
	
	always @ (negedge clk) begin 	//Write on neg edge clock to keep everything in one clock cycle
		
		if(rst) begin  				//resets registers
			reg_array[0] <= 8'b0;
			reg_array[1] <= 8'b0;
			reg_array[2] <= 8'b0;
			reg_array[3] <= 8'b0;
		end else if(reg_en || reg_in_en) begin  				//
				reg_array[wb] <= data;  	//writes new values to R[ra]
			end  
	end 

	assign reg_data1 = reg_array[ra];
    	assign reg_data2 = reg_array[rb];

endmodule  