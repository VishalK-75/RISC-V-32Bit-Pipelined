module Control_Unit_Top(funct3,funct7,ALUControl,Op,RegWrite,Branch,MemWrite,ImmSrc,ALUSrc,ResultSrc);
    input [6:0] Op,funct7;
    input [2:0] funct3;
    output RegWrite, MemWrite, ALUSrc, ResultSrc, Branch;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;
    
    wire [1:0] ALUOp;  
    
    main_decoder main_decoder(
               .Op(Op),
               .RegWrite(RegWrite),
               .MemWrite(MemWrite),
               .ImmSrc(ImmSrc),
               .ALUSrc(ALUSrc),
               .ALUOp(ALUOp),
               .ResultSrc(ResultSrc),
               .Branch(Branch));
     alu_decoder alu_decoder(
               .op(Op),
               .funct3(funct3),
               .funct7(funct7),
               .ALUOp(ALUOp),
               .ALUControl(ALUControl));
endmodule
