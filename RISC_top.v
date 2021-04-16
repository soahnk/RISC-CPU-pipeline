`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 07:26:20 AM
// Design Name: 
// Module Name: RISC_top
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2020 03:19:59 AM
// Design Name: 
// Module Name: Controller
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


module RISC_top(
    input clk,rst
    );
    //////////Fetch////////////////////////////////
    reg [15:0] pc_reg=16'b0;
    wire [15:0] pc_1;  
    wire [31:0] ir;  
    InstructionFetch if1 (.pc (pc_reg),
                          .pc_1 (pc_1),
                          .instruction (ir)  
                            );  
    
    //////////////////Decode//////////////////////////////////
    wire [31:0] A_data;
    wire [31:0] B_data;
    wire [4:0] DA,SH,FS;
    wire RW,PS,MW;    
    wire [1:0] MD,BS;
    wire [15:0] pc_2;
    wire [31:0] BusA,BusB;
    wire [31:0] CU;  
    wire [4:0] AA,BA;
    reg [15:0] pc_1_latch = 16'b0;               
    reg [31:0] ir_latch = 32'b0;  
    DOF df (
            .pc_1(pc_1_latch),//from IF
            .ir (ir_latch),//from IF
            .A_data (A_data),//from RegFile
            .B_data (B_data),//from RegFile
            .DA (DA),
            .AA (AA),
            .BA (BA),
            .SH (SH),
            .FS (FS),
            .RW (RW),
            .PS (PS),
            .MW (MW),
            .MD (MD),
            .BS (BS),
            .pc_2 (pc_2),
            .BusA (BusA),
            .BusB (BusB),
            .CU (CU) //ConstantUnit            
            );                       
    /////////////////////Execute////////////////////////////////
    reg [4:0] DA_latch,SH_latch,FS_latch=0;
    reg RW_latch,PS_latch,MW_latch=0;    
    reg [1:0] MD_latch,BS_latch=0;
    reg [31:0] BusA_latch,BusB_latch=0;
    wire RW_EX,NxorV,C,V,N,Z;
    wire [4:0] DA_EX;
    wire [1:0] MD_EX;
    wire [31:0] F;
    wire [31:0] RAA;
    wire [31:0] BrA;
    wire [31:0] Data_out;
    reg [15:0] pc_2_latch = 16'b0;
    EX ex1 ( .clk (clk),
             .rst (rst),
             .pc_2(pc_2_latch),
            .DA (DA_latch),
            .SH (SH_latch),
            .FS (FS_latch),
            .RW (RW_latch),
            .PS (PS_latch),
            .MW (MW_latch),
            .MD (MD_latch),
            .BS (BS_latch),
            .BusA (BusA_latch),
            .BusB (BusB_latch),
            .RW_EX (RW_EX),
            .DA_EX (DA_EX),
            .MD_EX (MD_EX),
            .F (F),
            .NxorV (NxorV),.C (C),.V (V),.N (N),.Z (Z),
            .Data_out (Data_out),
            .BrA (BrA),
            .RAA (RAA)   
    );
    /////////////////MUXc//////////////////////////////////
    wire [31:0] npc_mux;
   // wire branch_logic;
    preIF mc (        .BS (BS_latch),
                        .PS (PS_latch),
                        .Z (Z),
                        .nPC (pc_1),//pc+1
                        .BrA (BrA),
                        .RAA (RAA),
                        .PC_out (npc_mux)
                       ); 
    //////////////////WriteBack///////////////////////
    wire[31:0] BusD;
    reg RW_EX_latch,NxorV_latch=0;
    reg [4:0]DA_EX_latch=0;
    reg [1:0]MD_EX_latch=0;
    reg [31:0]F_latch,Data_out_latch=0;
    WB wb1 (
            .RW (RW_EX_latch),
            .DA (DA_EX_latch),
            .MD (MD_EX_latch),
            .NxorV (NxorV_latch),
            .F (F_latch),
            .Data_out (Data_out_latch),
            .BusD (BusD)
            );
          
     RegFile rf1 ( .clk (clk),
                  .rst (rst),  
                   .RW (RW_EX_latch),//from DOF_EX
                   .AA (AA),//from DOF
                   .BA (BA),//from DOF
                   .DA (DA_EX_latch),//from EX_WB
                   .Writedata (BusD),//from WB
                   .A_data (A_data),//DOF
                   .B_data (B_data),//DOF
                   .C (C),
                   .V (V),
                   .N (N),
                   .Z (Z),
                   .FS (FS_latch)
                );

                
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            {pc_reg, pc_1_latch, pc_2_latch} <= {16'b0, 16'b0, 16'b0};
            ir_latch <= 32'b0;
            {RW_latch, DA_latch, MD_latch, BS_latch, PS_latch, MW_latch, FS_latch, SH_latch} <= {1'b0, 5'b0, 2'b0, 2'b0, 1'b0, 1'b0, 5'b0, 5'b0};
            {BusA_latch, BusB_latch} <= {32'b0, 32'b0};
            RW_EX_latch<=0;
            DA_EX_latch<=0;
            MD_EX_latch<=0;
            F_latch<=0;
            NxorV_latch<=0;
            Data_out_latch<=0;
            end
       
         else
            pc_reg<=npc_mux;  
            pc_1_latch<=pc_1;
            ir_latch<=ir;  
            pc_2_latch<=pc_2;         
            RW_latch<=RW;
            DA_latch<=DA;
            MD_latch<=MD;
            SH_latch<=SH;
            FS_latch<=FS;
            PS_latch<=PS;
            MW_latch<=MW;
            BS_latch<=BS;
            BusA_latch<=BusA;
            BusB_latch<=BusB;
            RW_EX_latch<=RW_EX;
            DA_EX_latch<=DA_EX;
            MD_EX_latch<=MD_EX;
            F_latch<=F;
            NxorV_latch<=NxorV;
            Data_out_latch<=Data_out;
            
    end        

endmodule
