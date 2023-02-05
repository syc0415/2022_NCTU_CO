`timescale 1ns/1ps


module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;
reg             cin_at_first_ALU_1bit;
reg             less_first;
reg             less;

wire     [32-1:0] temp_result;
wire     [32-1:0] c;


reg start_check;
initial begin
start_check=1'b0;
end

// src1, src2, less, A_invert, B_invert, cin, operation, result, cout
alu_top  	alu1_bit0(	src1[0],src2[0],less_first,ALU_control[3],ALU_control[2],cin_at_first_ALU_1bit,ALU_control[1:0],temp_result[0],c[0]);
alu_top  	alu1_bit1(	src1[1],src2[1],less,ALU_control[3],ALU_control[2],c[0],ALU_control[1:0],temp_result[1],c[1]);
alu_top  	alu1_bit2(	src1[2],src2[2],less,ALU_control[3],ALU_control[2],c[1],ALU_control[1:0],temp_result[2],c[2]);
alu_top  	alu1_bit3(	src1[3],src2[3],less,ALU_control[3],ALU_control[2],c[2],ALU_control[1:0],temp_result[3],c[3]);
alu_top  	alu1_bit4(	src1[4],src2[4],less,ALU_control[3],ALU_control[2],c[3],ALU_control[1:0],temp_result[4],c[4]);
alu_top  	alu1_bit5(	src1[5],src2[5],less,ALU_control[3],ALU_control[2],c[4],ALU_control[1:0],temp_result[5],c[5]);
alu_top  	alu1_bit6(	src1[6],src2[6],less,ALU_control[3],ALU_control[2],c[5],ALU_control[1:0],temp_result[6],c[6]);
alu_top  	alu1_bit7(	src1[7],src2[7],less,ALU_control[3],ALU_control[2],c[6],ALU_control[1:0],temp_result[7],c[7]);
alu_top  	alu1_bit8(	src1[8],src2[8],less,ALU_control[3],ALU_control[2],c[7],ALU_control[1:0],temp_result[8],c[8]);
alu_top  	alu1_bit9(	src1[9],src2[9],less,ALU_control[3],ALU_control[2],c[8],ALU_control[1:0],temp_result[9],c[9]);
alu_top  	alu1_bit10(	src1[10],src2[10],less,ALU_control[3],ALU_control[2],c[9],ALU_control[1:0],temp_result[10],c[10]);
alu_top  	alu1_bit11(	src1[11],src2[11],less,ALU_control[3],ALU_control[2],c[10],ALU_control[1:0],temp_result[11],c[11]);
alu_top  	alu1_bit12(	src1[12],src2[12],less,ALU_control[3],ALU_control[2],c[11],ALU_control[1:0],temp_result[12],c[12]);
alu_top  	alu1_bit13(	src1[13],src2[13],less,ALU_control[3],ALU_control[2],c[12],ALU_control[1:0],temp_result[13],c[13]);
alu_top  	alu1_bit14(	src1[14],src2[14],less,ALU_control[3],ALU_control[2],c[13],ALU_control[1:0],temp_result[14],c[14]);
alu_top  	alu1_bit15(	src1[15],src2[15],less,ALU_control[3],ALU_control[2],c[14],ALU_control[1:0],temp_result[15],c[15]);
alu_top  	alu1_bit16(	src1[16],src2[16],less,ALU_control[3],ALU_control[2],c[15],ALU_control[1:0],temp_result[16],c[16]);
alu_top  	alu1_bit17(	src1[17],src2[17],less,ALU_control[3],ALU_control[2],c[16],ALU_control[1:0],temp_result[17],c[17]);
alu_top  	alu1_bit18(	src1[18],src2[18],less,ALU_control[3],ALU_control[2],c[17],ALU_control[1:0],temp_result[18],c[18]);
alu_top  	alu1_bit19(	src1[19],src2[19],less,ALU_control[3],ALU_control[2],c[18],ALU_control[1:0],temp_result[19],c[19]);
alu_top  	alu1_bit20(	src1[20],src2[20],less,ALU_control[3],ALU_control[2],c[19],ALU_control[1:0],temp_result[20],c[20]);
alu_top  	alu1_bit21(	src1[21],src2[21],less,ALU_control[3],ALU_control[2],c[20],ALU_control[1:0],temp_result[21],c[21]);
alu_top  	alu1_bit22(	src1[22],src2[22],less,ALU_control[3],ALU_control[2],c[21],ALU_control[1:0],temp_result[22],c[22]);
alu_top  	alu1_bit23(	src1[23],src2[23],less,ALU_control[3],ALU_control[2],c[22],ALU_control[1:0],temp_result[23],c[23]);
alu_top  	alu1_bit24(	src1[24],src2[24],less,ALU_control[3],ALU_control[2],c[23],ALU_control[1:0],temp_result[24],c[24]);
alu_top  	alu1_bit25(	src1[25],src2[25],less,ALU_control[3],ALU_control[2],c[24],ALU_control[1:0],temp_result[25],c[25]);
alu_top  	alu1_bit26(	src1[26],src2[26],less,ALU_control[3],ALU_control[2],c[25],ALU_control[1:0],temp_result[26],c[26]);
alu_top  	alu1_bit27(	src1[27],src2[27],less,ALU_control[3],ALU_control[2],c[26],ALU_control[1:0],temp_result[27],c[27]);
alu_top  	alu1_bit28(	src1[28],src2[28],less,ALU_control[3],ALU_control[2],c[27],ALU_control[1:0],temp_result[28],c[28]);
alu_top  	alu1_bit29(	src1[29],src2[29],less,ALU_control[3],ALU_control[2],c[28],ALU_control[1:0],temp_result[29],c[29]);
alu_top  	alu1_bit30(	src1[30],src2[30],less,ALU_control[3],ALU_control[2],c[29],ALU_control[1:0],temp_result[30],c[30]);
alu_top  	alu1_bit31(	src1[31],src2[31],less,ALU_control[3],ALU_control[2],c[30],ALU_control[1:0],temp_result[31],c[31]);
     
always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n)begin
		result=0;
		zero=0;
		cout=0;
		overflow=0;
	end
	else begin
		// 0000 and
		// 0001 or
		// 0010 add
		// 0110 sub
		// 0111 slt
		case(ALU_control)
			4'b0000,4'b0001:begin
				cin_at_first_ALU_1bit = 0;
				cout = 0;
				result = temp_result;
				overflow = 0;
				less_first = 1'b0;
				less = 1'b0;
			end
			4'b0010:begin
				cin_at_first_ALU_1bit=0;
				cout = c[31];
				result = temp_result;
				overflow = c[30] ^ c[31];
				less_first = 1'b0;
				less = 1'b0;
			end
			4'b0110:begin
				cin_at_first_ALU_1bit = 1;
				cout = c[31];
				result = temp_result;
				overflow = c[30] ^ c[31];
				less_first = 1'b0;
				less = 1'b0;
			end
			4'b0111:begin
				cin_at_first_ALU_1bit = 1;
				cout = 0;
				less_first = temp_result[31];
				result = temp_result;
				overflow = 0;
			end
		endcase
		zero = |result;
		zero = ~zero;
	end
end

endmodule
