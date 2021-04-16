`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 02:30:18 PM
// Design Name: 
// Module Name: ProgramCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ProgramCounter(
    input clk,rst,//pc_write,
    input [31:0] npc,
	output reg [31:0] pc_out)
	;
    initial
    begin
        pc_out<=0;
    end
    always @ ( posedge clk )
        begin
          if (rst == 1)
    		  pc_out <= 32'h00000000;
    	  else
    	   begin
			//if (pc_write == 1)
				pc_out <= npc;
			end
			//$display("PC=%h",pc_out);
		end  	
endmodule
