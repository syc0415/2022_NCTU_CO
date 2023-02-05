// 109550087
`timescale 1ns / 1ps
//Subject:     CO project 5 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [32-1:0] pc, pc_out, pc_add4, instr;
wire [32-1:0] pc_add4_ID, instr_ID;

/**** ID stage ****/
wire [32-1:0] ReadData1, ReadData2, signed_addr;
wire [3-1:0] ALUOp;
wire ALUSrc, RegWrite, RegDst, Branch, MemRead, MemWrite, MemtoReg;
wire [32-1:0] signed_addr;
wire pcwrite, ifid_flush, ifid_write, idex_flush, exmem_flush;
wire [2-1:0] BranchType;
//control signal
wire [32-1:0] pc_add4_EX, ReadData1_EX, ReadData2_EX, signed_addr_EX;
wire [26-1:0] instr_EX;
wire [3-1:0] ALUOp_EX;
wire ALUSrc_EX, RegWrite_EX, RegDst_EX, Branch_EX, MemRead_EX, MemWrite_EX, MemtoReg_EX;
wire [2-1:0] BranchType_EX;

/**** EX stage ****/
wire [32-1:0] addr_shifted, ALU_src, ALU_result, pc_branch;
wire [4-1:0] ALUCtrl;
wire ALU_zero;
wire [5-1:0] write_Reg_addr;
wire [1:0] forwardA, forwardB;
wire [32-1:0] forwardA_data, forwardB_data;
//control signal
wire [32-1:0] ALU_result_MEM, pc_branch_MEM, ReadData2_mem;
wire ALU_zero_MEM;
wire [5-1:0] write_Reg_addr_MEM;
wire RegWrite_MEM, Branch_MEM, MemRead_MEM, MemWrite_MEM, MemtoReg_MEM;
wire [2-1:0] BranchType_MEM;

/**** MEM stage ****/
wire [32-1:0] MemRead_data;
wire BranchType_result;
//control signal
wire [32-1:0] MemRead_data_WB, ALU_result_WB;
wire [5-1:0] write_Reg_addr_WB;
wire RegWrite_WB, MemtoReg_WB;

/**** WB stage ****/
wire [32-1:0] writeData;
//control signal


/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0(
    .data0_i(pc_add4),
    .data1_i(pc_branch_MEM),
    .select_i(Branch_MEM & BranchType_result),
    .data_o(pc)
);

ProgramCounter PC(
	.clk_i(clk_i),      
	.rst_i(rst_i),   
	.pc_write(pcwrite),  
	.pc_in_i(pc),   
	.pc_out_o(pc_out)
);

Instruction_Memory IM(
	.addr_i(pc_out),  
	.instr_o(instr)
);
			
Adder Add_pc(
	.src1_i(pc_out),     
	.src2_i(32'd4),
	.sum_o(pc_add4)
);
		
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
	.clk_i(clk_i),
    .rst_i(rst_i),
	.flush(ifid_flush),
    .write(ifid_write),
    .data_i({pc_add4, instr}),
    .data_o({pc_add4_ID, instr_ID})
);


//Instantiate the components in ID stage
Hazard_Detection HD(
        .memread(MemRead_EX),
        .instr_i(instr_ID[31:16]),
        .idex_regt(instr_EX[20:16]),
        .branch(Branch_MEM & BranchType_result),
        .pcwrite(pcwrite),
        .ifid_write(ifid_write),
        .ifid_flush(ifid_flush),
        .idex_flush(idex_flush),
        .exmem_flush(exmem_flush)
);

Reg_File RF(
	.clk_i(clk_i),      
	.rst_i(rst_i) ,     
    .RSaddr_i(instr_ID[25:21]),  
    .RTaddr_i(instr_ID[20:16]),  
    .RDaddr_i(write_Reg_addr_WB),  
    .RDdata_i(writeData), 
    .RegWrite_i(RegWrite_WB),
    .RSdata_o(ReadData1),  
    .RTdata_o(ReadData2)
);

Decoder Control(
	.instr_op_i(instr_ID[31:26]), 
	.ALUOp_o(ALUOp),   
	.ALUSrc_o(ALUSrc),
    .RegWrite_o(RegWrite),   
	.RegDst_o(RegDst),
	.Branch_o(Branch),
	.MemRead_o(MemRead), 
	.MemWrite_o(MemWrite), 
	.MemtoReg_o(MemtoReg),
    .BranchType_o(BranchType)
);

Sign_Extend SE(
	.data_i(instr_ID[15:0]),
    .data_o(signed_addr)
);	

Pipe_Reg #(.size(166)) ID_EX(
	.clk_i(clk_i),
    .rst_i(rst_i),
	.flush(idex_flush),
    .write(1'b1),
    .data_i({pc_add4_ID, instr_ID[25:0], ReadData1, ReadData2, ALUOp, ALUSrc,
            RegWrite, RegDst, Branch, MemRead, MemWrite, MemtoReg, signed_addr, BranchType}),
    .data_o({pc_add4_EX, instr_EX, ReadData1_EX, ReadData2_EX, ALUOp_EX, ALUSrc_EX,
            RegWrite_EX, RegDst_EX, Branch_EX, MemRead_EX, MemWrite_EX, MemtoReg_EX, signed_addr_EX, BranchType_EX})
);


//Instantiate the components in EX stage
Shift_Left_Two_32 Shift2(
	.data_i(signed_addr_EX),
    .data_o(addr_shifted)
);

MUX_3to1 #(.size(32)) Mux_ForwardA(
    .data0_i(ReadData1_EX),
    .data1_i(ALU_result_MEM),
    .data2_i(writeData),
    .select_i(forwardA),
    .data_o(forwardA_data)
);

ALU ALU(
	.src1_i(forwardA_data),
	.src2_i(ALU_src),
	.ctrl_i(ALUCtrl),
	.result_o(ALU_result),
	.zero_o(ALU_zero)
);
		
ALU_Ctrl ALU_Control(
	.funct_i(instr_EX[5:0]),   
    .ALUOp_i(ALUOp_EX),   
    .ALUCtrl_o(ALUCtrl)
);

MUX_2to1 #(.size(32)) Mux1(
	.data0_i(forwardB_data),
    .data1_i(signed_addr_EX),
    .select_i(ALUSrc_EX),
    .data_o(ALU_src)
);
		
MUX_2to1 #(.size(5)) Mux2(
	.data0_i(instr_EX[20:16]),
    .data1_i(instr_EX[15:11]),
    .select_i(RegDst_EX),
    .data_o(write_Reg_addr)
);

Adder Add_pc_branch(
	.src1_i(pc_add4_EX),     
	.src2_i(addr_shifted),
	.sum_o(pc_branch)    
);

MUX_3to1 #(.size(32)) Mux_ForwardB(
    .data0_i(ReadData2_EX),
    .data1_i(ALU_result_MEM),
    .data2_i(writeData),
    .select_i(forwardB),
    .data_o(forwardB_data)
);

Forwarding_Unit FU(
    .regwrite_mem(RegWrite_MEM),
    .regwrite_wb(RegWrite_WB),
    .idex_regs(instr_EX[25:21]),
    .idex_regt(instr_EX[20:16]),
    .exmem_regd(write_Reg_addr_MEM),
    .memwb_regd(write_Reg_addr_WB),
    .forwarda(forwardA),
    .forwardb(forwardB)
);

Pipe_Reg #(.size(109)) EX_MEM(
	.clk_i(clk_i),
    .rst_i(rst_i),
	.flush(exmem_flush),
    .write(1'b1),
    .data_i({ALU_result, pc_branch, forwardB_data, ALU_zero, write_Reg_addr,  
		    RegWrite_EX, Branch_EX, MemRead_EX, MemWrite_EX, MemtoReg_EX, BranchType_EX}),
    .data_o({ALU_result_MEM, pc_branch_MEM, ReadData2_mem, ALU_zero_MEM, write_Reg_addr_MEM,  
		    RegWrite_MEM, Branch_MEM, MemRead_MEM, MemWrite_MEM, MemtoReg_MEM, BranchType_MEM})
);


//Instantiate the components in MEM stage
Data_Memory DM(
	.clk_i(clk_i), 
	.addr_i(ALU_result_MEM), 
	.data_i(ReadData2_mem), 
	.MemRead_i(MemRead_MEM), 
	.MemWrite_i(MemWrite_MEM), 
	.data_o(MemRead_data)
);

MUX_4to1 #(.size(1)) BranchTypes(
    .data0_i(ALU_zero_MEM),
    .data1_i(~ALU_zero_MEM),
    .data2_i(~ALU_result_MEM[31]),
    .data3_i(~(ALU_zero_MEM | ALU_result_MEM[31])),
    .select_i(BranchType_MEM),
    .data_o(BranchType_result)
);

Pipe_Reg #(.size(71)) MEM_WB(
	.clk_i(clk_i),
    .rst_i(rst_i),
	.flush(1'b0),
    .write(1'b1),
	.data_i({MemRead_data, ALU_result_MEM, write_Reg_addr_MEM, MemtoReg_MEM, RegWrite_MEM}),
    .data_o({MemRead_data_WB, ALU_result_WB, write_Reg_addr_WB, MemtoReg_WB, RegWrite_WB})
);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
	.data0_i(ALU_result_WB),
    .data1_i(MemRead_data_WB),
    .select_i(MemtoReg_WB),
    .data_o(writeData)
);

/****************************************
signal assignment
****************************************/

endmodule
