`timescale 1ns / 1ps

module Full_Subtractor(
    In_A, In_B, Borrow_in, Difference, Borrow_out
    );
    input In_A, In_B, Borrow_in;
    output Difference, Borrow_out;
    
    // implement full subtractor circuit, your code starts from here.
    // use half subtractor in this module, fulfill I/O ports connection.
    wire a, bo1, bo2;
    Half_Subtractor HSUB (
        .In_A(In_A), 
        .In_B(In_B), 
        .Difference(a), 
        .Borrow_out(bo1)
    );
    Half_Subtractor HSUB2 (
        .In_A(a), 
        .In_B(Borrow_in), 
        .Difference(Difference), 
        .Borrow_out(bo2)
    );
    or (Borrow_out, bo1, bo2);

endmodule
