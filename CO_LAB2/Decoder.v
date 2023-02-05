// 109550087
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter
always @(*) begin
	RegWrite_o = (instr_op_i != 6'b000100)? 1'b1:1'b0;
	RegDst_o = (instr_op_i == 6'b000000)? 1'b1:1'b0;
	Branch_o = (instr_op_i == 6'b000100)? 1'b1:1'b0;
	ALUSrc_o = (instr_op_i == 6'b001000 || instr_op_i == 6'b001010)? 1'b1:1'b0; 
	
	case (instr_op_i)
		6'b000000: // add sub and or slt
			ALU_op_o = 3'b000;
		6'b001000: // addi
			ALU_op_o = 3'b001;
		6'b001010: // slti 
			ALU_op_o = 3'b010;
		6'b000100: // beq
			ALU_op_o = 3'b011;
		default:
			ALU_op_o = 3'bxxx;
	endcase
	/*
	if (instr_op_i == 6'b000000)
		ALU_op_o = 3'b010;
	else if (instr_op_i == 6'b001000)
		ALU_op_o = 3'b100;
	else if (instr_op_i == 6'b001010)
		ALU_op_o = 3'b111;
	else if (instr_op_i == 6'b000100)
		ALU_op_o = 3'b011;
	*/
end


//Main function

endmodule           