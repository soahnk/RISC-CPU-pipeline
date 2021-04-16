`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 10:15:41 AM
// Design Name: 
// Module Name: InstructionDecoder
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


module InstructionDecoder(
    input	[31:0]	ir ,
    output	reg RW,PS,MW,MB,MA,CS,
    output	reg [4:0]	FS,
    output	reg [1:0]	MD,BS
    );
//    localparam nop = 7'b0000000;
//    localparam add = 7'b0000010;
//    localparam sub = 7'b0000101;
//    localparam slt = 7'b1100101;
//    localparam andl = 7'b0001000;
//    localparam orl = 7'b0001010;
//    localparam xorl = 7'b0001100;
//    localparam st = 7'b0000001;
//    localparam ld = 7'b0100001;
//    localparam adi = 7'b0100010;
//    localparam sbi = 7'b0100101;
//    localparam notl = 7'b0101110;
//    localparam ani = 7'b0101000;
//    localparam ori = 7'b0101010;
//    localparam xri = 7'b0101100;
//    localparam aiu = 7'b1100010;
//    localparam siu = 7'b1000101;
//    localparam mov = 7'b1000000;
//    localparam lsl = 7'b0110000;
//    localparam lsr = 7'b0110001;
//    localparam jmr = 7'b1100001;
//    localparam bz = 7'b0100000;
//    localparam bnz = 7'b1100000;
//    localparam jmp = 7'b1000100;
//    localparam jml = 7'b0000111;
    `include "opcodes.vh"    
    wire [6:0] opcode;
   
    assign opcode=ir[31:25];
   
    always @(*)
        case(opcode)
        NOP: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_0_00000_0_0_0;
            ADD: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_0_0_0;
            SUB: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_0_0_0;
            SLT: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_10_00_0_0_00101_0_0_0;
            AND: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_0_0_0;
            OR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_0_0_0;
            XOR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_0_0_0;
            ST: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_1_00000_0_0_0;
            LD: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_01_00_0_0_00000_0_0_0;
            ADI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_1;
            SBI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_1;
            NOT: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01110_0_0_0;
            ANI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_1_0_0;
            ORI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_1_0_0;
            XRI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_1_0_0;
            AIU: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_0;
            SIU: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_0;
            MOV: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00000_0_0_0;
            LSL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10000_0_0_0;
            LSR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10001_0_0_0;
            ASL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10010_0_0_0;
            ASR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10011_0_0_0;
            ROL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10100_0_0_0;
            ROR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10101_0_0_0;
            RLC: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10110_0_0_0;
            RRC: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10111_0_0_0;
            JMR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_10_0_0_00000_0_0_0;
            BZ: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_0_0_00000_1_0_1;
            BNZ: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_1_0_00000_1_0_1;
            JMP: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_11_0_0_00000_1_0_1;
            JML: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_11_0_0_00111_1_1_1;
            default: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'bX_XX_XX_X_X_XXXXX_X_X_X;
              
         endcase

endmodule
