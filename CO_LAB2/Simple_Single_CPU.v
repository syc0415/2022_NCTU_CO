// 109550087
//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

`timescale 1ns/1ps
module Simple_Single_CPU(
        clk_i,
        rst_i
	);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] pc_o;
wire [32-1:0] instr;
wire [32-1:0] sum1;
wire [32-1:0] sum2;
wire [5-1:0] mux_write;
wire [32-1:0] alu_result;
wire [32-1:0] RS;
wire [32-1:0] RT;
wire [3-1:0] alu_op;
wire [4-1:0] alu_ctrl;
wire [32-1:0] sign_ext;
wire [32-1:0] mux_alu_src;
wire [32-1:0] shift_left;
wire [32-1:0] mux_pc_src;

wire reg_write;
wire alu_src;
wire reg_dst;
wire branch;
wire alu_zero;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	.rst_i (rst_i),     
	.pc_in_i(mux_pc_src) ,   
	.pc_out_o(pc_o) 
	);
	
Adder Adder1(
        .src1_i(32'd4),     
	.src2_i(pc_o),     
	.sum_o(sum1)    
	);
	
Instr_Memory IM(
        .pc_addr_i(pc_o),  
	.instr_o(instr)    
	);

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(reg_dst),
        .data_o(mux_write)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]) , 
        .RTaddr_i(instr[20:16]) , 
        .RDaddr_i(mux_write) ,  
        .RDdata_i(alu_result)  , 
        .RegWrite_i(reg_write),
        .RSdata_o(RS) ,  
        .RTdata_o(RT)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	.RegWrite_o(reg_write), 
	.ALU_op_o(alu_op),   
	.ALUSrc_o(alu_src),   
	.RegDst_o(reg_dst),   
	.Branch_o(branch)   
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
        .data0_i(RT),
        .data1_i(sign_ext),
        .select_i(alu_src),
        .data_o(mux_alu_src)
        );	
		
ALU ALU(
        .src1_i(RS),
	.src2_i(mux_alu_src),
	.ctrl_i(alu_ctrl),
	.result_o(alu_result),
	.zero_o(alu_zero)
	);
		
Adder Adder2(
        .src1_i(sum1),     
	.src2_i(shift_left),     
	.sum_o(sum2)      
	);
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_ext),
        .data_o(shift_left)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(sum1),
        .data1_i(sum2),
        .select_i(branch & alu_zero),
        .data_o(mux_pc_src)
        );	

endmodule
