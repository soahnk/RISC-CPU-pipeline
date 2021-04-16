`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2020 08:34:59 PM
// Design Name: 
// Module Name: ConstantUnit
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


module ConstantUnit(
        input CS,
        input [14:0] IM,
        output [31:0] ConstantUnit
    );
    assign ConstantUnit= (CS==1'b0)? 0:1 ;
    //assign ConstantUnit= (CS==1'b0)? 0:({{17{IM[14]}}, IM}) ;
      
endmodule
