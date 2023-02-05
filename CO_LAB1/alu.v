`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// 109550087
//////////////////////////////////////////////////////////////////////////////////

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

reg cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8;
reg cout9, cout10, cout11, cout12, cout13, cout14, cout15, cout16;
reg cout17, cout18, cout19, cout20, cout21, cout22, cout23, cout24;
reg cout25, cout26, cout27, cout28, cout29, cout30, cout31;
reg [32:0] tmp;

always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n)
	begin
		result = 0;
		zero = 0;
		cout = 0;
		overflow = 0;
	end
	else begin
        case(ALU_control)
            4'b0000: // and
            begin
                result = src1 & src2;
                cout = 0;
                overflow = 0;
            end
            4'b0001: // or
            begin
                result = src1 | src2;
                cout = 0;
                overflow = 0;
            end
            4'b0010: // add
            begin
		        result = src1 + src2;
			    cout0 = src1[0] & src2[0];
			    cout1 = src1[1] + src2[1] + cout0;
			    cout2 = src1[2] + src2[2] + cout1;
			    cout3 = src1[3] + src2[3] + cout2;
			    cout4 = src1[4] + src2[4] + cout3;
			    cout5 = src1[5] + src2[5] + cout4;
			    cout6 = src1[6] + src2[6] + cout5;
			    cout7 = src1[7] + src2[7] + cout6;
			    cout8 = src1[8] + src2[8] + cout7;
			    cout9 = src1[9] + src2[9] + cout8;
			    cout10 = src1[10] + src2[10] + cout9;
			    cout11 = src1[11] + src2[11] + cout10;
			    cout12 = src1[12] + src2[12] + cout11;
			    cout13 = src1[13] + src2[13] + cout12;
			    cout14 = src1[14] + src2[14] + cout13;
			    cout15 = src1[15] + src2[15] + cout14;
			    cout16 = src1[16] + src2[16] + cout15;
			    cout17 = src1[17] + src2[17] + cout16;
			    cout18 = src1[18] + src2[18] + cout17;
			    cout19 = src1[19] + src2[19] + cout18;
			    cout20 = src1[20] + src2[20] + cout19;
			    cout21 = src1[21] + src2[21] + cout20;
			    cout22 = src1[22] + src2[22] + cout21;
			    cout23 = src1[23] + src2[23] + cout22;
			    cout24 = src1[24] + src2[24] + cout23;
			    cout25 = src1[25] + src2[25] + cout24;
			    cout26 = src1[26] + src2[26] + cout25;
			    cout27 = src1[27] + src2[27] + cout26;
			    cout28 = src1[28] + src2[28] + cout27;
			    cout29 = src1[29] + src2[29] + cout28;
			    cout30 = src1[30] + src2[30] + cout29;
			    cout31 = src1[31] + src2[31] + cout30;
			    tmp = src1 + src2;
			    cout = tmp[32];
			    if (src1[31] == src2[31])
			    begin
			        if (src1[31] == 0)
			            if (result[31] == 1) overflow = 1;
			        else if (src1[31] == 1)
				        if (result[31] == 0) overflow = 1;
			    end
			    // overflow = cout30 ^ cout31;
            end
		    4'b0110: // sub
		    begin
                result = src1 - src2;
            	cout0 = (~src1[0]) & src2[0];
			    cout1 = src1[1] - src2[1] - cout0;
			    cout2 = src1[2] - src2[2] - cout1;
			    cout3 = src1[3] - src2[3] - cout2;
			    cout4 = src1[4] - src2[4] - cout3;
			    cout5 = src1[5] - src2[5] - cout4;
			    cout6 = src1[6] - src2[6] - cout5;
			    cout7 = src1[7] - src2[7] - cout6;
			    cout8 = src1[8] - src2[8] - cout7;
			    cout9 = src1[9] - src2[9] - cout8;
			    cout10 = src1[10] - src2[10] - cout9;
			    cout11 = src1[11] - src2[11] - cout10;
			    cout12 = src1[12] - src2[12] - cout11;
			    cout13 = src1[13] - src2[13] - cout12;
			    cout14 = src1[14] - src2[14] - cout13;
			    cout15 = src1[15] - src2[15] - cout14;
			    cout16 = src1[16] - src2[16] - cout15;
			    cout17 = src1[17] - src2[17] - cout16;
			    cout18 = src1[18] - src2[18] - cout17;
			    cout19 = src1[19] - src2[19] - cout18;
			    cout20 = src1[20] - src2[20] - cout19;
			    cout21 = src1[21] - src2[21] - cout20;
			    cout22 = src1[22] - src2[22] - cout21;
			    cout23 = src1[23] - src2[23] - cout22;
			    cout24 = src1[24] - src2[24] - cout23;
			    cout25 = src1[25] - src2[25] - cout24;
			    cout26 = src1[26] - src2[26] - cout25;
			    cout27 = src1[27] - src2[27] - cout26;
			    cout28 = src1[28] - src2[28] - cout27;
			    cout29 = src1[29] - src2[29] - cout28;
			    cout30 = src1[30] - src2[30] - cout29;
			    cout31 = src1[31] - src2[31] - cout30;
			    cout = cout31;
			    tmp = src2 - src1;
			    cout = tmp[32];
			    if (src1[31] != src2[31])
				begin
					if (src1[31] == 1 & src2[31] == 0)
						if (result[31] == 0) overflow = 1;
					else if (src1[31] == 0 & src2[31] == 1)
						if (result[31] == 1) overflow = 1;
            	end
			    // overflow = cout30 ^ cout31;
            end		    
            4'b1100: // nor
            begin
                result = ~(src1 | src2);
                cout = 0;
                overflow = 0;
            end
            4'b0111: // slt
            begin
			    if (src1[31] != src2[31])
			 	   if (src1[31] > src2[31]) result = 1;
			 	   else result = 0;
			    else
			 	   if (src1 < src2) result = 1;
			 	   else result = 0;
			    cout = 0;
			    overflow = 0;
		    end
         endcase
         if (result == 0)
            zero = 1;
         else
            zero = 0;
	end
end

endmodule
