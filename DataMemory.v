`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2020 02:56:10 PM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(
    input clk,rst,
    input MW,
    input [5:0] memaddr,
    input [31:0] datain,
    output [31:0] dataout
    );
    
    reg [31:0] datamemory[63:0];
    integer i;
    
    assign dataout = datamemory[{58'b0, memaddr}];
    
    initial begin
        for (i = 0; i < 64; i = i + 1)
            datamemory[i] = i;
    end
    
    always @(posedge clk) begin
        if (rst)
            for (i = 0; i < 64; i = i + 1) 
                datamemory[i] = i;
        else if (MW)
            datamemory[memaddr] <= datain;
    end
    
endmodule