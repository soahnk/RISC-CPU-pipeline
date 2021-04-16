`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 06:29:43 PM
// Design Name: 
// Module Name: preIF
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


module preIF(
   input [1:0]  BS, 
   input PS,  
   input Z,
   input [15:0] nPC,
   input [31:0] BrA,
   input [31:0] RAA,
   output [15:0] PC_out
  
       );
    
assign PC_out = ((BS==0)||(BS==1 && PS==0 && Z==0)||(BS==1 && PS==1 && Z==1))  ? nPC :
            ((BS==1 && PS==0 && Z==1)||(BS==1 && PS==1 && Z==0)||(BS==3))  ? BrA  :
            (BS==2) ? RAA : 0 ;    
       
endmodule
