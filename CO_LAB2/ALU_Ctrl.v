// 109550087
//Subject:     CO project 2 - ALU Controller
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
    
    if (ALUOp_i == 3'b000 && funct_i == 6'b100000) // add
        ALUCtrl_o <= 4'b0010;      
    else if (ALUOp_i == 3'b000 && funct_i == 6'b100010) // sub
        ALUCtrl_o <= 4'b0110;
    else if (ALUOp_i == 3'b000 && funct_i == 6'b100100) // and
        ALUCtrl_o <= 4'b0000;
    else if (ALUOp_i == 3'b000 && funct_i == 6'b100101) // or
        ALUCtrl_o <= 4'b0001;
    else if (ALUOp_i == 3'b000 && funct_i == 6'b101010) // slt
        ALUCtrl_o <= 4'b0111;
    else if (ALUOp_i == 3'b010) // slti
        ALUCtrl_o <= 4'b0101;
    else if (ALUOp_i == 3'b001) // addi
        ALUCtrl_o <= 4'b1000;
    else if (ALUOp_i == 3'b011) // beq
        ALUCtrl_o <= 4'b0110;
end
       
//Select exact operation

endmodule     





                    
                    