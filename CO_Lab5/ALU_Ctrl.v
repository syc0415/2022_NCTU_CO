// 109550087
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
always @(*) begin
    if (ALUOp_i == 3'b010) begin
        case (funct_i)
            6'b100000: ALUCtrl_o = 4'b0010; // add
            6'b100010: ALUCtrl_o = 4'b0110; // sub
            6'b100100: ALUCtrl_o = 4'b0000; // and
            6'b100101: ALUCtrl_o = 4'b0001; // or
            6'b101010: ALUCtrl_o = 4'b0111; // slt
            6'b011000: ALUCtrl_o = 4'b0011; // mult
            default: ALUCtrl_o = 4'bxxxx;
        endcase
    end
    else if (ALUOp_i == 3'b110) // addi
        ALUCtrl_o <= 4'b1000;
    else if (ALUOp_i == 3'b011) // slti
        ALUCtrl_o <= 4'b0101;
    else if (ALUOp_i == 3'b001) // beq
        ALUCtrl_o <= 4'b0110;
    // lab 3
    else if (ALUOp_i == 3'b000) // lw sw
        ALUCtrl_o <= 4'b1000;
    else
        ALUCtrl_o <= 4'b1000;
end
       
//Select exact operation

endmodule