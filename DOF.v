`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 12:20:24 PM
// Design Name: 
// Module Name: DOF
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


module DOF(

   input [15:0] pc_1,
   input [31:0] ir,
   output [31:0] A_data,B_data,//from regfile
   output [4:0] DA,SH,FS,
   output  RW,PS,MW,    //Controlword values
    output [1:0]	MD,BS,
    output [15:0] pc_2,
    output [31:0] BusA,BusB,
    output [31:0] CU,
    output reg [4:0] AA = 5'b0, //SA
    output reg [4:0] BA = 5'b0 //SB
    );
    
    
    //////initial//////////////////initial
    wire [6:0] opcode;
    wire [4:0] AA,BA;
    wire [14:0] IM;
    //wire [4:0] SH;
    assign opcode=ir[31:25];
    assign IM=ir[14:0];
    assign DA=ir[24:20];    
    assign AA=ir[19:15];
    assign BA=ir[14:10];
    assign SH=ir[4:0];
    assign pc_2=pc_1;
   
    wire [31:0] BusA,BusB;
    wire MA,MB,CS;
    mux_2to1_32bit muxa ( .inA ({0,pc_1[15:0]}),
                          .inB (A_data),
                          .select (MA),
                           .out (BusA)
    ); 
    mux_2to1_32bit muxb ( .inA (CU),
                          .inB (B_data),
                          .select (MB),
                           .out (BusB)
    ); 
    
    InstructionDecoder id (	.ir (ir) ,
                            .RW (RW),
                            .MD (MD),
                            .BS (BS),
                            .PS (PS),
                            .MW (MW),
                            .FS (FS),
                            .MA (MA),
                            .MB (MB),
                            .CS (CS)                            
                            );

//  RegFile rf1 ( .clk (clk),
//                  .rst (rst),  
//                   .RW (0),//from DOF_EX
//                   .AA (AA),//from DOF
//                   .BA (BA),//from DOF
//                   //.DA (DA_EX_latch),//from EX_WB
//                   //.Writedata (BusD),//from WB
//                   .A_data (A_data),//DOF
//                   .B_data (B_data)//DOF
//                );

        assign  CU = CS ? {{17{IM[14]}}, IM[14:0]} : {{17{1'b0}}, IM[14:0]}; // constant unit         
  
 
endmodule
