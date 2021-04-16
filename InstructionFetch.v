`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 02:06:38 AM
// Design Name: 
// Module Name: InstructionFetch
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


module InstructionFetch(
    //input clk,rst,
	input [15:0] pc,
	output [31:0] instruction,
	output [15:0] pc_1
	);  
	wire [31:0] instruction_out;
    InstructionMemory mem1 (
                          .pc (pc),
                          .instruction (instruction_out)  
                            ); 
    
    assign pc_1=pc+16'b1;
    assign instruction=instruction_out;
    
endmodule
