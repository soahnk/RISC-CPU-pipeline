`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2020 01:49:40 AM
// Design Name: 
// Module Name: WB
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


module WB(
    input clk,rst,
    input RW,
    input [4:0] DA,
    input [1:0] MD,
    input NxorV,
    input [31:0] F,
    input [31:0] Data_out,
    output reg [31:0] BusD
    );
    
    always @(*) begin
        case (MD) 
            2'b00: BusD <= F;
            2'b01: BusD <= Data_out;
            2'b10: BusD <= {{31'b0}, NxorV};
            default: BusD <= 32'bX;
        endcase
    end
    RegFile rf_wb ( .clk (clk),
                  .rst (rst),  
                   .RW (RW),
                   .AA (0),
                   .BA (0),
                   .DA (DA),
                   .Writedata (BusD)                  
                );
endmodule
