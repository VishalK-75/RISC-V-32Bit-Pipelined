module Fetch_Cycle(
    input clk, rst, PCSrcE, StallF, StallD,
    input [31:0] PCTargetE,
    output [31:0] InstrD, PCPlus4D, PCD);
    
    wire [31:0] PC_F, PCF, PCPlus4F, InstrF;
    
    reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;

    Mux PC_Mux(.a(PCPlus4F), 
               .b(PCTargetE), 
               .s(PCSrcE), 
               .c(PC_F));   
    
    reg [31:0] PC_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst)       PC_reg <= 32'h00000000;
        else if (!StallF) PC_reg <= PC_F;
    end
    assign PCF = PC_reg;

    Instr_memory Instr_mem(.rst(rst), .A(PCF), .RD(InstrF));
    PC_Adder PC_Add(.a(PCF), .b(32'd4), .c(PCPlus4F));  
      
    always @(posedge clk) begin
        if (rst) begin
            InstrF_reg   <= 32'h00000000;
            PCF_reg      <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end  
        else if (!StallD) begin
            InstrF_reg   <= InstrF;
            PCF_reg      <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end        
       
    assign InstrD = (rst) ? 32'h00000000 : InstrF_reg;
    assign PCD = (rst) ? 32'h00000000 : PCF_reg;
    assign PCPlus4D = (rst) ? 32'h00000000 : PCPlus4F_reg;
endmodule