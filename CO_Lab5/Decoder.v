// 109550087
module Decoder( 
	instr_op_i, 
	ALUOp_o, 
	ALUSrc_o,
	RegWrite_o,	
	RegDst_o,
	Branch_o,
	MemRead_o, 
	MemWrite_o, 
	MemtoReg_o,
	BranchType_o // lab5
);
     
//I/O ports
input	[6-1:0] instr_op_i;

output	[3-1:0] ALUOp_o;
output		    RegDst_o, MemtoReg_o;
output		    ALUSrc_o, RegWrite_o, Branch_o, MemRead_o, MemWrite_o;
output	[2-1:0] BranchType_o;

//Internal Signals
reg	[3-1:0] ALUOp_o;
reg		    RegDst_o, MemtoReg_o;
reg		    ALUSrc_o, RegWrite_o, Branch_o, MemRead_o, MemWrite_o;
reg [2-1:0] BranchType_o;

//Main function
always@(*) begin
	case(instr_op_i)
		// R-type
		6'b000000: begin // add sub and or slt mult
			ALUOp_o <= 3'b010;
			ALUSrc_o <= 0;
			RegDst_o <= 1;
			RegWrite_o <= 1;
			Branch_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 0;
			BranchType_o <= 2'b00;
		end
		6'b001000: begin // addi
			ALUOp_o <= 3'b110;
			ALUSrc_o <= 1;
			RegDst_o <= 0;
			RegWrite_o <= 1;
			Branch_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 0;
			BranchType_o <= 2'b00;
		end
		6'b001010: begin // slti
			ALUOp_o <= 3'b011;
			ALUSrc_o <= 1;
			RegDst_o <= 0;
			RegWrite_o <= 1;
			Branch_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 0;
			BranchType_o <= 2'b00;
		end
		6'b000100: begin // beq
			ALUOp_o <= 3'b001;
			ALUSrc_o <= 0;
			// RegDst_o <= 0;	   
			RegWrite_o <= 0;	   
			Branch_o <= 1;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			// MemtoReg_o <= 0;
			BranchType_o <= 2'b00;
		end

		// lab3
		6'b100011: begin // lw
			ALUOp_o <= 3'b000;
			ALUSrc_o <= 1;
			RegDst_o <= 0;
			RegWrite_o <= 1;
			Branch_o <= 0;
			MemRead_o <= 1;
			MemWrite_o <= 0;
			MemtoReg_o <= 1;
			// BranchType_o <= 2'b00;
		end
		6'b101011: begin // sw
			ALUOp_o <= 3'b000;
			ALUSrc_o <= 1;
			// RegDst_o <= 0;	
			RegWrite_o <= 0;
			Branch_o <= 0;			
			MemRead_o <= 0;
			MemWrite_o <= 1;
			// MemtoReg_o <= 0;\
			BranchType_o <= 2'b00;
		end
		
		// lab5
		6'b000101: begin // bne
		   ALUOp_o <= 3'b001;
		   ALUSrc_o <= 1'b0;
		   RegDst_o <= 1'b0;
		   RegWrite_o <= 1'b0;
		   Branch_o <= 1'b1;
		   MemRead_o <= 1'b0;
		   MemWrite_o <= 1'b0;
		   MemtoReg_o <= 1'b0;
		   BranchType_o <= 2'b01;
		end
		6'b000001: begin // bge
		   ALUOp_o <= 3'b001;
		   ALUSrc_o <= 1'b0;
		   RegDst_o <= 1'b0;
		   RegWrite_o <= 1'b0;
		   Branch_o <= 1'b1;
		   MemRead_o <= 1'b0;
		   MemWrite_o <= 1'b0;
		   MemtoReg_o <= 1'b0;
		   BranchType_o <= 2'b10;
		end
		
		6'b000111: begin // bgt
		   ALUOp_o <= 3'b001;
		   ALUSrc_o <= 1'b0;
		   RegDst_o <= 1'b0;
		   RegWrite_o <= 1'b0;
		   Branch_o <= 1'b1;
		   MemRead_o <= 1'b0;
		   MemWrite_o <= 1'b0;
		   MemtoReg_o <= 1'b0;
		   BranchType_o <= 2'b11;
		end
		// default: begin
		// 	ALUOp_o <= 3'bxxx;
		// 	ALUSrc_o <= 1'bx;
		// 	RegDst_o <= 1'bx;
		// 	RegWrite_o <= 1'bx;	
		// 	Branch_o <= 1'bx;
		// 	MemRead_o <= 1'bx;
		// 	MemWrite_o <= 1'bx;
		// 	MemtoReg_o <= 1'bx;
		// end
	endcase
end

endmodule