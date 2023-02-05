// 109550087
module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
assign zero_o = (result_o == 0);

//Main function
always @(*) begin
	// add, addi, sub, and, or, slt, slti, beq
	case(ctrl_i)	
		0: result_o <= src1_i & src2_i; // and
		1: result_o <= src1_i | src2_i; // or
		2: result_o <= src1_i + src2_i; // add lw sw
	    // 4: result_o <= (src1_i == src2_i)? 1'b1:1'b0; // beq
		5: result_o <= (src1_i < src2_i)? 1'b1:1'b0; // slti		
		6: result_o <= src1_i - src2_i; // sub
		7: result_o <= (src1_i < src2_i)? 1'b1:1'b0; // slt
		8: result_o <= src1_i + src2_i; // addi
		12: result_o <= ~(src1_i | src2_i); // nor
		default: result_o <= 0;		
	endcase
end

endmodule





                    
                    