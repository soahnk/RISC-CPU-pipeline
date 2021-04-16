`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2020 04:56:43 PM
// Design Name: 
// Module Name: functionunit
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


module functionunit(
   input [31:0]  A,  
   input [31:0]  B,  
   input  [4:0] FS,
   input [4:0] SH,
   output reg [31:0] F,  
   output 	 C,  // Carry.
   output 	 V,  // Negative.
   output reg	 N,  // Overflow.
   output reg	 Z  // Zero
    );
    
    wire MFselect;
    wire [3:0]Gselect;
    wire [1:0] Hselect;
    
    
    wire [31:0] g_out;
    wire [31:0] h_out;
    wire [31:0] f_out;
    
    assign MFselect = FS [4];
    assign Gselect  = FS[3:0];
    assign Hselect  = FS[3:2];
    
    alu aluF(
        .A  (A),
        .B  (B),
        .Gselect (Gselect),
        .C  (C),       
        .V  (V),       
        .G  (g_out)
        );
   BarrelShifter bs(
        .A(A),
        .B(B),
        .SH({1'b0, SH}),
        .Hselect(FS[3:1]),
        .L(!FS[0]),
        .H(h_out)
    );
    
  mux_2to1_32bit muxf ( .inA (h_out),
                          .inB (g_out),
                          .select (MFselect),
                          .out (f_out)  
                            ); 
  
   always @(*) begin   
        F <= f_out;
        Z <= ~| f_out;
        N <= f_out[31];
   end 
    
endmodule

