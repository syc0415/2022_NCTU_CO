// 109550087

module Decoder( 
	instr_op_i, 
	ALU_op_o, 
	ALUSrc_o,
	RegWrite_o,	
	RegDst_o,
	Branch_o,
	// lab 3 
	Jump_o, 
	MemRead_o, 
	MemWrite_o, 
	MemtoReg_o
);
     
//I/O ports
input	[6-1:0] instr_op_i;

output	[3-1:0] ALU_op_o;
output	[2-1:0] RegDst_o, MemtoReg_o;
output		ALUSrc_o, RegWrite_o, Branch_o, Jump_o, MemRead_o, MemWrite_o;

//Internal Signals
reg	[3-1:0] ALU_op_o;
reg	[2-1:0] RegDst_o, MemtoReg_o;
reg		ALUSrc_o, RegWrite_o, Branch_o, Jump_o, MemRead_o, MemWrite_o;

//Main function
always@(*)begin
	case(instr_op_i)
		// R-type
		6'b000000: begin // add sub and or slt jr
			ALU_op_o <= 3'b010;
			ALUSrc_o <= 0;
			RegDst_o <= 2'b01;
			RegWrite_o <= 1;
			Branch_o <= 0;
			Jump_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b00;
		end
		6'b001000: begin // addi
			ALU_op_o <= 3'b110;
			ALUSrc_o <= 1;
			RegDst_o <= 2'b00;
			RegWrite_o <= 1;
			Branch_o <= 0;
			Jump_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b00;
		end
		6'b001010: begin // slti
			ALU_op_o <= 3'b011;
			ALUSrc_o <= 1;
			RegDst_o <= 2'b00;
			RegWrite_o <= 1;
			Branch_o <= 0;
			Jump_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b00;
		end
		6'b000100: begin // beq
			ALU_op_o <= 3'b001;
			ALUSrc_o <= 0;
			// RegDst_o <= 2'b00;	   
			RegWrite_o <= 0;	   
			Branch_o <= 1;
			Jump_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			// MemtoReg_o <= 2'bxx;
		end

		// lab3
		6'b100011: begin // lw
			ALU_op_o <= 3'b000;
			ALUSrc_o <= 1;
			RegDst_o <= 2'b00;
			RegWrite_o <= 1;
			Branch_o <= 0;
			Jump_o <= 0;
			MemRead_o <= 1;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b01;
		end
		6'b101011: begin // sw
			ALU_op_o <= 3'b000;
			ALUSrc_o <= 1;
			// RegDst_o <= 2'bxx;	
			RegWrite_o <= 0;
			Branch_o <= 0;
			Jump_o <= 0;
			MemRead_o <= 0;
			MemWrite_o <= 1;
			// MemtoReg_o <= 2'bxx;
		end
		6'b000010: begin // jump
			// ALU_op_o <= 3'bxxx;
			ALUSrc_o <= 0;
			RegDst_o <= 2'b00;
			RegWrite_o <= 0;
			Branch_o <= 0;
			Jump_o <= 1;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b00;
		end
		6'b000011: begin // jal
			// ALU_op_o <= 3'bxxx;
			ALUSrc_o <= 0;
			RegDst_o <= 2'b10;
			RegWrite_o <= 1;	
			Branch_o <= 0;
			Jump_o <= 1;
			MemRead_o <= 0;
			MemWrite_o <= 0;
			MemtoReg_o <= 2'b10;
		end
		default:
			ALU_op_o <= 3'bxxx;
			ALUSrc_o <= 1'bx;
			RegDst_o <= 2'bxx;
			RegWrite_o <= 1'bx;	
			Branch_o <= 1'bx;
			Jump_o <= 1'bx;
			MemRead_o <= 1'bx;
			MemWrite_o <= 1'bx;
			MemtoReg_o <= 2'bxx;
	endcase
end

endmodule
                

