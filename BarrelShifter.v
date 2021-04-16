`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 10:43:21 AM
// Design Name: 
// Module Name: BarrelShifter
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

module BarrelShifter(
    input [31:0] A,
    input [31:0] B,
    input [5:0] SH,
    input [2:0] Hselect,        // FS[3:1]
    input L,    // !FS[0]
    output reg [31:0] H
    );
    
    parameter logical = 0, arithmetic = 1, rot = 2;
    
    wire [63:0] LOGICAL;
    wire [63:0] ARITHMETIC;
    wire [63:0] ROT;
        
    reg [63:0] H_out;   
    
    assign LOGICAL = {32'b0, A};
    assign ARITHMETIC = {{32{A[31]}}, A};
    assign ROT = {A,A};
        
    always @(*) begin   
        case(Hselect)
            logical: H_out <= L ? LOGICAL << SH : LOGICAL >> SH;
            arithmetic: H_out <= L ? ARITHMETIC << SH : ARITHMETIC >> SH;
            rot: H_out <= L ? ROT >> (32-SH) : ROT >> SH;
            default: H_out = A;
         endcase
         
         H <= ((Hselect == 3'd3) & L) ? H_out[63:32] : H_out;
    end
        
endmodule
