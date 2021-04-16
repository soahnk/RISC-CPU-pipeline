`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2020 04:58:00 PM
// Design Name: 
// Module Name: alu
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


module alu(
   input [31:0]  A,  // Operand
   input [31:0]  B,  // Operand
   input [3:0] 	 Gselect, // Operation
   output reg    C,  // Carry
   output reg	 V,  // Overflow
   output [31:0] G  // Result 
);
   
   reg [32:0] result;
   assign G = result[31:0];
   
    localparam transferA = 3'b000;
    localparam incrementA = 3'b001;
    localparam addition = 3'b010;
    localparam add_carry1 = 3'b011;
    localparam A_plus_notB = 3'b100;
    localparam subtraction = 3'b101;
    localparam decrementA = 3'b110;    
    localparam transferA2 = 3'b111; 
    localparam andAB = 3'b00x;
    localparam orAB = 3'b01x;
    localparam xorAB = 3'b10x;
    localparam notA = 3'b11x;
     
    always @ (*)
    begin
           case(Gselect[3])
            0:
            begin 
                case(Gselect[2:0])
                    transferA: result=A;
                    incrementA: result = A+1;
                    addition:result = A+B;
                    add_carry1:result = A+B+1;
                    A_plus_notB:result = A+~B;
                    subtraction:result = A+~B+1;
                    decrementA:result = A-1;
                    transferA2:result = A;
                    default:result<=0; 
                 endcase
             end
             1:
             begin
                 casex(Gselect[2:0])
                    andAB: result = A&B;
                    orAB: result = A|B;
                    xorAB: result = A^B;
                    notA: result = ~A;   
                    default:result<=0;                 
                endcase
            end
        endcase        
       
        C <= result[32];
        V <= (A[31] == B[31]) ? 1'b0 : (~(A[31] ^ B[31])) ^ (G[31]);        
        
        
    end
 endmodule 