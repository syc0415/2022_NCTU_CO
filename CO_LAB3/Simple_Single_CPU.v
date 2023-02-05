// 109550087

module Simple_Single_CPU(
        clk_i,
	rst_i
);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] pc_i, pc_o, pc_add4, pc_addSA;
wire [32-1:0] instr;

wire [1:0] reg_dst;
wire [5-1:0] mux_write_reg;
wire reg_write, jump_reg;
wire [32-1:0] ReadData1, ReadData2;

wire [2:0] alu_op;
wire alu_src, branch, jump, mem_read, mem_write;
wire [1:0] mem_to_reg;
wire [3:0] alu_ctrl;

wire [32-1:0] sign_ext, shift_addr;

wire [32-1:0] mux_alu_src, mux_branch, mux_jump;

wire [32-1:0] alu_result;
wire   alu_zero;

wire [32-1:0] data_mem, write_data;
wire [32-1:0] jump_addr;

assign jump_reg = (instr[31:26] == 6'b000000 && instr[5:0] == 6'b001000)? 1:0;
assign jump_addr = {pc_add4[31:28], instr[25:0], 2'b00};
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
        .rst_i(rst_i),     
        .pc_in_i(pc_i),   
        .pc_out_o(pc_o) 
);

Adder Adder_PC_Add4(
        .src1_i(pc_o),     
        .src2_i(32'd4),
        .sum_o(pc_add4)    
);

Instr_Memory IM(
        .pc_addr_i(pc_o),  
        .instr_o(instr)    
);

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .data2_i(5'b11111),
        .select_i(reg_dst),
        .data_o(mux_write_reg)
);

Reg_File Registers(
        .clk_i(clk_i),      
        .rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(mux_write_reg),  
        .RDdata_i(write_data), 
        .RegWrite_i(reg_write & (~jump_reg)),
        .RSdata_o(ReadData1),  
        .RTdata_o(ReadData2) 
);
	
Decoder Decoder(
        .instr_op_i(instr[31:26]),  
        .ALU_op_o(alu_op),   
        .ALUSrc_o(alu_src),
        .RegWrite_o(reg_write),   
        .RegDst_o(reg_dst),
        .Branch_o(branch),
        .Jump_o(jump), 
        .MemRead_o(mem_read), 
        .MemWrite_o(mem_write), 
        .MemtoReg_o(mem_to_reg)
);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(alu_op),   
        .ALUCtrl_o(alu_ctrl)
);
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(sign_ext)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(ReadData2),
        .data1_i(sign_ext),
        .select_i(alu_src),
        .data_o(mux_alu_src)
);
		
ALU ALU(
	.src1_i(ReadData1),
	.src2_i(mux_alu_src),
	.ctrl_i(alu_ctrl),
	.result_o(alu_result),
	.zero_o(alu_zero)
);

Data_Memory Data_Memory(
	.clk_i(clk_i), 
	.addr_i(alu_result), 
	.data_i(ReadData2), 
	.MemRead_i(mem_read), 
	.MemWrite_i(mem_write), 
	.data_o(data_mem)
);	

Adder Adder_PC_AddSA(
        .src1_i(pc_add4),     
	.src2_i(shift_addr),
	.sum_o(pc_addSA)    
);

Shift_Left_Two_32 Shift_address(
    	.data_i(sign_ext),
    	.data_o(shift_addr)
);

MUX_2to1 #(.size(32)) Mux_Branch(
        .data0_i(pc_add4),
        .data1_i(pc_addSA),
        .select_i(branch & alu_zero),
        .data_o(mux_branch)
);

MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(mux_branch),
        .data1_i(jump_addr),
        .select_i(jump),
        .data_o(mux_jump)
);	

MUX_2to1 #(.size(32)) Mux_JumpReg(
        .data0_i(mux_jump),
        .data1_i(ReadData1),
        .select_i(jump_reg),
        .data_o(pc_i)
);			

MUX_3to1 #(.size(32)) Mux_MemtoReg(
        .data0_i(alu_result),
        .data1_i(data_mem),
	.data2_i(pc_add4),
        .select_i(mem_to_reg),
        .data_o(write_data)
);
endmodule
