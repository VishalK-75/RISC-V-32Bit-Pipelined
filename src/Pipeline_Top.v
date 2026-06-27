module Pipeline_Top(input clkh, input rst,
    output [15:0] led,       
    output [7:0] an,          
    output [6:0] seg);
    
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE,
         BranchE, MemWriteM, RegWriteM, ResultSrcM, ResultSrcW,clk;
    wire [2:0] ALUControlE;
    wire [4:0] RdW, RdE, RdM, RS1_E, RS2_E, RS1_D, RS2_D;
    wire [31:0] PCTargetE, InstrD, PCPlus4D, PCD, ResultW, RD1E, RD2E, Imm_ExtE, PCE,
                PCPlus4E, PCPlus4M, ALUResultM, WriteDataM, PCPlus4W, ReadDataW, ALUResultW; 
    wire [1:0] ForwardAE, ForwardBE;       
    wire StallF, StallD, FlushE;
    
    reg [31:0] stable_display_value;

    Fetch_Cycle Fetch(
        .clk(clk), .rst(rst), 
        .PCSrcE(PCSrcE), .StallF(StallF), .StallD(StallD),
        .PCTargetE(PCTargetE), 
        .InstrD(InstrD), .PCPlus4D(PCPlus4D), .PCD(PCD));

    Decode_Cycle Decode(
        .clk(clk), .rst(rst), 
        .FlushE(FlushE), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW), .RdW(RdW), .ResultW(ResultW),
        .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE),
        .RD1E(RD1E), .RD2E(RD2E), .Imm_ExtE(Imm_ExtE), .PCE(PCE), .PCPlus4E(PCPlus4E),
        .RdE(RdE), .RS1_E(RS1_E), .RS2_E(RS2_E), .RS1_D(RS1_D), .RS2_D(RS2_D));

    Execute_Cycle Execute(
        .clk(clk), .rst(rst),
        .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE),
        .RD1E(RD1E), .RD2E(RD2E), .Imm_ExtE(Imm_ExtE), .PCE(PCE), .PCPlus4E(PCPlus4E), .RdE(RdE),
        .PCSrcE(PCSrcE), .MemWriteM(MemWriteM), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM),
        .PCTargetE(PCTargetE), .PCPlus4M(PCPlus4M), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .RdM(RdM),
        .ResultW(ResultW), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE));

    Memory_Cycle Memory(
        .clk(clk), .rst(rst),
        .PCPlus4M(PCPlus4M), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM),
        .MemWriteM(MemWriteM), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .RdM(RdM),
        .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .PCPlus4W(PCPlus4W), 
        .ReadDataW(ReadDataW), .ALUResultW(ALUResultW), .RdW(RdW));

    Writeback_Cycle Writeback(
        .clk(clk), .rst(rst),
        .ResultSrcW(ResultSrcW), .PCPlus4W(PCPlus4W), .ReadDataW(ReadDataW), 
        .ALUResultW(ALUResultW), .ResultW(ResultW));   

    Hazard_Unit Hazard_Unit(
        .rst(rst),
        .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .ResultSrcE(ResultSrcE),
        .Rs1D(RS1_D), .Rs2D(RS2_D), .Rs1E(RS1_E), .Rs2E(RS2_E),
        .RdE(RdE), .RdM(RdM), .RdW(RdW),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
        .StallF(StallF), .StallD(StallD), .FlushE(FlushE));   
    
    always @(posedge clkh or posedge rst) begin
     if (rst) begin
        stable_display_value <= 32'b0;
        end 
        else begin
        stable_display_value <= PCD; 
     end
    end
    
    seven_seg seven_seg(
            .clkh(clkh),                 
            .display_value(stable_display_value), 
            .an(an),
            .seg(seg));  
            
    clk_div clk_div(
    .clkh(clkh),
    .rst(rst),
    .clk(clk)); 
    
    assign led = PCD[15:0];       
endmodule