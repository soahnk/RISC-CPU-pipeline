`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 11:42:18 AM
// Design Name: 
// Module Name: RegFile
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

module RegFile(
input clk,rst,
	input RW,
	input C,V,N,Z,
	input [4:0] FS,
	input [4:0] AA,BA,DA,
	input [31:0] Writedata,	
	output [31:0] A_data,B_data	
	);
	
	reg [31:0] Registers [0:31];
	
	   
	integer i;
    
    initial begin
        //Registers[31]=32'd0;
        for(i = 0; i < 32; i = i + 1) 
            Registers[i] = 0;
        Registers[21]=37;
        end
    
    always @(posedge clk) begin 
        if(rst)
            for(i = 0; i < 32; i = i + 1)
                Registers[i] = i;         // clear all regs on reset
        else begin  
            if (FS !=0)
                Registers[31] <= {28'b0,Z,V,N,C};         
             if(RW) begin 
                if (DA != 5'b0)                                            
                Registers[DA] <= Writedata;
              end   
        end
        end
assign A_data = Registers[AA];
assign B_data = Registers[BA];

endmodule
