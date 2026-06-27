module Writeback_Cycle(
    input clk, rst, ResultSrcW,
    input [31:0] PCPlus4W, ReadDataW, ALUResultW,
    output [31:0] ResultW);
    
    Mux result_mux(.a(ALUResultW), 
                   .b(ReadDataW), 
                   .s(ResultSrcW), 
                   .c(ResultW));
endmodule