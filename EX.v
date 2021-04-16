`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 05:00:04 AM
// Design Name: 
// Module Name: EX
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


module EX(
    input clk,rst,
    input [15:0] pc_2,
    input [4:0] DA,SH,FS,
    input  RW,PS,MW,    
    input [1:0]	MD,BS,
    input [31:0] BusA,BusB,
    output RW_EX,
    output [4:0] DA_EX,
    output [1:0] MD_EX,
    output [31:0] F,
    output  NxorV,C,V,N,Z,
    output [31:0] Data_out,
    output [31:0] BrA,
    output [31:0] RAA
    );
     
    assign BrA = pc_2 + BusB;
    assign RAA=BusA;   
    
    functionunit fu (
        .A(BusA),
        .B(BusB),
        .FS(FS),
        .SH(SH),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .F(F)
    );
    assign NxorV=N^V;
    //wire [31:0] dataout;
    DataMemory dm (
        .clk(clk),
        .rst(rst),
        .MW(MW),
        .memaddr(BusA[5:0]),
        .datain(BusB),
        .dataout(Data_out)
    );
    assign RW_EX = RW;
    assign DA_EX = DA;
    assign MD_EX = MD;  
endmodule
