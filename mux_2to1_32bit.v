`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 02:28:18 AM
// Design Name: 
// Module Name: mux_2to1_32bit
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


module mux_2to1_32bit(
    input   [31:0] inA,
    input   [31:0] inB,
    input          select,
    output [31:0] out
    );
  assign out = select ?inA:inB;  
    
endmodule
