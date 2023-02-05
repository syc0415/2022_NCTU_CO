`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// 109550087
//////////////////////////////////////////////////////////////////////////////////

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;
reg           cout;

// 0000 and
// 0001 or
// 0010 add
// 0110 sub
// 0111 slt
always@(*)
begin
    case({A_invert, B_invert, operation})
    4'b0000:
    begin
        result = src1 & src2;
        cout = 1'b0;
     end
     4'b0001:
     begin
        result = src1 | src2;
        cout = 1'b0;
     end
     4'b0010:
     begin
        {cout, result} = src1 + src2 + cin;
     end
     4'b0110:
     begin
        cout = (src1 & ~src2) | (src1 & cin) | (~src2 & cin);
		result = src1 ^ ~src2 ^ cin;
     end
     4'b0111:
     begin
        cout = (src1 & ~src2) | (src1 & cin) | (~src2 & cin);
		result = src1 ^ ~src2 ^ cin;
     end
     endcase
end

endmodule
